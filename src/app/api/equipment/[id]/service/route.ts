import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";
import { EquipmentError, computeNextService, parseServiceInput, type EquipmentStatusValue } from "@/lib/equipment";

const prisma = new PrismaClient();

// POST /api/equipment/[id]/service
// body: { kind, performedOn, performedBy?, cost?, notes?, statusAfter? }
// Routine services, calibrations and inspections reset the service schedule
// (next due = date done + the item's service interval). A repair is logged but
// doesn't move the schedule. statusAfter lets you flip an item back to
// "In use" (or to "Out of service") in the same step.
export async function POST(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  const staffId = (session?.user as { id?: string })?.id;
  if (!session || !staffId || !can(role, "managesEquipment")) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
  const { id } = await params;

  try {
    const input = parseServiceInput(await req.json().catch(() => ({})));

    const result = await prisma.$transaction(async (tx) => {
      const eq = await tx.equipment.findUnique({ where: { id } });
      if (!eq) throw new EquipmentError(404, "Equipment not found");
      if (eq.purchaseDate && input.performedOn < eq.purchaseDate) {
        throw new EquipmentError(400, "That date is before the equipment was purchased");
      }

      const log = await tx.equipmentService.create({
        data: {
          equipmentId: id,
          kind: input.kind,
          performedOn: input.performedOn,
          performedBy: input.performedBy,
          cost: input.cost,
          notes: input.notes,
          recordedById: staffId,
        },
      });

      const data: {
        lastServiceDate?: Date;
        nextServiceDue?: Date | null;
        status?: EquipmentStatusValue;
      } = {};

      if (input.kind !== "REPAIR" && (!eq.lastServiceDate || input.performedOn > eq.lastServiceDate)) {
        data.lastServiceDate = input.performedOn;
        data.nextServiceDue = computeNextService(eq.serviceIntervalMonths, input.performedOn, eq.purchaseDate);
      }
      if (input.statusAfter) data.status = input.statusAfter;

      const equipment = Object.keys(data).length
        ? await tx.equipment.update({ where: { id }, data })
        : eq;

      return { log, equipment };
    });

    return NextResponse.json(result, { status: 201 });
  } catch (err) {
    if (err instanceof EquipmentError) return NextResponse.json({ error: err.message }, { status: err.status });
    console.error("POST /api/equipment/[id]/service failed:", err);
    return NextResponse.json({ error: "Something went wrong. Please try again." }, { status: 500 });
  }
}
