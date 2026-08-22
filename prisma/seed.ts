// Creates the first admin staff account so you can log in.
// Run with: npx tsx prisma/seed.ts
// (or: node --loader ts-node/esm prisma/seed.ts, depending on your setup)

import { PrismaClient } from "@prisma/client";
import bcrypt from "bcryptjs";

const prisma = new PrismaClient();

async function main() {
  const email = "admin@spanursinghome.org";
  const plainPassword = "changeme123"; // change this after first login

  const existing = await prisma.staff.findUnique({ where: { email } });
  if (existing) {
    console.log("Admin account already exists:", email);
    return;
  }

  const passwordHash = await bcrypt.hash(plainPassword, 10);

  await prisma.staff.create({
    data: {
      fullName: "System Admin",
      email,
      passwordHash,
      role: "ADMIN",
    },
  });

  console.log("Created admin account:");
  console.log("  email:", email);
  console.log("  password:", plainPassword);
  console.log("Change this password after your first login.");
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(() => prisma.$disconnect());
