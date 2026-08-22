import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";

const prisma = new PrismaClient();

export async function POST(req: NextRequest) {
  const session = await auth();
  if (!session) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
  const issuedById = (session.user as { id?: string })?.id;

  const body = await req.json();
  const { bloodStockId, patientId, units } = body;

  if (!bloodStockId || !patientId || !units || !issuedById) {
    return NextResponse.json(
      { error: "bloodStockId, patientId, and units are required" },
      { status: 400 }
    );
  }

  const stock = await prisma.bloodStock.findUnique({
    where: { id: bloodStockId },
  });
  if (!stock) {
    return NextResponse.json({ error: "Blood stock not found" }, { status: 404 });
  }
  if (stock.unitsHeld < units) {
    return NextResponse.json(
      { error: `Insufficient stock: only ${stock.unitsHeld} unit(s) of ${stock.bloodType} left` },
      { status: 409 }
    );
  }

  const result = await prisma.$transaction(async (tx) => {
    const issue = await tx.bloodIssue.create({
      data: { bloodStockId, patientId, units, issuedById },
    });

    await tx.bloodStock.update({
      where: { id: bloodStockId },
      data: { unitsHeld: { decrement: units } },
    });

    return issue;
  });

  return NextResponse.json({ issue: result }, { status: 201 });
}