import { NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";

const prisma = new PrismaClient();

export async function GET() {
  const session = await auth();
  if (!session) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const thirtyDaysAgo = new Date();
  thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);

  const [payments, dispenseGroups] = await Promise.all([
    prisma.payment.findMany({
      where: { paidAt: { gte: thirtyDaysAgo } },
      select: { amount: true, paidAt: true },
    }),
    prisma.pharmacyDispense.groupBy({
      by: ["drugId"],
      _sum: { quantity: true },
      orderBy: { _sum: { quantity: "desc" } },
      take: 5,
    }),
  ]);

  const revenueByDay: Record<string, number> = {};
  for (const p of payments) {
    const day = p.paidAt.toISOString().slice(0, 10);
    revenueByDay[day] = (revenueByDay[day] || 0) + Number(p.amount);
  }
  const revenue = Object.entries(revenueByDay)
    .map(([date, total]) => ({ date, total }))
    .sort((a, b) => a.date.localeCompare(b.date));

  const drugIds = dispenseGroups.map((g) => g.drugId);
  const drugs = await prisma.drug.findMany({ where: { id: { in: drugIds } } });
  const drugNameById = Object.fromEntries(drugs.map((d) => [d.id, d.name]));

  const topDrugs = dispenseGroups.map((g) => ({
    name: drugNameById[g.drugId] || "Unknown",
    quantity: g._sum.quantity || 0,
  }));

  return NextResponse.json({ revenue, topDrugs });
}