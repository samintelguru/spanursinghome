// Server-only: hands out the next patient file number.
import type { Prisma } from "@prisma/client";
import { dayKeyEAT } from "@/lib/billing";
import { FILE_NUMBER_INCLUDES_YEAR, formatFileNumber } from "@/lib/patient";

// Must be called inside a transaction. The counter bump is one atomic SQL
// statement, so two receptionists registering at the same instant can never
// receive the same number — and if the registration fails, the number goes
// back (the counter change rolls back with it), so there are no gaps.
export async function nextFileNumber(tx: Prisma.TransactionClient): Promise<string> {
  const year = Number(dayKeyEAT(new Date()).slice(0, 4));
  const key = FILE_NUMBER_INCLUDES_YEAR ? `patient-file-${year}` : "patient-file";

  // Skip any number someone already typed in by hand as an "old file number".
  for (let i = 0; i < 100; i++) {
    const rows = await tx.$queryRaw<{ value: number }[]>`
      INSERT INTO "Counter" ("key", "value") VALUES (${key}, 1)
      ON CONFLICT ("key") DO UPDATE SET "value" = "Counter"."value" + 1
      RETURNING "value"`;
    const candidate = formatFileNumber(Number(rows[0].value), year);
    const taken = await tx.patient.findUnique({ where: { fileNumber: candidate }, select: { id: true } });
    if (!taken) return candidate;
  }
  throw new Error("Could not allocate a file number");
}
