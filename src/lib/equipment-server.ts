// Server-only: hands out the next equipment asset tag (EQ-0001, EQ-0002, ...).
import type { Prisma } from "@prisma/client";

// Call inside a transaction. The counter bump is a single atomic statement, so
// two people adding equipment at once never get the same tag, and a failed
// save gives the number back.
export async function nextAssetTag(tx: Prisma.TransactionClient): Promise<string> {
  for (let i = 0; i < 100; i++) {
    const rows = await tx.$queryRaw<{ value: number }[]>`
      INSERT INTO "Counter" ("key", "value") VALUES ('equipment-tag', 1)
      ON CONFLICT ("key") DO UPDATE SET "value" = "Counter"."value" + 1
      RETURNING "value"`;
    const candidate = `EQ-${String(Number(rows[0].value)).padStart(4, "0")}`;
    // Skip any tag someone already typed in by hand.
    const taken = await tx.equipment.findUnique({ where: { assetTag: candidate }, select: { id: true } });
    if (!taken) return candidate;
  }
  throw new Error("Could not allocate an asset tag");
}
