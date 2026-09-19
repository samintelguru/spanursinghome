// One-off: create an open Admission row for every patient currently sitting in
// an OCCUPIED bed, so beds admitted BEFORE the Admission table existed still
// show up in patient history and can be closed properly on discharge.
// Safe to re-run: skips beds that already have an open Admission.
//
// Run:  node scripts/backfill-admissions.js
const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

async function main() {
  const beds = await prisma.bed.findMany({
    where: { status: "OCCUPIED", patientId: { not: null } },
  });
  console.log(`Found ${beds.length} occupied bed(s).`);

  let created = 0;
  let skipped = 0;
  for (const bed of beds) {
    const open = await prisma.admission.findFirst({
      where: { bedId: bed.id, dischargedAt: null },
    });
    if (open) {
      skipped++;
      continue;
    }
    await prisma.admission.create({
      data: {
        patientId: bed.patientId,
        bedId: bed.id,
        admittedAt: bed.admittedAt ?? new Date(),
        admittedById: bed.staffId ?? null,
      },
    });
    created++;
  }
  console.log(`Created ${created}, skipped ${skipped}.`);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(() => prisma.$disconnect());
