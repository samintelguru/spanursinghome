import { NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";

const prisma = new PrismaClient();

export async function GET() {
  const session = await auth();
  if (!session) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const [allDrugs, lowBlood] = await Promise.all([
    prisma.drug.findMany(),
    prisma.bloodStock.findMany({ where: { unitsHeld: { lte: 2 } } }),
  ]);

  const lowDrugs = allDrugs.filter((d) => d.stockQty <= d.reorderAt);

  return NextResponse.json({
    lowDrugs,
    lowBlood,
    totalAlerts: lowDrugs.length + lowBlood.length,
  });
}