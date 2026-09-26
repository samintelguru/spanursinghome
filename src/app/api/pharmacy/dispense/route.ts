import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";

const prisma = new PrismaClient();

class InsufficientStock extends Error {
  left: number;
  unit: string;
  constructor(left: number, unit: string) {
    super("Insufficient stock");
    this.left = left;
    this.unit = unit;
  }
}

// POST /api/pharmacy/dispense
// Dispenses a drug to a patient, deducts stock, and creates a
// matching invoice line item — in a single transaction so stock
// and billing can never drift out of sync.
export async function POST(req: NextRequest) {
    const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  if (!session || !can(role, "dispensesDrugs")) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
  const dispensedById = (session.user as { id?: string })?.id;

  const body = await req.json();
  const { patientId, drugId } = body;
  const quantity = Number(body.quantity);

  if (!patientId || !drugId || !dispensedById) {
    return NextResponse.json(
      { error: "patientId, drugId, and quantity are required" },
      { status: 400 }
    );
  }
  if (!Number.isInteger(quantity) || quantity < 1 || quantity > 100000) {
    return NextResponse.json(
      { error: "Quantity must be a whole number of 1 or more" },
      { status: 400 }
    );
  }

  const drug = await prisma.drug.findUnique({ where: { id: drugId } });
  if (!drug) {
    return NextResponse.json({ error: "Drug not found" }, { status: 404 });
  }
  if (drug.stockQty < quantity) {
    return NextResponse.json(
      { error: `Insufficient stock: only ${drug.stockQty} ${drug.unit}(s) left` },
      { status: 409 }
    );
  }

  try {
    const result = await prisma.$transaction(async (tx) => {
      // Take the stock first, atomically: the update only succeeds if enough is
      // still on the shelf, so two people dispensing the last packs at the same
      // moment can't both succeed and push stock below zero.
      const taken = await tx.drug.updateMany({
        where: { id: drugId, stockQty: { gte: quantity } },
        data: { stockQty: { decrement: quantity } },
      });
      if (taken.count === 0) {
        const now = await tx.drug.findUnique({ where: { id: drugId } });
        throw new InsufficientStock(now?.stockQty ?? 0, drug.unit);
      }

      const dispense = await tx.pharmacyDispense.create({
        data: { patientId, drugId, quantity, dispensedById },
      });

      // Reuse the patient's open unpaid invoice — locked, so a payment being
      // recorded on it at the same moment can't slip past.
      let invoice = await tx.invoice.findFirst({
        where: { patientId, status: "UNPAID" },
      });
      if (invoice) {
        await tx.$queryRaw`SELECT id FROM "Invoice" WHERE id = ${invoice.id} FOR UPDATE`;
        invoice = await tx.invoice.findFirst({ where: { id: invoice.id, status: "UNPAID" } });
      }
      if (!invoice) {
        invoice = await tx.invoice.create({ data: { patientId } });
      }

      await tx.invoiceItem.create({
        data: {
          invoiceId: invoice.id,
          description: `${drug.name} x${quantity}`,
          amount: Math.round(Number(drug.unitPrice) * 100 * quantity) / 100,
          dispenseId: dispense.id,
        },
      });

      return dispense;
    });

    return NextResponse.json({ dispense: result }, { status: 201 });
  } catch (err) {
    if (err instanceof InsufficientStock) {
      return NextResponse.json(
        { error: `Insufficient stock: only ${err.left} ${err.unit.toLowerCase()} left` },
        { status: 409 }
      );
    }
    console.error("POST /api/pharmacy/dispense failed:", err);
    return NextResponse.json({ error: "Something went wrong. Please try again." }, { status: 500 });
  }
}
