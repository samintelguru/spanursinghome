import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";
import { EquipmentError, computeNextService, parseEquipmentInput } from "@/lib/equipment";

const prisma = new PrismaClient();

// PATCH /api/equipment/[id] — update details. The asset tag never changes.
// Send the full set of fields (the edit form does); blanks are cleared.
export async function PATCH(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  if (!session || !can(role, "managesEquipment")) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
  const { id } = await params;

  try {
    const input = parseEquipmentInput(await req.json().catch(() => ({})));

    const existing = await prisma.equipment.findUnique({ where: { id }, select: { id: true } });
    if (!existing) return NextResponse.json({ error: "Equipment not found" }, { status: 404 });

    if (input.serialNumber) {
      const dup = await prisma.equipment.findFirst({
        where: { id: { not: id }, serialNumber: { equals: input.serialNumber, mode: "insensitive" } },
        select: { assetTag: true, name: true },
      });
      if (dup) {
        return NextResponse.json(
          { error: `That serial number is already registered (${dup.assetTag} — ${dup.name})` },
          { status: 409 }
        );
      }
    }

    const nextServiceDue = computeNextService(input.serviceIntervalMonths, input.lastServiceDate, input.purchaseDate);
    const equipment = await prisma.equipment.update({ where: { id }, data: { ...input, nextServiceDue } });
    return NextResponse.json({ equipment });
  } catch (err) {
    if (err instanceof EquipmentError) return NextResponse.json({ error: err.message }, { status: err.status });
    console.error("PATCH /api/equipment/[id] failed:", err);
    return NextResponse.json({ error: "Something went wrong. Please try again." }, { status: 500 });
  }
}

// DELETE /api/equipment/[id] — administrators only, and only for records made
// by mistake. Anything with service history should be marked "Disposed" instead.
export async function DELETE(
  _req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  if (!session || role !== "ADMIN") {
    return NextResponse.json({ error: "Only administrators can delete equipment records" }, { status: 401 });
  }
  const { id } = await params;

  const logs = await prisma.equipmentService.count({ where: { equipmentId: id } });
  if (logs > 0) {
    return NextResponse.json(
      { error: "This item has service history. Set its status to “Disposed” instead of deleting it." },
      { status: 409 }
    );
  }
  try {
    await prisma.equipment.delete({ where: { id } });
    return NextResponse.json({ ok: true });
  } catch {
    return NextResponse.json({ error: "Equipment not found" }, { status: 404 });
  }
}
