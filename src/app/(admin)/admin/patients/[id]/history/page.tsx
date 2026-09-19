import { PrismaClient } from "@prisma/client";
import Link from "next/link";
import { notFound } from "next/navigation";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";
import PrintButton from "./print-button";

const prisma = new PrismaClient();

// Servers (e.g. Vercel) run in UTC, so format everything in Kenyan time
// explicitly — otherwise an admission at 1am shows up on the previous day.
const TZ = "Africa/Nairobi";
const dateTimeFmt = new Intl.DateTimeFormat("en-GB", {
  timeZone: TZ,
  day: "numeric",
  month: "short",
  year: "numeric",
  hour: "2-digit",
  minute: "2-digit",
  hour12: false,
});
const dateFmt = new Intl.DateTimeFormat("en-GB", {
  timeZone: TZ,
  day: "numeric",
  month: "short",
  year: "numeric",
});

const fmtDateTime = (d: Date) => dateTimeFmt.format(d);
const fmtDate = (d: Date) => dateFmt.format(d);
const label = (s: string) => s.replace(/_/g, " ").toLowerCase();
const kes = (n: number) =>
  `KES ${n.toLocaleString("en-KE", { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`;

function stayLength(from: Date, to: Date | null) {
  const hours = Math.max(0, Math.floor(((to ?? new Date()).getTime() - from.getTime()) / 3_600_000));
  if (hours < 24) return `${hours} hr`;
  const days = Math.floor(hours / 24);
  return `${days} day${days === 1 ? "" : "s"}`;
}

const th = "py-1.5 pr-3 text-left font-medium text-gray-500";
const td = "py-1.5 pr-3 align-top";
const row = "border-b border-gray-100 print:break-inside-avoid";

function Section({
  title,
  count,
  children,
}: {
  title: string;
  count: number;
  children: React.ReactNode;
}) {
  return (
    <section className="mb-8">
      <h2 className="mb-2 border-b border-[#0B3D63] pb-1 text-sm font-medium text-[#0B3D63]">
        {title} <span className="font-normal text-gray-400">({count})</span>
      </h2>
      {count === 0 ? <p className="text-sm text-gray-400">None recorded.</p> : children}
    </section>
  );
}

export default async function PatientHistoryPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  if (!session || !can(role, "viewsPatientHistory")) {
    return (
      <main className="mx-auto max-w-3xl p-8">
        <p className="text-sm text-gray-600">
          You don&apos;t have permission to view full patient histories.
        </p>
      </main>
    );
  }

  const { id } = await params;

  const patient = await prisma.patient.findUnique({
    where: { id },
    include: {
      admittedBy: { select: { fullName: true } },
      admissions: {
        include: {
          bed: true,
          admittedBy: { select: { fullName: true } },
          dischargedBy: { select: { fullName: true } },
        },
        orderBy: { admittedAt: "desc" },
      },
      dispenses: {
        include: { drug: true, dispensedBy: { select: { fullName: true } } },
        orderBy: { dispensedAt: "desc" },
      },
      ambulanceTrips: {
        include: { staff: { select: { fullName: true } } },
        orderBy: { dispatchedAt: "desc" },
      },
      bloodIssues: {
        include: { bloodStock: true, issuedBy: { select: { fullName: true } } },
        orderBy: { issuedAt: "desc" },
      },
      visitNotes: {
        include: { recordedBy: { select: { fullName: true } } },
        orderBy: { createdAt: "desc" },
      },
      invoices: {
        include: { items: true, payments: true },
        orderBy: { createdAt: "desc" },
      },
    },
  });

  if (!patient) notFound();

  const now = new Date();
  const age = Math.floor(
    (now.getTime() - patient.dateOfBirth.getTime()) / (1000 * 60 * 60 * 24 * 365.25)
  );

  const currentStay = patient.admissions.find((a) => a.dischargedAt === null);
  const totalStayMs = patient.admissions.reduce(
    (sum, a) => sum + ((a.dischargedAt ?? now).getTime() - a.admittedAt.getTime()),
    0
  );
  const daysAdmitted = Math.round((totalStayMs / 86_400_000) * 10) / 10;
  const bloodUnits = patient.bloodIssues.reduce((s, b) => s + b.units, 0);

  const invoiceRows = patient.invoices.map((inv) => {
    const due = inv.items.reduce((s, i) => s + Number(i.amount), 0);
    const paid = inv.payments.reduce((s, p) => s + Number(p.amount), 0);
    return { inv, due, paid, balance: due - paid };
  });
  const outstanding = invoiceRows
    .filter((r) => r.inv.status !== "WAIVED")
    .reduce((s, r) => s + Math.max(0, r.balance), 0);

  const stats = [
    { label: "Admissions", value: String(patient.admissions.length), warn: false },
    { label: "Days admitted", value: String(daysAdmitted), warn: false },
    { label: "Drugs dispensed", value: String(patient.dispenses.length), warn: false },
    { label: "Ambulance trips", value: String(patient.ambulanceTrips.length), warn: false },
    { label: "Blood units", value: String(bloodUnits), warn: false },
    { label: "Outstanding", value: kes(outstanding), warn: outstanding > 0 },
  ];

  return (
    <main className="mx-auto max-w-4xl p-8 print:max-w-none print:p-0">
      <div className="mb-6 flex items-center justify-between print:hidden">
        <Link
          href={`/admin/patients/${patient.id}`}
          className="text-sm text-[#0982e8] hover:underline"
        >
          ← Back to patient
        </Link>
        <PrintButton />
      </div>

      <div className="rounded-lg border border-gray-200 bg-white p-6 print:border-0 print:p-0">
        {/* Letterhead */}
        <div className="mb-6 border-b border-gray-200 pb-4 text-center">
          <p className="font-serif text-lg font-semibold tracking-wide text-[#0B3D63]">
            SPA NURSING HOME
          </p>
          <p className="text-xs text-gray-500">Ruiru, Kiambu County · Emergency: 0706 155 600</p>
          <p className="mt-2 text-sm font-medium text-gray-700">Patient history</p>
        </div>

        {/* Patient details */}
        <div className="mb-6 grid grid-cols-2 gap-x-6 gap-y-1 text-sm sm:grid-cols-3">
          <p className="col-span-2 text-base font-medium sm:col-span-3">{patient.fullName}</p>
          <p className="text-gray-600">File no.: {patient.fileNumber}</p>
          <p className="text-gray-600">
            {label(patient.gender)} · {age} yrs
          </p>
          <p className="text-gray-600">Born: {fmtDate(patient.dateOfBirth)}</p>
          <p className="text-gray-600">Phone: {patient.phone || "—"}</p>
          <p className="text-gray-600">Next of kin: {patient.nextOfKin || "—"}</p>
          <p className="text-gray-600">Blood type: {patient.bloodType || "Not tested"}</p>
          <p className="text-gray-600">Registered: {fmtDate(patient.createdAt)}</p>
          {patient.admittedBy && (
            <p className="text-gray-600">Registered by: {patient.admittedBy.fullName}</p>
          )}
          {currentStay && (
            <p className="col-span-2 font-medium text-[#993C1D] sm:col-span-3">
              Currently admitted: {currentStay.bed.label} ({currentStay.bed.ward}) since{" "}
              {fmtDateTime(currentStay.admittedAt)}
            </p>
          )}
        </div>

        {/* Summary */}
        <div className="mb-8 grid grid-cols-2 gap-3 sm:grid-cols-3 lg:grid-cols-6">
          {stats.map((s) => (
            <div
              key={s.label}
              className={`rounded-lg p-3 print:border print:border-gray-200 ${
                s.warn ? "bg-[#FAECE7]" : "bg-[#E6F1FB]"
              }`}
            >
              <p className="text-xs text-gray-600">{s.label}</p>
              <p className="text-base font-medium text-[#2C2C2A]">{s.value}</p>
            </div>
          ))}
        </div>

        {/* Admissions & beds */}
        <Section title="Admissions & beds used" count={patient.admissions.length}>
          <table className="w-full text-sm">
            <thead>
              <tr className="border-b border-gray-200">
                <th className={th}>Bed</th>
                <th className={th}>Ward</th>
                <th className={th}>Admitted</th>
                <th className={th}>Discharged</th>
                <th className={th}>Stay</th>
                <th className={th}>Handled by</th>
              </tr>
            </thead>
            <tbody>
              {patient.admissions.map((a) => (
                <tr key={a.id} className={row}>
                  <td className={td}>{a.bed.label}</td>
                  <td className={td}>{a.bed.ward}</td>
                  <td className={td}>{fmtDateTime(a.admittedAt)}</td>
                  <td className={td}>
                    {a.dischargedAt ? (
                      fmtDateTime(a.dischargedAt)
                    ) : (
                      <span className="font-medium text-[#993C1D]">Currently admitted</span>
                    )}
                  </td>
                  <td className={td}>{stayLength(a.admittedAt, a.dischargedAt)}</td>
                  <td className={`${td} text-gray-500`}>
                    {a.admittedBy?.fullName ?? "—"}
                    {a.dischargedBy ? ` / ${a.dischargedBy.fullName}` : ""}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </Section>

        {/* Drugs dispensed */}
        <Section title="Drugs dispensed" count={patient.dispenses.length}>
          <table className="w-full text-sm">
            <thead>
              <tr className="border-b border-gray-200">
                <th className={th}>Date</th>
                <th className={th}>Drug</th>
                <th className={th}>Quantity</th>
                <th className={th}>Dispensed by</th>
              </tr>
            </thead>
            <tbody>
              {patient.dispenses.map((d) => (
                <tr key={d.id} className={row}>
                  <td className={td}>{fmtDateTime(d.dispensedAt)}</td>
                  <td className={td}>{d.drug.name}</td>
                  <td className={td}>
                    {d.quantity} {d.drug.unit}
                    {d.quantity === 1 ? "" : "s"}
                  </td>
                  <td className={`${td} text-gray-500`}>{d.dispensedBy.fullName}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </Section>

        {/* Ambulance */}
        <Section title="Ambulance trips" count={patient.ambulanceTrips.length}>
          <table className="w-full text-sm">
            <thead>
              <tr className="border-b border-gray-200">
                <th className={th}>Dispatched</th>
                <th className={th}>Route</th>
                <th className={th}>Status</th>
                <th className={th}>Completed</th>
                <th className={th}>Crew</th>
              </tr>
            </thead>
            <tbody>
              {patient.ambulanceTrips.map((t) => (
                <tr key={t.id} className={row}>
                  <td className={td}>{fmtDateTime(t.dispatchedAt)}</td>
                  <td className={td}>
                    {t.pickupLocation} → {t.destination}
                  </td>
                  <td className={`${td} capitalize`}>{label(t.status)}</td>
                  <td className={td}>{t.completedAt ? fmtDateTime(t.completedAt) : "—"}</td>
                  <td className={`${td} text-gray-500`}>{t.staff.fullName}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </Section>

        {/* Blood */}
        <Section title="Blood issued" count={patient.bloodIssues.length}>
          <table className="w-full text-sm">
            <thead>
              <tr className="border-b border-gray-200">
                <th className={th}>Date</th>
                <th className={th}>Blood type</th>
                <th className={th}>Units</th>
                <th className={th}>Issued by</th>
              </tr>
            </thead>
            <tbody>
              {patient.bloodIssues.map((b) => (
                <tr key={b.id} className={row}>
                  <td className={td}>{fmtDateTime(b.issuedAt)}</td>
                  <td className={td}>{b.bloodStock.bloodType}</td>
                  <td className={td}>{b.units}</td>
                  <td className={`${td} text-gray-500`}>{b.issuedBy.fullName}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </Section>

        {/* Visit notes */}
        <Section title="Visit notes" count={patient.visitNotes.length}>
          <ul className="text-sm">
            {patient.visitNotes.map((n) => {
              const vitals = [
                n.temperatureC !== null ? `Temp ${Number(n.temperatureC)}°C` : null,
                n.bloodPressure ? `BP ${n.bloodPressure}` : null,
                n.pulseBpm !== null ? `Pulse ${n.pulseBpm} bpm` : null,
              ].filter(Boolean);
              return (
                <li key={n.id} className={`${row} py-2`}>
                  <div className="flex justify-between text-gray-500">
                    <span>{fmtDateTime(n.createdAt)}</span>
                    <span>{n.recordedBy.fullName}</span>
                  </div>
                  <p className="whitespace-pre-wrap">{n.note}</p>
                  {vitals.length > 0 && (
                    <p className="text-xs text-gray-500">{vitals.join(" · ")}</p>
                  )}
                </li>
              );
            })}
          </ul>
        </Section>

        {/* Billing */}
        <Section title="Invoices & payments" count={invoiceRows.length}>
          <table className="w-full text-sm">
            <thead>
              <tr className="border-b border-gray-200">
                <th className={th}>Date</th>
                <th className={th}>Invoice</th>
                <th className={th}>Status</th>
                <th className={`${th} text-right`}>Total</th>
                <th className={`${th} text-right`}>Paid</th>
                <th className={`${th} text-right`}>Balance</th>
              </tr>
            </thead>
            <tbody>
              {invoiceRows.map(({ inv, due, paid, balance }) => (
                <tr key={inv.id} className={row}>
                  <td className={td}>{fmtDate(inv.createdAt)}</td>
                  <td className={td}>#{inv.id.slice(-8).toUpperCase()}</td>
                  <td className={`${td} capitalize`}>{label(inv.status)}</td>
                  <td className={`${td} text-right`}>{kes(due)}</td>
                  <td className={`${td} text-right`}>{kes(paid)}</td>
                  <td className={`${td} text-right`}>{kes(balance)}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </Section>

        <p className="mt-8 border-t border-gray-200 pt-3 text-center text-xs text-gray-400">
          Printed {fmtDateTime(now)}
          {session.user?.name ? ` by ${session.user.name}` : ""} · Confidential — contains
          personal health information.
        </p>
      </div>
    </main>
  );
}
