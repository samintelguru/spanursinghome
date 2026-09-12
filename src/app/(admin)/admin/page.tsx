import { PrismaClient } from "@prisma/client";
import Link from "next/link";

const prisma = new PrismaClient();

export default async function AdminDashboardPage() {
  const [
    patientCount,
    allDrugs,
    unpaidInvoices,
    lowBloodStock,
    activeTrips,
  ] = await Promise.all([
    prisma.patient.count(),
    prisma.drug.findMany(),
    prisma.invoice.findMany({
      where: { status: { in: ["UNPAID", "PARTIALLY_PAID"] } },
      include: { items: true, payments: true, patient: true },
    }),
    prisma.bloodStock.findMany({ where: { unitsHeld: { lte: 2 } } }),
    prisma.ambulanceTrip.findMany({
      where: { status: { in: ["DISPATCHED", "EN_ROUTE"] } },
    }),
  ]);

  const lowStockDrugs = allDrugs.filter((d) => d.stockQty <= d.reorderAt);

  const totalOutstanding = unpaidInvoices.reduce((sum, inv) => {
    const due = inv.items.reduce((s, i) => s + Number(i.amount), 0);
    const paid = inv.payments.reduce((s, p) => s + Number(p.amount), 0);
    return sum + (due - paid);
  }, 0);

  const cards = [
    {
      label: "Patients registered",
      value: patientCount,
      href: "/admin/patients",
      warn: false,
    },
    {
      label: "Drugs low on stock",
      value: lowStockDrugs.length,
      href: "/admin/pharmacy",
      warn: lowStockDrugs.length > 0,
    },
    {
      label: "Unpaid / partial invoices",
      value: unpaidInvoices.length,
      sub: `KES ${totalOutstanding.toFixed(2)} outstanding`,
      href: "/admin/billing",
      warn: unpaidInvoices.length > 0,
    },
    {
      label: "Blood types low on stock",
      value: lowBloodStock.length,
      href: "/admin/blood-bank",
      warn: lowBloodStock.length > 0,
    },
    {
      label: "Active ambulance trips",
      value: activeTrips.length,
      href: "/admin/ambulance",
      warn: false,
    },
  ];

  return (
    <main className="p-8">
      <h1 className="mb-6 text-xl font-medium text-[#2C2C2A]">Dashboard</h1>
      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        {cards.map((card) => (
          <Link
            key={card.label}
            href={card.href}
            className={`rounded-xl p-4 transition hover:opacity-90 ${
              card.warn ? "bg-[#FAECE7]" : "bg-[#E6F1FB]"
            }`}
          >
            <p
              className={`text-sm ${
                card.warn ? "text-[#993C1D]" : "text-[#0C447C]"
              }`}
            >
              {card.label}
            </p>
            <p
              className={`mt-1 text-2xl font-medium ${
                card.warn ? "text-[#4A1B0C]" : "text-[#042C53]"
              }`}
            >
              {card.value}
            </p>
            {card.sub && (
              <p
                className={`mt-1 text-xs ${
                  card.warn ? "text-[#993C1D]" : "text-[#0C447C]"
                }`}
              >
                {card.sub}
              </p>
            )}
          </Link>
        ))}
      </div>
    </main>
  );
}