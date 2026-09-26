import { NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";

const prisma = new PrismaClient();

type Entry = {
  id: string;
  at: Date;
  type: "RECEIVED" | "ADJUSTED" | "DISPENSED";
  quantity: number; // signed
  stockAfter: number | null;
  by: string | null;
  detail: string;
};

// GET /api/pharmacy/drugs/[id]/history
// Everything that changed this drug's stock, newest first: restocks,
// adjustments and dispenses.
export async function GET(
  _req: Request,
  { params }: { params: Promise<{ id: string }> }
) {
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  if (!session || !can(role, "managesPharmacyInventory")) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { id } = await params;

  const [movements, dispenses] = await Promise.all([
    prisma.stockMovement.findMany({
      where: { drugId: id },
      orderBy: { createdAt: "desc" },
      take: 50,
      include: { recordedBy: { select: { fullName: true } } },
    }),
    prisma.pharmacyDispense.findMany({
      where: { drugId: id },
      orderBy: { dispensedAt: "desc" },
      take: 50,
      include: {
        patient: { select: { fullName: true, fileNumber: true } },
        dispensedBy: { select: { fullName: true } },
      },
    }),
  ]);

  const entries: Entry[] = [
    ...movements.map((m): Entry => ({
      id: m.id,
      at: m.createdAt,
      type: m.kind,
      quantity: m.quantity,
      stockAfter: m.stockAfter,
      by: m.recordedBy.fullName,
      detail:
        m.kind === "RECEIVED"
          ? [
              m.supplier && `From ${m.supplier}`,
              m.batchNo && `Batch ${m.batchNo}`,
              m.expiryDate && `Expires ${m.expiryDate.toISOString().slice(0, 10)}`,
              m.unitCost && `Cost ${Number(m.unitCost).toFixed(2)} each`,
              m.note,
            ]
              .filter(Boolean)
              .join(" · ")
          : [m.reason, m.note].filter(Boolean).join(" — "),
    })),
    ...dispenses.map((d): Entry => ({
      id: d.id,
      at: d.dispensedAt,
      type: "DISPENSED",
      quantity: -d.quantity,
      stockAfter: null,
      by: d.dispensedBy.fullName,
      detail: `To ${d.patient.fullName} (${d.patient.fileNumber})`,
    })),
  ]
    .sort((a, b) => b.at.getTime() - a.at.getTime())
    .slice(0, 50);

  return NextResponse.json({ entries });
}
