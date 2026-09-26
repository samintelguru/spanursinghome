import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";
import { StockError, parseStockInput } from "@/lib/stock";

const prisma = new PrismaClient();

// POST /api/pharmacy/drugs/[id]/stock
//   Restock:  { kind: "RECEIVED", quantity, supplier?, batchNo?, expiryDate?, unitCost?, note? }
//   Adjust:   { kind: "ADJUSTED", quantity (+ or -), reason, note? }
//
// Stock changes with a single atomic update, so it stays correct even if a
// drug is being dispensed at the same moment, and it can never go below zero.
// Every change is written to the stock ledger with who did it.
export async function POST(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  const staffId = (session?.user as { id?: string })?.id;
  if (!session || !staffId || !can(role, "managesPharmacyInventory")) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { id } = await params;

  try {
    const input = parseStockInput(await req.json().catch(() => ({})));

    const result = await prisma.$transaction(async (tx) => {
      const before = await tx.drug.findUnique({ where: { id } });
      if (!before) throw new StockError(404, "Drug not found");

      if (input.quantity < 0) {
        const removed = -input.quantity;
        const r = await tx.drug.updateMany({
          where: { id, stockQty: { gte: removed } },
          data: { stockQty: { decrement: removed } },
        });
        if (r.count === 0) {
          throw new StockError(
            409,
            `Only ${before.stockQty} ${before.unit.toLowerCase()} in stock — can't remove ${removed}`
          );
        }
      } else {
        await tx.drug.update({ where: { id }, data: { stockQty: { increment: input.quantity } } });
      }

      // Drug keeps one expiry date: the nearest one among the stock on hand.
      // A new batch only moves it earlier, unless the shelf was empty.
      if (input.kind === "RECEIVED" && input.expiryDate) {
        const keepOld =
          before.expiryDate && before.stockQty > 0 && before.expiryDate <= input.expiryDate;
        if (!keepOld) {
          await tx.drug.update({ where: { id }, data: { expiryDate: input.expiryDate } });
        }
      }

      const drug = await tx.drug.findUniqueOrThrow({ where: { id } });

      const movement = await tx.stockMovement.create({
        data: {
          drugId: id,
          kind: input.kind,
          quantity: input.quantity,
          stockAfter: drug.stockQty,
          supplier: input.supplier,
          batchNo: input.batchNo,
          expiryDate: input.expiryDate,
          unitCost: input.unitCost,
          reason: input.reason,
          note: input.note,
          recordedById: staffId,
        },
      });

      return { drug, movement };
    });

    return NextResponse.json(result, { status: 201 });
  } catch (err) {
    if (err instanceof StockError) {
      return NextResponse.json({ error: err.message }, { status: err.status });
    }
    console.error("POST /api/pharmacy/drugs/[id]/stock failed:", err);
    return NextResponse.json({ error: "Something went wrong. Please try again." }, { status: 500 });
  }
}
