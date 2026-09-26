import { NextRequest, NextResponse } from "next/server";
import { Prisma, PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";
import { nextFileNumber } from "@/lib/file-number";
import { PatientInputError, parseLegacyFileNumber, parsePatientInput } from "@/lib/patient";
import { findDuplicatePatient } from "@/lib/patient-duplicates";
import { can } from "@/lib/permissions";

const prisma = new PrismaClient();

// Lists and the patient picker only need these — keep clinical and ID details
// out of search results.
const LIST_FIELDS = {
  id: true,
  fileNumber: true,
  fullName: true,
  gender: true,
  dateOfBirth: true,
  phone: true,
  createdAt: true,
} as const;

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
      select: LIST_FIELDS,
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
      ...(t.length >= 4 ? [{ idNumber: { contains: t, mode: "insensitive" as const } }] : []),
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
    select: LIST_FIELDS,
  });

  let patients = best;
  if (best.length < limit) {
    const rest = await prisma.patient.findMany({
      where: { AND: [matchesAll, { id: { notIn: best.map((p) => p.id) } }] },
      orderBy: { fullName: "asc" },
      take: limit - best.length,
      select: LIST_FIELDS,
    });
    patients = [...best, ...rest];
  }

  return NextResponse.json({ patients });
}

// POST /api/patients
// The file number is assigned automatically (SPA-2026-00001, ...). Only when a
// patient is being re-entered from the old system can staff supply that
// patient's existing number as "legacyFileNumber".
export async function POST(req: NextRequest) {
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  if (!session || !can(role, "registersPatients")) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
  const staffId = (session.user as { id?: string })?.id ?? null;

  try {
    const body = await req.json().catch(() => ({}));
    const input = parsePatientInput(body);
    const legacyFileNumber = parseLegacyFileNumber(body?.legacyFileNumber);

    if (legacyFileNumber) {
      const taken = await prisma.patient.findUnique({
        where: { fileNumber: legacyFileNumber },
        select: { fullName: true },
      });
      if (taken) {
        return NextResponse.json(
          { error: `File number ${legacyFileNumber} already belongs to ${taken.fullName}` },
          { status: 409 }
        );
      }
    }

    // Warn about probable duplicates (same ID number, or same name + birth date)
    // unless staff have looked and confirmed this is a different person.
    if (body?.confirmDuplicate !== true) {
      const dup = await findDuplicatePatient(prisma, input);
      if (dup) {
        return NextResponse.json(
          {
            error: `This patient may already be registered (${dup.reason}).`,
            duplicate: dup,
          },
          { status: 409 }
        );
      }
    }

    const patient = await prisma.$transaction(async (tx) => {
      const fileNumber = legacyFileNumber ?? (await nextFileNumber(tx));
      return tx.patient.create({
        data: { fileNumber, ...input, admittedById: staffId },
      });
    });

    return NextResponse.json({ patient }, { status: 201 });
  } catch (err) {
    if (err instanceof PatientInputError) {
      return NextResponse.json({ error: err.message }, { status: 400 });
    }
    if (err instanceof Prisma.PrismaClientKnownRequestError && err.code === "P2002") {
      return NextResponse.json(
        { error: "That file number was just taken — please try again" },
        { status: 409 }
      );
    }
    console.error("POST /api/patients failed:", err);
    return NextResponse.json({ error: "Something went wrong. Please try again." }, { status: 500 });
  }
}
