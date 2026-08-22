import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

// POST /api/pharmacy/dispense
// Dispenses a drug to a patient, deducts stock, and creates a
// matching invoice line item — in a single transaction so stock
// and billing can never drift out of sync.
export async function POST(req: NextRequest) {
  const body = await req.json();
  const { patientId, drugId, quantity, dispensedById } = body;

  if (!patientId || !drugId || !quantity || !dispensedById) {
    return NextResponse.json(
      { error: "patientId, drugId, quantity, and dispensedById are required" },
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

  const result = await prisma.$transaction(async (tx) => {
    const dispense = await tx.pharmacyDispense.create({
      data: { patientId, drugId, quantity, dispensedById },
    });

    await tx.drug.update({
      where: { id: drugId },
      data: { stockQty: { decrement: quantity } },
    });

    let invoice = await tx.invoice.findFirst({
      where: { patientId, status: "UNPAID" },
    });
    if (!invoice) {
      invoice = await tx.invoice.create({ data: { patientId } });
    }

    await tx.invoiceItem.create({
      data: {
        invoiceId: invoice.id,
        description: `${drug.name} x${quantity}`,
        amount: Number(drug.unitPrice) * quantity,
        dispenseId: dispense.id,
      },
    });

    return dispense;
  });

  return NextResponse.json({ dispense: result }, { status: 201 });
}
