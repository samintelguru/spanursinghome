import { NextRequest, NextResponse } from "next/server";
import { Prisma, PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";
import { PatientInputError, parsePatientInput } from "@/lib/patient";
import { findDuplicatePatient } from "@/lib/patient-duplicates";

const prisma = new PrismaClient();

// PATCH /api/patients/[id] — update registration details.
// The file number never changes here. Send the full set of fields (the edit
// form does); anything blank is cleared.
export async function PATCH(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  if (!session || !can(role, "registersPatients")) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { id } = await params;

  try {
    const body = await req.json().catch(() => ({}));
    const input = parsePatientInput(body);

    const existing = await prisma.patient.findUnique({ where: { id }, select: { id: true } });
    if (!existing) return NextResponse.json({ error: "Patient not found" }, { status: 404 });

    if (body?.confirmDuplicate !== true) {
      const dup = await findDuplicatePatient(prisma, input, id);
      if (dup) {
        return NextResponse.json(
          { error: `Another patient matches these details (${dup.reason}).`, duplicate: dup },
          { status: 409 }
        );
      }
    }

    const patient = await prisma.patient.update({ where: { id }, data: input });
    return NextResponse.json({ patient });
  } catch (err) {
    if (err instanceof PatientInputError) {
      return NextResponse.json({ error: err.message }, { status: 400 });
    }
    if (err instanceof Prisma.PrismaClientKnownRequestError && err.code === "P2025") {
      return NextResponse.json({ error: "Patient not found" }, { status: 404 });
    }
    console.error("PATCH /api/patients/[id] failed:", err);
    return NextResponse.json({ error: "Something went wrong. Please try again." }, { status: 500 });
  }
}
