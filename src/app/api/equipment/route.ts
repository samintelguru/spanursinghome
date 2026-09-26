import { NextRequest, NextResponse } from "next/server";
import { Prisma, PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";
import { nextAssetTag } from "@/lib/equipment-server";
import {
  EquipmentError,
  computeNextService,
  parseAssetTag,
  parseEquipmentInput,
  serviceState,
  warrantyState,
} from "@/lib/equipment";

const prisma = new PrismaClient();

// GET /api/equipment?q=&status=&category=&attention=1
// Any signed-in staff member can read the register. Purchase cost and supplier
// are only sent to people who manage equipment.
export async function GET(req: NextRequest) {
  const session = await auth();
  if (!session) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  const role = (session.user as { role?: string })?.role;
  const canManage = can(role, "managesEquipment");

  const all = await prisma.equipment.findMany({
    orderBy: { assetTag: "asc" },
    take: 3000,
    select: {
      id: true,
      assetTag: true,
      name: true,
      category: true,
      make: true,
      model: true,
      serialNumber: true,
      location: true,
      quantity: true,
      status: true,
      warrantyExpiry: true,
      lastServiceDate: true,
      nextServiceDue: true,
      purchaseCost: true,
    },
  });

  // Summary is over everything still on the books (not disposed).
  const live = all.filter((e) => e.status !== "DISPOSED");
  const summary = {
    total: live.length,
    units: live.reduce((s, e) => s + e.quantity, 0),
    inUse: live.filter((e) => e.status === "IN_USE").length,
    underRepair: live.filter((e) => e.status === "UNDER_REPAIR").length,
    outOfService: live.filter((e) => e.status === "OUT_OF_SERVICE").length,
    serviceOverdue: live.filter((e) => serviceState(e.nextServiceDue, e.status) === "overdue").length,
    serviceSoon: live.filter((e) => serviceState(e.nextServiceDue, e.status) === "soon").length,
    warrantyEnding: live.filter((e) => warrantyState(e.warrantyExpiry, e.status) === "soon").length,
    totalValue: canManage
      ? live.reduce((s, e) => s + (e.purchaseCost ? Number(e.purchaseCost) * e.quantity : 0), 0)
      : null,
  };

  const q = req.nextUrl.searchParams.get("q")?.trim().toLowerCase() ?? "";
  const status = req.nextUrl.searchParams.get("status") ?? "";
  const category = req.nextUrl.searchParams.get("category") ?? "";
  const attention = req.nextUrl.searchParams.get("attention") === "1";

  const items = all
    .filter((e) => {
      if (status === "ACTIVE") {
        if (e.status === "DISPOSED") return false;
      } else if (status) {
        if (e.status !== status) return false;
      } else if (e.status === "DISPOSED") {
        return false; // disposed items are hidden unless asked for
      }
      if (category && e.category.toLowerCase() !== category.toLowerCase()) return false;
      if (attention) {
        const needs =
          e.status === "UNDER_REPAIR" ||
          e.status === "OUT_OF_SERVICE" ||
          serviceState(e.nextServiceDue, e.status) !== null;
        if (!needs) return false;
      }
      if (q) {
        const hay = [e.assetTag, e.name, e.make, e.model, e.serialNumber, e.location, e.category]
          .filter(Boolean)
          .join(" ")
          .toLowerCase();
        if (!q.split(/\s+/).every((t) => hay.includes(t))) return false;
      }
      return true;
    })
    .map(({ purchaseCost, ...rest }) => {
      void purchaseCost; // never sent in the list
      return rest;
    });

  const categories = [...new Set(live.map((e) => e.category))].sort();
  const locations = [
    ...new Set(
      (await prisma.equipment.findMany({ where: { location: { not: null } }, distinct: ["location"], select: { location: true } }))
        .map((l) => l.location as string)
    ),
  ].sort();

  return NextResponse.json({ items, summary, categories, locations, canManage });
}

// POST /api/equipment — the asset tag is assigned automatically (EQ-0001, ...);
// pass assetTag only for an item that already carries a number.
export async function POST(req: NextRequest) {
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  if (!session || !can(role, "managesEquipment")) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
  const staffId = (session.user as { id?: string })?.id ?? null;

  try {
    const body = await req.json().catch(() => ({}));
    const input = parseEquipmentInput(body);
    const customTag = parseAssetTag(body?.assetTag);

    if (customTag) {
      const taken = await prisma.equipment.findUnique({ where: { assetTag: customTag }, select: { name: true } });
      if (taken) {
        return NextResponse.json({ error: `Asset tag ${customTag} is already used by ${taken.name}` }, { status: 409 });
      }
    }
    if (input.serialNumber) {
      const dup = await prisma.equipment.findFirst({
        where: { serialNumber: { equals: input.serialNumber, mode: "insensitive" } },
        select: { assetTag: true, name: true },
      });
      if (dup) {
        return NextResponse.json(
          { error: `That serial number is already registered (${dup.assetTag} — ${dup.name})` },
          { status: 409 }
        );
      }
    }

    const nextServiceDue = computeNextService(input.serviceIntervalMonths, input.lastServiceDate, input.purchaseDate);

    const equipment = await prisma.$transaction(async (tx) => {
      const assetTag = customTag ?? (await nextAssetTag(tx));
      return tx.equipment.create({
        data: { assetTag, ...input, nextServiceDue, createdById: staffId },
      });
    });

    return NextResponse.json({ equipment }, { status: 201 });
  } catch (err) {
    if (err instanceof EquipmentError) return NextResponse.json({ error: err.message }, { status: err.status });
    if (err instanceof Prisma.PrismaClientKnownRequestError && err.code === "P2002") {
      return NextResponse.json({ error: "That asset tag was just taken — please try again" }, { status: 409 });
    }
    console.error("POST /api/equipment failed:", err);
    return NextResponse.json({ error: "Something went wrong. Please try again." }, { status: 500 });
  }
}
