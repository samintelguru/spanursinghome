import { PrismaClient } from "@prisma/client";
import Link from "next/link";
import { notFound } from "next/navigation";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";
import EquipmentForm, { type EquipmentFormValues } from "@/components/equipment-form";

const prisma = new PrismaClient();
const day = (d: Date | null) => (d ? d.toISOString().slice(0, 10) : "");

export default async function EditEquipmentPage({ params }: { params: Promise<{ id: string }> }) {
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;

  if (!session || !can(role, "managesEquipment")) {
    return (
      <main className="mx-auto max-w-2xl p-8">
        <p className="text-sm text-gray-600">Your role can&apos;t edit equipment.</p>
      </main>
    );
  }

  const { id } = await params;
  const [e, cats, locs] = await Promise.all([
    prisma.equipment.findUnique({ where: { id } }),
    prisma.equipment.findMany({ distinct: ["category"], select: { category: true } }),
    prisma.equipment.findMany({ where: { location: { not: null } }, distinct: ["location"], select: { location: true } }),
  ]);
  if (!e) notFound();

  const initial: EquipmentFormValues = {
    name: e.name,
    category: e.category,
    make: e.make ?? "",
    model: e.model ?? "",
    serialNumber: e.serialNumber ?? "",
    location: e.location ?? "",
    quantity: String(e.quantity),
    status: e.status,
    purchaseDate: day(e.purchaseDate),
    purchaseCost: e.purchaseCost ? String(e.purchaseCost) : "",
    supplier: e.supplier ?? "",
    warrantyExpiry: day(e.warrantyExpiry),
    serviceIntervalMonths: e.serviceIntervalMonths ? String(e.serviceIntervalMonths) : "",
    lastServiceDate: day(e.lastServiceDate),
    notes: e.notes ?? "",
  };

  return (
    <main className="mx-auto max-w-2xl p-8">
      <Link href={`/admin/equipment/${e.id}`} className="text-sm text-[#0982e8] hover:underline">
        ← Back to {e.name}
      </Link>
      <h1 className="mb-6 mt-3 text-xl font-medium text-[#2C2C2A]">Edit {e.name}</h1>
      <EquipmentForm
        mode="edit"
        equipmentId={e.id}
        assetTag={e.assetTag}
        initial={initial}
        categories={cats.map((c) => c.category)}
        locations={locs.map((l) => l.location as string).sort()}
      />
    </main>
  );
}
