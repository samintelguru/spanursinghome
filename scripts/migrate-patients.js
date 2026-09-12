const mysql = require("mysql2/promise");
const { PrismaClient } = require("@prisma/client");

const prisma = new PrismaClient();

const LEGACY_DB = {
  host: "localhost",
  user: "root",
  password: "",
  database: "spa_legacy_hms",
};

async function main() {
  const legacy = await mysql.createConnection(LEGACY_DB);

  const [rows] = await legacy.execute(
    "SELECT id, patient_name, dob, gender, mobileno, blood_group, guardian_name FROM patients"
  );

  console.log(`Found ${rows.length} legacy patients. Migrating...`);

  let created = 0;
  let skipped = 0;

  for (const row of rows) {
    if (!row.patient_name || !row.dob) {
      skipped++;
      continue;
    }

    const fileNumber = `LEGACY-${row.id}`;
    const gender = (row.gender || "").toLowerCase().startsWith("m") ? "MALE" : "FEMALE";
    const bloodType = row.blood_group && row.blood_group.trim() !== "" ? row.blood_group.trim() : null;

    await prisma.patient.upsert({
      where: { fileNumber },
      update: {},
      create: {
        fileNumber,
        fullName: row.patient_name,
        gender,
        dateOfBirth: new Date(row.dob),
        phone: row.mobileno || null,
        nextOfKin: row.guardian_name || null,
        bloodType,
      },
    });

    created++;
  }

  console.log(`Done. Created/verified ${created} patients, skipped ${skipped} (missing name or DOB).`);

  await legacy.end();
  await prisma.$disconnect();
}

main().catch((err) => {
  console.error("Migration failed:", err);
  process.exit(1);
});