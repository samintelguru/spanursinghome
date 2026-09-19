import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";

const prisma = new PrismaClient();

type Failure = { error: string; status: number };

// PATCH /api/beds/[id] — admit a patient, discharge, or mark cleaned
// Every admit opens an Admission row and every discharge closes it, so the
// patient's full bed history is kept even after the bed is reused.
export async function PATCH(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const session = await auth();
    const role = (session?.user as { role?: string })?.role;
    if (!session || !can(role, "managesBeds")) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }
    const staffId = (session.user as { id?: string }).id ?? null;

    const { id } = await params;
    const body = await req.json();
    const { action, patientId } = body; // action: "admit" | "discharge" | "mark_available"

    if (action !== "admit" && action !== "discharge" && action !== "mark_available") {
      return NextResponse.json({ error: "Invalid action" }, { status: 400 });
    }
    if (action === "admit" && !patientId) {
      return NextResponse.json({ error: "patientId is required to admit" }, { status: 400 });
    }

    const result = await prisma.$transaction(async (tx): Promise<Failure | { bedId: string }> => {
      const now = new Date();

      if (action === "admit") {
        const patient = await tx.patient.findUnique({ where: { id: patientId } });
        if (!patient) return { error: "Patient not found", status: 404 };

        const alreadyAdmitted = await tx.admission.findFirst({
          where: { patientId, dischargedAt: null },
          include: { bed: true },
        });
        if (alreadyAdmitted) {
          return {
            error: `${patient.fullName} is already admitted (${alreadyAdmitted.bed.label})`,
            status: 409,
          };
        }

        // Conditional update: only succeeds if the bed is still AVAILABLE,
        // so two people clicking "admit" at once can't double-book it.
        const claimed = await tx.bed.updateMany({
          where: { id, status: "AVAILABLE" },
          data: { status: "OCCUPIED", patientId, admittedAt: now },
        });
        if (claimed.count === 0) {
          return { error: "This bed is not available", status: 409 };
        }

        await tx.admission.create({
          data: { patientId, bedId: id, admittedAt: now, admittedById: staffId },
        });
        return { bedId: id };
      }

      if (action === "discharge") {
        const released = await tx.bed.updateMany({
          where: { id, status: "OCCUPIED" },
          data: { status: "CLEANING", patientId: null, admittedAt: null },
        });
        if (released.count === 0) {
          return { error: "This bed is not occupied", status: 409 };
        }

        await tx.admission.updateMany({
          where: { bedId: id, dischargedAt: null },
          data: { dischargedAt: now, dischargedById: staffId },
        });
        return { bedId: id };
      }

      // mark_available
      const cleaned = await tx.bed.updateMany({
        where: { id, status: "CLEANING" },
        data: { status: "AVAILABLE" },
      });
      if (cleaned.count === 0) {
        return { error: "This bed is not waiting to be cleaned", status: 409 };
      }
      return { bedId: id };
    });

    if ("error" in result) {
      return NextResponse.json({ error: result.error }, { status: result.status });
    }

    const bed = await prisma.bed.findUnique({ where: { id: result.bedId } });
    return NextResponse.json({ bed });
  } catch (err) {
    console.error("PATCH /api/beds/[id] failed:", err);
    return NextResponse.json(
      { error: "Something went wrong updating the bed" },
      { status: 500 }
    );
  }
}
