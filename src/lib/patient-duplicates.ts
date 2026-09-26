// Server-only: looks for someone who is probably the same person.
import type { Prisma, PrismaClient } from "@prisma/client";
import type { PatientInput } from "@/lib/patient";

export type DuplicateMatch = {
  id: string;
  fullName: string;
  fileNumber: string;
  reason: string;
};

type Db = PrismaClient | Prisma.TransactionClient;

export async function findDuplicatePatient(
  db: Db,
  input: Pick<PatientInput, "fullName" | "dateOfBirth" | "idNumber">,
  excludeId?: string
): Promise<DuplicateMatch | null> {
  const notSelf = excludeId ? { id: { not: excludeId } } : {};

  if (input.idNumber) {
    const byId = await db.patient.findFirst({
      where: { ...notSelf, idNumber: input.idNumber },
      select: { id: true, fullName: true, fileNumber: true },
    });
    if (byId) return { ...byId, reason: "same ID number" };
  }

  const byNameDob = await db.patient.findFirst({
    where: {
      ...notSelf,
      fullName: { equals: input.fullName, mode: "insensitive" },
      dateOfBirth: input.dateOfBirth,
    },
    select: { id: true, fullName: true, fileNumber: true },
  });
  return byNameDob ? { ...byNameDob, reason: "same name and date of birth" } : null;
}
