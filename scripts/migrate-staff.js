const mysql = require("mysql2/promise");
const { PrismaClient } = require("@prisma/client");
const bcrypt = require("bcryptjs");

const prisma = new PrismaClient();

const LEGACY_DB = {
  host: "localhost",
  user: "root",
  password: "",
  database: "spa_legacy_hms",
};

const TEMP_PASSWORD = "ChangeMe123!";

async function main() {
  const legacy = await mysql.createConnection(LEGACY_DB);

  const [rows] = await legacy.execute(
    "SELECT id, name, surname, email, is_active FROM staff"
  );

  console.log(`Found ${rows.length} legacy staff. Migrating...`);

  const passwordHash = await bcrypt.hash(TEMP_PASSWORD, 10);

  let created = 0;
  let skipped = 0;

  for (const row of rows) {
    const fullName = `${row.name || ""} ${row.surname || ""}`.trim();
    const email = row.email && row.email.trim() !== "" ? row.email.trim() : null;

    if (!email || !fullName) {
      skipped++;
      continue;
    }

    const existing = await prisma.staff.findUnique({ where: { email } });
    if (existing) {
      skipped++;
      continue;
    }

    await prisma.staff.create({
      data: {
        fullName,
        email,
        passwordHash,
        role: "RECEPTIONIST",
        active: row.is_active === 1,
      },
    });

    created++;
  }

  console.log(`Done. Created ${created} staff, skipped ${skipped} (missing email/name or duplicate).`);
  console.log(`Temporary password for all migrated staff: ${TEMP_PASSWORD}`);
  console.log("Remind everyone to change it on first login, and set correct roles via /admin/staff.");

  await legacy.end();
  await prisma.$disconnect();
}

main().catch((err) => {
  console.error("Migration failed:", err);
  process.exit(1);
});