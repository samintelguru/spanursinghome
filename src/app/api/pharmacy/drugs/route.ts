import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";

const prisma = new PrismaClient();

export async function GET() {
  const session = await auth();
  if (!session) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const drugs = await prisma.drug.findMany({
    orderBy: { name: "asc" },
  });

  return NextResponse.json({ drugs });
}

export async function POST(req: NextRequest) {
    const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  if (!session || !can(role, "managesPharmacyInventory")) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const body = await req.json();
  const { name, unit, unitPrice, stockQty, reorderAt } = body;

  if (!name || !unit || unitPrice === undefined || stockQty === undefined) {
    return NextResponse.json(
      { error: "name, unit, unitPrice, and stockQty are required" },
      { status: 400 }
    );
  }

  const drug = await prisma.drug.create({
    data: {
      name,
      unit,
      unitPrice,
      stockQty: Number(stockQty),
      reorderAt: reorderAt !== undefined ? Number(reorderAt) : 10,
    },
  });

  return NextResponse.json({ drug }, { status: 201 });
}