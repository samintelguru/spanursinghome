import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";

const prisma = new PrismaClient();

// GET /api/blood-bank — list stock levels by blood type
export async function GET() {
  const session = await auth();
  if (!session) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const stock = await prisma.bloodStock.findMany({
    orderBy: { bloodType: "asc" },
  });

  return NextResponse.json({ stock });
}

// POST /api/blood-bank — add units to a blood type (creates the type if new)
export async function POST(req: NextRequest) {
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  if (!session || !can(role, "managesBloodStock")) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const body = await req.json();
  const { bloodType, units } = body;

  if (!bloodType || !units) {
    return NextResponse.json(
      { error: "bloodType and units are required" },
      { status: 400 }
    );
  }

  const existing = await prisma.bloodStock.findFirst({ where: { bloodType } });

  const stock = existing
    ? await prisma.bloodStock.update({
        where: { id: existing.id },
        data: { unitsHeld: { increment: Number(units) } },
      })
    : await prisma.bloodStock.create({
        data: { bloodType, unitsHeld: Number(units) },
      });

  return NextResponse.json({ stock }, { status: 201 });
}