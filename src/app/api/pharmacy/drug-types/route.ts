import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";
import { cleanTypeName, findDrugType, syncDrugTypes } from "@/lib/drug-types";

const prisma = new PrismaClient();

// GET /api/pharmacy/drug-types — every type, with how many drugs use it.
export async function GET() {
  const session = await auth();
  if (!session) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  await syncDrugTypes(prisma);

  const [types, usage] = await Promise.all([
    prisma.drugType.findMany({ orderBy: { name: "asc" } }),
    prisma.drug.groupBy({ by: ["unit"], _count: { _all: true } }),
  ]);

  // Older drugs may have "tablet" where the type is "Tablet" — match ignoring case.
  const used = new Map<string, number>();
  for (const u of usage) {
    const k = u.unit.trim().toLowerCase();
    used.set(k, (used.get(k) ?? 0) + u._count._all);
  }

  return NextResponse.json({
    types: types.map((t) => ({ id: t.id, name: t.name, drugCount: used.get(t.name.toLowerCase()) ?? 0 })),
  });
}

// POST /api/pharmacy/drug-types   body: { name }
export async function POST(req: NextRequest) {
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  if (!session || !can(role, "managesPharmacyInventory")) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  let name: string;
  try {
    name = cleanTypeName((await req.json().catch(() => ({})))?.name);
  } catch (e) {
    return NextResponse.json({ error: (e as Error).message }, { status: 400 });
  }

  const existing = await findDrugType(prisma, name);
  if (existing) {
    return NextResponse.json({ error: `"${existing.name}" is already in the list` }, { status: 409 });
  }

  const type = await prisma.drugType.create({ data: { name } });
  return NextResponse.json({ type: { id: type.id, name: type.name, drugCount: 0 } }, { status: 201 });
}
