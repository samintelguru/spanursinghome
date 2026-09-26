import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";
import { findDrugType } from "@/lib/drug-types";

const prisma = new PrismaClient();

export async function GET() {
  const session = await auth();
  if (!session) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
  const role = (session.user as { role?: string })?.role;

  const drugs = await prisma.drug.findMany({
    orderBy: { name: "asc" },
  });

  return NextResponse.json({ drugs, canManage: can(role, "managesPharmacyInventory") });
}

export async function POST(req: NextRequest) {
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  if (!session || !can(role, "managesPharmacyInventory")) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const body = await req.json().catch(() => ({}));
  const name = typeof body.name === "string" ? body.name.replace(/\s+/g, " ").trim() : "";
  const unitPrice = Number(body.unitPrice);
  const stockQty = Number(body.stockQty);
  const reorderAt = body.reorderAt === undefined || body.reorderAt === "" ? 10 : Number(body.reorderAt);

  if (name.length < 2 || name.length > 100) {
    return NextResponse.json({ error: "Enter the drug name (2 to 100 characters)" }, { status: 400 });
  }
  if (!Number.isFinite(unitPrice) || unitPrice < 0 || unitPrice > 10_000_000) {
    return NextResponse.json({ error: "Enter a valid unit price" }, { status: 400 });
  }
  if (!Number.isInteger(stockQty) || stockQty < 0 || stockQty > 10_000_000) {
    return NextResponse.json({ error: "Starting stock must be a whole number, 0 or more" }, { status: 400 });
  }
  if (!Number.isInteger(reorderAt) || reorderAt < 0 || reorderAt > 1_000_000) {
    return NextResponse.json({ error: "Reorder level must be a whole number, 0 or more" }, { status: 400 });
  }

  const type = await findDrugType(prisma, String(body.unit ?? "").trim());
  if (!type) {
    return NextResponse.json(
      { error: "Choose a drug type from the list (use “Add new type…” if it isn't there)" },
      { status: 400 }
    );
  }

  const duplicate = await prisma.drug.findFirst({
    where: {
      name: { equals: name, mode: "insensitive" },
      unit: { equals: type.name, mode: "insensitive" },
    },
  });
  if (duplicate) {
    return NextResponse.json(
      { error: `${name} (${type.name}) is already in the inventory` },
      { status: 409 }
    );
  }

  const drug = await prisma.drug.create({
    data: { name, unit: type.name, unitPrice, stockQty, reorderAt },
  });

  return NextResponse.json({ drug }, { status: 201 });
}
