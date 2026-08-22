import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";

const prisma = new PrismaClient();

export async function GET() {
  const session = await auth();
  if (!session) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const patients = await prisma.patient.findMany({
    orderBy: { createdAt: "desc" },
  });

  return NextResponse.json({ patients });
}

export async function POST(req: NextRequest) {
  const session = await auth();
  if (!session) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const body = await req.json();
  const { fileNumber, fullName, gender, dateOfBirth, phone, nextOfKin } = body;

  if (!fileNumber || !fullName || !gender || !dateOfBirth) {
    return NextResponse.json(
      { error: "fileNumber, fullName, gender, and dateOfBirth are required" },
      { status: 400 }
    );
  }

  const existing = await prisma.patient.findUnique({ where: { fileNumber } });
  if (existing) {
    return NextResponse.json(
      { error: `A patient with file number ${fileNumber} already exists` },
      { status: 409 }
    );
  }

  const staffId = (session.user as { id?: string })?.id;

  const patient = await prisma.patient.create({
    data: {
      fileNumber,
      fullName,
      gender,
      dateOfBirth: new Date(dateOfBirth),
      phone: phone || null,
      nextOfKin: nextOfKin || null,
      admittedById: staffId || null,
    },
  });

  return NextResponse.json({ patient }, { status: 201 });
}