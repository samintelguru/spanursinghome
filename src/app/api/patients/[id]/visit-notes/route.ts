import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";

const prisma = new PrismaClient();

export async function GET(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const session = await auth();
  if (!session) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { id: patientId } = await params;

  const notes = await prisma.visitNote.findMany({
    where: { patientId },
    include: { recordedBy: { select: { fullName: true } } },
    orderBy: { createdAt: "desc" },
  });

  return NextResponse.json({ notes });
}

export async function POST(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  if (!session || !can(role, "recordsVisitNotes")) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
  const recordedById = (session.user as { id?: string })?.id;

  const { id: patientId } = await params;
  const body = await req.json();
  const { note, temperatureC, bloodPressure, pulseBpm } = body;

  if (!note) {
    return NextResponse.json({ error: "note is required" }, { status: 400 });
  }

  const visitNote = await prisma.visitNote.create({
    data: {
      patientId,
      recordedById: recordedById!,
      note,
      temperatureC: temperatureC ? Number(temperatureC) : null,
      bloodPressure: bloodPressure || null,
      pulseBpm: pulseBpm ? Number(pulseBpm) : null,
    },
    include: { recordedBy: { select: { fullName: true } } },
  });

  return NextResponse.json({ note: visitNote }, { status: 201 });
}