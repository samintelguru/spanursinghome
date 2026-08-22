import { PrismaClient } from "@prisma/client";
import { notFound } from "next/navigation";

const prisma = new PrismaClient();

export default async function PatientDetailPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;

  const patient = await prisma.patient.findUnique({
    where: { id },
    include: {
      dispenses: { include: { drug: true }, orderBy: { dispensedAt: "desc" } },
      invoices: { include: { items: true, payments: true }, orderBy: { createdAt: "desc" } },
      bloodIssues: { include: { bloodStock: true }, orderBy: { issuedAt: "desc" } },
      ambulanceTrips: { orderBy: { dispatchedAt: "desc" } },
    },
  });

  if (!patient) notFound();

  const age = Math.floor(
    (Date.now() - patient.dateOfBirth.getTime()) / (1000 * 60 * 60 * 24 * 365.25)
  );

  return (
    <main className="mx-auto max-w-3xl p-8">
      <div className="mb-6 rounded-lg border border-gray-200 p-4">
        <h1 className="text-xl font-medium">{patient.fullName}</h1>
        <p className="text-sm text-gray-500">
          File no. {patient.fileNumber} · {patient.gender} · {age} yrs
        </p>
        <div className="mt-2 grid grid-cols-2 gap-2 text-sm text-gray-600 sm:grid-cols-3">
          <p>Phone: {patient.phone || "—"}</p>
          <p>Next of kin: {patient.nextOfKin || "—"}</p>
          <p>Blood type: {patient.bloodType || "Not tested"}</p>
        </div>
      </div>

      <section className="mb-6">
        <h2 className="mb-2 text-sm font-medium text-gray-700">
          Pharmacy history
        </h2>
        {patient.dispenses.length === 0 ? (
          <p className="text-sm text-gray-400">No dispenses recorded.</p>
        ) : (
          <ul className="text-sm">
            {patient.dispenses.map((d) => (
              <li key={d.id} className="flex justify-between border-b border-gray-100 py-1.5">
                <span>{d.drug.name} × {d.quantity}</span>
                <span className="text-gray-400">
                  {d.dispensedAt.toLocaleDateString()}
                </span>
              </li>
            ))}
          </ul>
        )}
      </section>

      <section className="mb-6">
        <h2 className="mb-2 text-sm font-medium text-gray-700">Invoices</h2>
        {patient.invoices.length === 0 ? (
          <p className="text-sm text-gray-400">No invoices yet.</p>
        ) : (
          <ul className="text-sm">
            {patient.invoices.map((inv) => {
              const due = inv.items.reduce((s, i) => s + Number(i.amount), 0);
              const paid = inv.payments.reduce((s, p) => s + Number(p.amount), 0);
              return (
                <li key={inv.id} className="flex justify-between border-b border-gray-100 py-1.5">
                  <span>{inv.status.replace("_", " ")}</span>
                  <span>KES {(due - paid).toFixed(2)} balance</span>
                </li>
              );
            })}
          </ul>
        )}
      </section>

      <section className="mb-6">
        <h2 className="mb-2 text-sm font-medium text-gray-700">
          Blood issued
        </h2>
        {patient.bloodIssues.length === 0 ? (
          <p className="text-sm text-gray-400">No blood issued.</p>
        ) : (
          <ul className="text-sm">
            {patient.bloodIssues.map((b) => (
              <li key={b.id} className="flex justify-between border-b border-gray-100 py-1.5">
                <span>{b.bloodStock.bloodType} × {b.units} unit(s)</span>
                <span className="text-gray-400">
                  {b.issuedAt.toLocaleDateString()}
                </span>
              </li>
            ))}
          </ul>
        )}
      </section>

      <section>
        <h2 className="mb-2 text-sm font-medium text-gray-700">
          Ambulance trips
        </h2>
        {patient.ambulanceTrips.length === 0 ? (
          <p className="text-sm text-gray-400">No trips recorded.</p>
        ) : (
          <ul className="text-sm">
            {patient.ambulanceTrips.map((t) => (
              <li key={t.id} className="flex justify-between border-b border-gray-100 py-1.5">
                <span>{t.pickupLocation} → {t.destination}</span>
                <span className="text-gray-400">{t.status.replace("_", " ")}</span>
              </li>
            ))}
          </ul>
        )}
      </section>
    </main>
  );
}