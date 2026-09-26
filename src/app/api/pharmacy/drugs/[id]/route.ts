import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";
import { findDrugType } from "@/lib/drug-types";

const prisma = new PrismaClient();

// PATCH /api/pharmacy/drugs/[id]   body: { name?, unit?, unitPrice?, reorderAt? }
// Fix a drug's name, type, price or reorder level. Stock is not changed here.
// A new price applies to future dispenses only — invoices already raised keep
// the price they were billed at.
export async function PATCH(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  if (!session || !can(role, "managesPharmacyInventory")) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { id } = await params;
  const body = await req.json().catch(() => ({}));
  const drug = await prisma.drug.findUnique({ where: { id } });
  if (!drug) return NextResponse.json({ error: "Drug not found" }, { status: 404 });

  const data: { name?: string; unit?: string; unitPrice?: number; reorderAt?: number } = {};

  if (body.name !== undefined) {
    const name = typeof body.name === "string" ? body.name.replace(/\s+/g, " ").trim() : "";
    if (name.length < 2 || name.length > 100) {
      return NextResponse.json({ error: "Enter the drug name (2 to 100 characters)" }, { status: 400 });
    }
    data.name = name;
  }
  if (body.unit !== undefined) {
    const type = await findDrugType(prisma, String(body.unit).trim());
    if (!type) return NextResponse.json({ error: "Choose a drug type from the list" }, { status: 400 });
    data.unit = type.name;
  }
  if (body.unitPrice !== undefined) {
    const price = Number(body.unitPrice);
    if (!Number.isFinite(price) || price < 0 || price > 10_000_000) {
      return NextResponse.json({ error: "Enter a valid unit price" }, { status: 400 });
    }
    data.unitPrice = price;
  }
  if (body.reorderAt !== undefined) {
    const r = Number(body.reorderAt);
    if (!Number.isInteger(r) || r < 0 || r > 1_000_000) {
      return NextResponse.json({ error: "Reorder level must be a whole number, 0 or more" }, { status: 400 });
    }
    data.reorderAt = r;
  }

  if (Object.keys(data).length === 0) {
    return NextResponse.json({ error: "Nothing to update" }, { status: 400 });
  }

  const finalName = data.name ?? drug.name;
  const finalUnit = data.unit ?? drug.unit;
  const clash = await prisma.drug.findFirst({
    where: {
      id: { not: id },
      name: { equals: finalName, mode: "insensitive" },
      unit: { equals: finalUnit, mode: "insensitive" },
    },
  });
  if (clash) {
    return NextResponse.json({ error: `${finalName} (${finalUnit}) is already in the inventory` }, { status: 409 });
  }

  const updated = await prisma.drug.update({ where: { id }, data });
  return NextResponse.json({ drug: updated });
}
