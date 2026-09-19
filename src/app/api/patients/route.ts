import { NextRequest, NextResponse } from "next/server";
import { Prisma, PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";

const prisma = new PrismaClient();

// GET /api/patients?q=...&limit=...
//
// Search is "type the start of a name": every word you type must match the
// START of a word in the patient's name (so "j" finds John Kamau and Mary
// Jane), or appear in the file number, or (3+ characters) in the phone number.
// Patients whose name STARTS with what you typed come first, then the rest,
// each group A–Z. With no q it returns the most recently registered patients.
export async function GET(req: NextRequest) {
  const session = await auth();
  if (!session) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const q = req.nextUrl.searchParams.get("q")?.trim();
  const limitParam = Number(req.nextUrl.searchParams.get("limit"));
  const hasLimit = Number.isFinite(limitParam) && limitParam > 0;

  // No search text: newest first (unchanged behaviour; capped only if asked).
  if (!q) {
    const patients = await prisma.patient.findMany({
      orderBy: { createdAt: "desc" },
      take: hasLimit ? Math.min(limitParam, 200) : undefined,
    });
    return NextResponse.json({ patients });
  }

  const limit = hasLimit ? Math.min(limitParam, 100) : 50;
  const tokens = q.split(/\s+/).filter(Boolean).slice(0, 4);

  const tokenMatch = (t: string): Prisma.PatientWhereInput => ({
    OR: [
      { fullName: { startsWith: t, mode: "insensitive" } },
      { fullName: { contains: ` ${t}`, mode: "insensitive" } }, // a later word starts with t
      { fileNumber: { contains: t, mode: "insensitive" } },
      ...(t.length >= 3 ? [{ phone: { contains: t } }] : []),
    ],
  });

  const matchesAll: Prisma.PatientWhereInput = { AND: tokens.map(tokenMatch) };
  const nameStartsWithQuery: Prisma.PatientWhereInput = {
    AND: [
      { fullName: { startsWith: tokens[0], mode: "insensitive" } },
      ...tokens.slice(1).map(tokenMatch),
    ],
  };

  const best = await prisma.patient.findMany({
    where: nameStartsWithQuery,
    orderBy: { fullName: "asc" },
    take: limit,
  });

  let patients = best;
  if (best.length < limit) {
    const rest = await prisma.patient.findMany({
      where: { AND: [matchesAll, { id: { notIn: best.map((p) => p.id) } }] },
      orderBy: { fullName: "asc" },
      take: limit - best.length,
    });
    patients = [...best, ...rest];
  }

  return NextResponse.json({ patients });
}

export async function POST(req: NextRequest) {
   const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  if (!session || !can(role, "registersPatients")) {
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