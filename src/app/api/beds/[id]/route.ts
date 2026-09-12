import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";

const prisma = new PrismaClient();

// PATCH /api/beds/[id] — admit a patient, discharge, or mark cleaned
export async function PATCH(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  if (!session || !can(role, "managesBeds")) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { id } = await params;
  const body = await req.json();
  const { action, patientId } = body; // action: "admit" | "discharge" | "mark_available"

  let data: Record<string, unknown>;

  if (action === "admit") {
    if (!patientId) {
      return NextResponse.json({ error: "patientId is required to admit" }, { status: 400 });
    }
    data = { status: "OCCUPIED", patientId, admittedAt: new Date() };
  } else if (action === "discharge") {
    data = { status: "CLEANING", patientId: null, admittedAt: null };
  } else if (action === "mark_available") {
    data = { status: "AVAILABLE" };
  } else {
    return NextResponse.json({ error: "Invalid action" }, { status: 400 });
  }

  const bed = await (prisma as any).bed.update({ where: { id }, data });
  return NextResponse.json({ bed });
}