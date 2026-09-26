import { PrismaClient } from "@prisma/client";
import Link from "next/link";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";
import {
  METHOD_LABEL,
  PAYMENT_METHODS,
  dayKeyEAT,
  fmtDateTime,
  invoiceNo,
  invoiceTotals,
  kes,
  startOfDayEAT,
  startOfMonthEAT,
  startOfWeekEAT,
  toCents,
} from "@/lib/billing";

const prisma = new PrismaClient();
const DAY_MS = 24 * 60 * 60 * 1000;
const money = (cents: number) => kes(cents / 100);

const th = "py-1.5 pr-3 text-left font-medium text-gray-500";
const td = "py-1.5 pr-3 align-top";

function Section({ title, children }: { title: string; children: React.ReactNode }) {
  return (
    <section className="rounded-xl border border-gray-200 bg-white p-4">
      <h2 className="mb-3 text-sm font-medium text-[#0B3D63]">{title}</h2>
      {children}
    </section>
  );
}

export const dynamic = "force-dynamic";

export default async function BillingDashboardPage() {
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  if (!session || !can(role, "managesBilling")) {
    return (
      <main className="mx-auto max-w-3xl p-4 sm:p-8">
        <p className="text-sm text-gray-600">
          The billing dashboard is only available to administrators and billing clerks.
        </p>
      </main>
    );
  }

  const now = new Date();
  const todayStart = startOfDayEAT(now);
  const weekStart = startOfWeekEAT(now);
  const monthStart = startOfMonthEAT(now);
  const chartStart = new Date(todayStart.getTime() - 13 * DAY_MS);
  const paymentsSince = new Date(Math.min(monthStart.getTime(), chartStart.getTime()));

  const [payments, recent, openInvoices, billedAgg, waivedInvoices] = await Promise.all([
    prisma.payment.findMany({
      where: { paidAt: { gte: paymentsSince } },
      select: { amount: true, method: true, paidAt: true, receivedBy: { select: { fullName: true } } },
    }),
    prisma.payment.findMany({
      orderBy: { paidAt: "desc" },
      take: 10,
      include: {
        receivedBy: { select: { fullName: true } },
        invoice: { select: { id: true, patient: { select: { fullName: true, fileNumber: true } } } },
      },
    }),
    prisma.invoice.findMany({
      where: { status: { in: ["UNPAID", "PARTIALLY_PAID"] } },
      include: {
        items: { select: { amount: true } },
        payments: { select: { amount: true } },
        patient: { select: { id: true, fullName: true, fileNumber: true } },
      },
    }),
    prisma.invoiceItem.aggregate({
      _sum: { amount: true },
      where: { invoice: { createdAt: { gte: monthStart } } },
    }),
    prisma.invoice.findMany({
      where: { status: "WAIVED", waivedAt: { gte: monthStart } },
      include: { items: { select: { amount: true } }, payments: { select: { amount: true } } },
    }),
  ]);

  // ----- collections -----
  const sumSince = (from: Date) =>
    payments.filter((p) => p.paidAt >= from).reduce((s, p) => s + toCents(p.amount), 0);
  const collectedToday = sumSince(todayStart);
  const collectedWeek = sumSince(weekStart);
  const collectedMonth = sumSince(monthStart);

  const billedMonth = toCents(billedAgg._sum.amount ?? 0);
  const writtenOffMonth = waivedInvoices.reduce(
    (s, inv) => s + Math.max(0, invoiceTotals(inv.items, inv.payments).balanceC),
    0
  );

  // ----- last 14 days chart -----
  const byDay = new Map<string, number>();
  for (const p of payments) {
    if (p.paidAt < chartStart) continue;
    const k = dayKeyEAT(p.paidAt);
    byDay.set(k, (byDay.get(k) ?? 0) + toCents(p.amount));
  }
  const days = Array.from({ length: 14 }, (_, i) => {
    const key = dayKeyEAT(new Date(chartStart.getTime() + i * DAY_MS));
    const wd = new Date(`${key}T00:00:00Z`).getUTCDay();
    return { key, cents: byDay.get(key) ?? 0, dom: key.slice(8), wd: "SMTWTFS"[wd] };
  });
  const peakDay = Math.max(0, ...days.map((d) => d.cents));
  const maxDay = Math.max(1, peakDay);

  // ----- payment methods this month -----
  const monthPayments = payments.filter((p) => p.paidAt >= monthStart);
  const methodTotals = PAYMENT_METHODS.map((m) => ({
    method: m,
    cents: monthPayments.filter((p) => p.method === m).reduce((s, p) => s + toCents(p.amount), 0),
  }));
  const methodMax = Math.max(1, ...methodTotals.map((m) => m.cents));

  // ----- outstanding, ageing, top debtors -----
  let outstandingC = 0;
  const ageing = [
    { label: "0–7 days", cents: 0, count: 0 },
    { label: "8–30 days", cents: 0, count: 0 },
    { label: "31–60 days", cents: 0, count: 0 },
    { label: "Over 60 days", cents: 0, count: 0 },
  ];
  const debtors = new Map<string, { id: string; name: string; file: string; cents: number; count: number }>();

  for (const inv of openInvoices) {
    const { balanceC } = invoiceTotals(inv.items, inv.payments);
    if (balanceC <= 0) continue;
    outstandingC += balanceC;

    const age = Math.floor((now.getTime() - inv.createdAt.getTime()) / DAY_MS);
    const bucket = age <= 7 ? 0 : age <= 30 ? 1 : age <= 60 ? 2 : 3;
    ageing[bucket].cents += balanceC;
    ageing[bucket].count += 1;

    const d = debtors.get(inv.patient.id) ?? {
      id: inv.patient.id,
      name: inv.patient.fullName,
      file: inv.patient.fileNumber,
      cents: 0,
      count: 0,
    };
    d.cents += balanceC;
    d.count += 1;
    debtors.set(inv.patient.id, d);
  }
  const topDebtors = [...debtors.values()].sort((a, b) => b.cents - a.cents).slice(0, 10);
  const openCount = openInvoices.filter((i) => invoiceTotals(i.items, i.payments).balanceC > 0).length;
  const ageMax = Math.max(1, ...ageing.map((a) => a.cents));

  // ----- today's cash-up, per staff member -----
  const cashUp = new Map<string, Record<string, number>>();
  for (const p of payments) {
    if (p.paidAt < todayStart) continue;
    const who = p.receivedBy?.fullName ?? "Not recorded";
    const row = cashUp.get(who) ?? { cash: 0, mpesa: 0, insurance: 0 };
    row[p.method] = (row[p.method] ?? 0) + toCents(p.amount);
    cashUp.set(who, row);
  }
  const cashUpRows = [...cashUp.entries()].map(([who, r]) => ({
    who,
    cash: r.cash ?? 0,
    mpesa: r.mpesa ?? 0,
    insurance: r.insurance ?? 0,
    total: Object.values(r).reduce((s, v) => s + v, 0),
  }));

  const cards = [
    { label: "Collected today", value: money(collectedToday), warn: false },
    { label: "Collected this week", value: money(collectedWeek), warn: false },
    { label: "Collected this month", value: money(collectedMonth), warn: false },
    { label: "Billed this month", value: money(billedMonth), warn: false },
    {
      label: "Outstanding",
      value: money(outstandingC),
      sub: `${openCount} open invoice${openCount === 1 ? "" : "s"}`,
      warn: outstandingC > 0,
    },
    { label: "Written off this month", value: money(writtenOffMonth), sub: "waived balances", warn: false },
  ];

  return (
    <main className="mx-auto max-w-6xl p-4 sm:p-8">
      <div className="mb-6 flex flex-wrap items-center justify-between gap-3">
        <div>
          <Link href="/admin/billing" className="text-sm text-[#0982e8] hover:underline">
            ← Back to billing
          </Link>
          <h1 className="mt-2 text-xl font-medium text-[#2C2C2A]">Billing dashboard</h1>
          <p className="text-xs text-gray-500">As at {fmtDateTime(now)} (Nairobi time)</p>
        </div>
        <Link
          href="/admin/billing/new"
          className="rounded-md bg-[#0982e8] px-4 py-2 text-sm font-medium text-white hover:bg-[#0a70c4]"
        >
          New invoice
        </Link>
      </div>

      <div className="mb-6 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        {cards.map((c) => (
          <div key={c.label} className={`rounded-xl p-4 ${c.warn ? "bg-[#FAECE7]" : "bg-[#E6F1FB]"}`}>
            <p className={`text-sm ${c.warn ? "text-[#993C1D]" : "text-[#0C447C]"}`}>{c.label}</p>
            <p className={`mt-1 text-2xl font-medium ${c.warn ? "text-[#4A1B0C]" : "text-[#042C53]"}`}>
              {c.value}
            </p>
            {c.sub && (
              <p className={`mt-1 text-xs ${c.warn ? "text-[#993C1D]" : "text-[#0C447C]"}`}>{c.sub}</p>
            )}
          </div>
        ))}
      </div>

      <div className="flex flex-col gap-6">
        <Section title="Money collected — last 14 days">
          <div className="flex h-44 items-end gap-1.5">
            {days.map((d) => (
              <div key={d.key} className="flex h-full flex-1 flex-col items-center justify-end" title={`${d.key}: ${money(d.cents)}`}>
                <div
                  className="w-full rounded-t bg-[#0982e8]"
                  style={{ height: d.cents > 0 ? `${Math.max(3, (d.cents / maxDay) * 100)}%` : "2px", opacity: d.cents > 0 ? 1 : 0.25 }}
                />
                <span className="mt-1 text-[10px] leading-none text-gray-500">{d.dom}</span>
                <span className="text-[10px] leading-none text-gray-400">{d.wd}</span>
              </div>
            ))}
          </div>
          <p className="mt-2 text-xs text-gray-500">Best day: {money(peakDay)}</p>
        </Section>

        <div className="grid gap-6 lg:grid-cols-2">
          <Section title="How patients paid — this month">
            <div className="flex flex-col gap-3">
              {methodTotals.map((m) => (
                <div key={m.method}>
                  <div className="mb-1 flex justify-between text-sm">
                    <span>{METHOD_LABEL[m.method]}</span>
                    <span className="text-gray-600">{money(m.cents)}</span>
                  </div>
                  <div className="h-2 rounded bg-gray-100">
                    <div className="h-2 rounded bg-[#0B3D63]" style={{ width: `${(m.cents / methodMax) * 100}%` }} />
                  </div>
                </div>
              ))}
            </div>
          </Section>

          <Section title="Outstanding by age of invoice">
            <div className="flex flex-col gap-3">
              {ageing.map((a, i) => (
                <div key={a.label}>
                  <div className="mb-1 flex justify-between text-sm">
                    <span>
                      {a.label} <span className="text-xs text-gray-400">({a.count})</span>
                    </span>
                    <span className="text-gray-600">{money(a.cents)}</span>
                  </div>
                  <div className="h-2 rounded bg-gray-100">
                    <div
                      className={`h-2 rounded ${i >= 2 ? "bg-[#D85A30]" : "bg-[#0982e8]"}`}
                      style={{ width: `${(a.cents / ageMax) * 100}%` }}
                    />
                  </div>
                </div>
              ))}
            </div>
          </Section>
        </div>

        <Section title="Today's cash-up — by staff member">
          {cashUpRows.length === 0 ? (
            <p className="text-sm text-gray-400">No payments recorded today.</p>
          ) : (
            <div className="overflow-x-auto">
              <table className="w-full text-sm">
                <thead>
                  <tr className="border-b border-gray-200">
                    <th className={th}>Received by</th>
                    <th className={`${th} text-right`}>Cash</th>
                    <th className={`${th} text-right`}>M-Pesa</th>
                    <th className={`${th} text-right`}>Insurance</th>
                    <th className={`${th} text-right`}>Total</th>
                  </tr>
                </thead>
                <tbody>
                  {cashUpRows.map((r) => (
                    <tr key={r.who} className="border-b border-gray-100">
                      <td className={td}>{r.who}</td>
                      <td className={`${td} text-right`}>{money(r.cash)}</td>
                      <td className={`${td} text-right`}>{money(r.mpesa)}</td>
                      <td className={`${td} text-right`}>{money(r.insurance)}</td>
                      <td className={`${td} text-right font-medium`}>{money(r.total)}</td>
                    </tr>
                  ))}
                  <tr className="font-medium">
                    <td className={td}>All staff</td>
                    <td className={`${td} text-right`}>{money(cashUpRows.reduce((s, r) => s + r.cash, 0))}</td>
                    <td className={`${td} text-right`}>{money(cashUpRows.reduce((s, r) => s + r.mpesa, 0))}</td>
                    <td className={`${td} text-right`}>{money(cashUpRows.reduce((s, r) => s + r.insurance, 0))}</td>
                    <td className={`${td} text-right`}>{money(collectedToday)}</td>
                  </tr>
                </tbody>
              </table>
            </div>
          )}
          <p className="mt-2 text-xs text-gray-500">
            The cash column is what each person should hand over at the end of the day.
          </p>
        </Section>

        <div className="grid gap-6 lg:grid-cols-2">
          <Section title="Largest outstanding balances">
            {topDebtors.length === 0 ? (
              <p className="text-sm text-gray-400">Nothing outstanding.</p>
            ) : (
              <table className="w-full text-sm">
                <thead>
                  <tr className="border-b border-gray-200">
                    <th className={th}>Patient</th>
                    <th className={`${th} text-right`}>Invoices</th>
                    <th className={`${th} text-right`}>Owing</th>
                    <th className={th} />
                  </tr>
                </thead>
                <tbody>
                  {topDebtors.map((d) => (
                    <tr key={d.id} className="border-b border-gray-100">
                      <td className={td}>
                        <Link href={`/admin/patients/${d.id}`} className="hover:underline">
                          {d.name}
                        </Link>
                        <span className="block text-xs text-gray-400">{d.file}</span>
                      </td>
                      <td className={`${td} text-right`}>{d.count}</td>
                      <td className={`${td} text-right font-medium text-[#993C1D]`}>{money(d.cents)}</td>
                      <td className={`${td} text-right`}>
                        <Link
                          href={`/admin/billing?q=${encodeURIComponent(d.file)}&status=OPEN`}
                          className="rounded-md bg-[#D85A30] px-2.5 py-1 text-xs font-medium text-white hover:opacity-90"
                        >
                          Collect
                        </Link>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            )}
          </Section>

          <Section title="Latest payments">
            {recent.length === 0 ? (
              <p className="text-sm text-gray-400">No payments yet.</p>
            ) : (
              <table className="w-full text-sm">
                <thead>
                  <tr className="border-b border-gray-200">
                    <th className={th}>When / who</th>
                    <th className={th}>Patient</th>
                    <th className={`${th} text-right`}>Amount</th>
                  </tr>
                </thead>
                <tbody>
                  {recent.map((p) => (
                    <tr key={p.id} className="border-b border-gray-100">
                      <td className={td}>
                        {fmtDateTime(p.paidAt)}
                        <span className="block text-xs text-gray-400">
                          {METHOD_LABEL[p.method] ?? p.method}
                          {p.reference ? ` · ${p.reference}` : ""}
                          {p.receivedBy ? ` · ${p.receivedBy.fullName}` : ""}
                        </span>
                      </td>
                      <td className={td}>
                        <Link href={`/admin/billing/${p.invoice.id}/receipt`} className="hover:underline">
                          {p.invoice.patient.fullName}
                        </Link>
                        <span className="block text-xs text-gray-400">{invoiceNo(p.invoice.id)}</span>
                      </td>
                      <td className={`${td} text-right`}>{money(toCents(p.amount))}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            )}
          </Section>
        </div>
      </div>
    </main>
  );
}
