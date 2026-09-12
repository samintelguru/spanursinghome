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
    "SELECT id, medicine_name, unit, reorder_level FROM pharmacy WHERE is_active = 'yes'"
  );

  console.log(`Found ${rows.length} legacy drugs. Migrating...`);

  let created = 0;
  let skipped = 0;

  for (const row of rows) {
    if (!row.medicine_name || row.medicine_name.trim() === "") {
      skipped++;
      continue;
    }

    const existing = await prisma.drug.findFirst({ where: { name: row.medicine_name.trim() } });
    if (existing) {
      skipped++;
      continue;
    }

    const reorderAt = row.reorder_level ? parseInt(row.reorder_level, 10) : 10;

    await prisma.drug.create({
      data: {
        name: row.medicine_name.trim(),
        unit: row.unit && row.unit.trim() !== "" ? row.unit.trim() : "unit",
        unitPrice: 0,
        stockQty: 0,
        reorderAt: isNaN(reorderAt) ? 10 : reorderAt,
      },
    });

    created++;
  }

  console.log(`Done. Created ${created} drugs, skipped ${skipped} (blank name or duplicate).`);
  console.log("Reminder: prices and stock counts are all 0 — pharmacy staff need to set these via /admin/pharmacy.");

  await legacy.end();
  await prisma.$disconnect();
}

main().catch((err) => {
  console.error("Migration failed:", err);
  process.exit(1);
});