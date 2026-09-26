// Server-only helpers for the drug type list (Tablet, Capsule, Syrup...).
import type { Prisma, PrismaClient } from "@prisma/client";

type Db = PrismaClient | Prisma.TransactionClient;

// Offered the first time the list is opened. Staff can add more from the
// pharmacy page.
export const DEFAULT_DRUG_TYPES = [
  "Tablet", "Capsule", "Syrup", "Suspension", "Injection", "Vial", "Ampoule",
  "Infusion (IV fluid)", "Cream", "Ointment", "Gel", "Lotion", "Eye drops",
  "Ear drops", "Nasal spray", "Suppository", "Pessary", "Inhaler", "Sachet",
  "Lozenge", "Patch", "Powder", "ml", "Piece",
];

const capFirst = (s: string) => (s ? s[0].toUpperCase() + s.slice(1) : s);

// Validates and tidies a type name typed by staff. Throws Error(message).
export function cleanTypeName(v: unknown): string {
  const t = typeof v === "string" ? v.replace(/\s+/g, " ").trim() : "";
  if (t.length < 2 || t.length > 30) throw new Error("Type name must be 2 to 30 characters");
  if (!/^[A-Za-z0-9][A-Za-z0-9 ()&/.,'-]*$/.test(t)) {
    throw new Error("Type name can only use letters, numbers, spaces and ( ) & / . , ' -");
  }
  return capFirst(t);
}

export const findDrugType = (db: Db, name: string) =>
  db.drugType.findFirst({ where: { name: { equals: name, mode: "insensitive" } } });

// Keeps the list complete: seeds the defaults on first use, and adds any unit
// already used by drugs entered before this list existed (e.g. "vial").
export async function syncDrugTypes(db: Db) {
  const [types, units] = await Promise.all([
    db.drugType.findMany({ select: { name: true } }),
    db.drug.findMany({ distinct: ["unit"], select: { unit: true } }),
  ]);

  const have = new Set(types.map((t) => t.name.toLowerCase()));
  const toAdd: string[] = [];
  const add = (name: string) => {
    const key = name.toLowerCase();
    if (name && !have.has(key)) {
      have.add(key);
      toAdd.push(name);
    }
  };

  if (types.length === 0) DEFAULT_DRUG_TYPES.forEach(add);
  for (const u of units) add(capFirst(u.unit.replace(/\s+/g, " ").trim()));

  if (toAdd.length) {
    await db.drugType.createMany({ data: toAdd.map((name) => ({ name })), skipDuplicates: true });
  }
}
