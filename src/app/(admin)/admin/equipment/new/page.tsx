import { PrismaClient } from "@prisma/client";
import Link from "next/link";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";
import EquipmentForm from "@/components/equipment-form";

const prisma = new PrismaClient();

export default async function NewEquipmentPage() {
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;

  if (!session || !can(role, "managesEquipment")) {
    return (
      <main className="mx-auto max-w-2xl p-8">
        <p className="text-sm text-gray-600">Your role can&apos;t add equipment.</p>
      </main>
    );
  }

  const [cats, locs] = await Promise.all([
    prisma.equipment.findMany({ distinct: ["category"], select: { category: true } }),
    prisma.equipment.findMany({ where: { location: { not: null } }, distinct: ["location"], select: { location: true } }),
  ]);

  return (
    <main className="mx-auto max-w-2xl p-8">
      <Link href="/admin/equipment" className="text-sm text-[#0982e8] hover:underline">
        ← Back to equipment
      </Link>
      <h1 className="mb-6 mt-3 text-xl font-medium text-[#2C2C2A]">Add equipment</h1>
      <EquipmentForm
        mode="create"
        categories={cats.map((c) => c.category)}
        locations={locs.map((l) => l.location as string).sort()}
      />
    </main>
  );
}
