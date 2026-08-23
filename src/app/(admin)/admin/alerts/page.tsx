import { PrismaClient } from "@prisma/client";
import Link from "next/link";

const prisma = new PrismaClient();

export default async function AdminAlertsPage() {
  const [allDrugs, lowBlood] = await Promise.all([
    prisma.drug.findMany(),
    prisma.bloodStock.findMany({ where: { unitsHeld: { lte: 2 } } }),
  ]);

  const lowDrugs = allDrugs.filter((d) => d.stockQty <= d.reorderAt);

  return (
    <main className="p-8">
      <h1 className="mb-6 text-xl font-medium">Alerts</h1>

      <section className="mb-8">
        <h2 className="mb-2 text-sm font-medium text-gray-700">
          Low drug stock ({lowDrugs.length})
        </h2>
        {lowDrugs.length === 0 ? (
          <p className="text-sm text-gray-400">All drugs are adequately stocked.</p>
        ) : (
          <ul className="rounded-lg border border-gray-200">
            {lowDrugs.map((d) => (
              <li
                key={d.id}
                className="flex items-center justify-between border-b border-gray-100 px-4 py-2 text-sm last:border-b-0"
              >
                <span>{d.name}</span>
                <span className="text-red-600">
                  {d.stockQty} {d.unit} left (reorder at {d.reorderAt})
                </span>
              </li>
            ))}
          </ul>
        )}
        {lowDrugs.length > 0 && (
          <Link
            href="/admin/pharmacy"
            className="mt-2 inline-block text-sm text-[#0F6E56] hover:underline"
          >
            Go to pharmacy →
          </Link>
        )}
      </section>

      <section>
        <h2 className="mb-2 text-sm font-medium text-gray-700">
          Low blood stock ({lowBlood.length})
        </h2>
        {lowBlood.length === 0 ? (
          <p className="text-sm text-gray-400">All blood types are adequately stocked.</p>
        ) : (
          <ul className="rounded-lg border border-gray-200">
            {lowBlood.map((b) => (
              <li
                key={b.id}
                className="flex items-center justify-between border-b border-gray-100 px-4 py-2 text-sm last:border-b-0"
              >
                <span>{b.bloodType}</span>
                <span className="text-red-600">{b.unitsHeld} unit(s) left</span>
              </li>
            ))}
          </ul>
        )}
        {lowBlood.length > 0 && (
          <Link
            href="/admin/blood-bank"
            className="mt-2 inline-block text-sm text-[#0F6E56] hover:underline"
          >
            Go to blood bank →
          </Link>
        )}
      </section>
    </main>
  );
}