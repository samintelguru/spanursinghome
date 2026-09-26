import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";

const prisma = new PrismaClient();

// DELETE /api/pharmacy/drug-types/[id] — only when no drug uses the type.
export async function DELETE(
  _req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  if (!session || !can(role, "managesPharmacyInventory")) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { id } = await params;
  const type = await prisma.drugType.findUnique({ where: { id } });
  if (!type) return NextResponse.json({ error: "Type not found" }, { status: 404 });

  const inUse = await prisma.drug.count({
    where: { unit: { equals: type.name, mode: "insensitive" } },
  });
  if (inUse > 0) {
    return NextResponse.json(
      {
        error: `${inUse} drug${inUse === 1 ? " uses" : "s use"} "${type.name}". Change ${
          inUse === 1 ? "its" : "their"
        } type first, then delete it.`,
      },
      { status: 409 }
    );
  }

  await prisma.drugType.delete({ where: { id } });
  return NextResponse.json({ ok: true });
}
