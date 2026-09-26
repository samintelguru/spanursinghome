import { PrismaClient } from "@prisma/client";
import Link from "next/link";
import { notFound } from "next/navigation";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";
import VisitNotesSection from "./visit-notes-section";
import PatientIdCard from "@/components/patient-id-card";
import { ID_TYPES, MARITAL_STATUSES } from "@/lib/patient";

const prisma = new PrismaClient();

export default async function PatientDetailPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  const canViewHistory = can(role, "viewsPatientHistory");
  const canEdit = can(role, "registersPatients");
  const canPay = can(role, "recordsPayments");

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
        <div className="flex items-start justify-between gap-4">
          <h1 className="text-xl font-medium">{patient.fullName}</h1>
          <div className="flex shrink-0 gap-2">
            {canEdit && (
              <Link
                href={`/admin/patients/${patient.id}/edit`}
                className="rounded-md border border-gray-300 px-3 py-1.5 text-sm hover:bg-gray-50"
              >
                Edit details
              </Link>
            )}
            {canViewHistory && (
              <Link
                href={`/admin/patients/${patient.id}/history`}
                className="rounded-md bg-[#0982e8] px-3 py-1.5 text-sm font-medium text-white hover:bg-[#0a70c4]"
              >
                Full history
              </Link>
            )}
          </div>
        </div>
        <div className="text-sm text-gray-500">
          File no. {patient.fileNumber} · {patient.gender} · {patient.dobEstimated ? "about " : ""}{age} yrs
          <PatientIdCard
  patientId={patient.id}
  fileNumber={patient.fileNumber}
  fullName={patient.fullName}
/>
        </div>
        {patient.allergies && (
          <p className="mt-3 rounded-md bg-[#FAECE7] px-3 py-2 text-sm font-medium text-[#993C1D]">
            Allergies: {patient.allergies}
          </p>
        )}
        {patient.knownConditions && (
          <p className="mt-2 rounded-md bg-[#FFF3D6] px-3 py-2 text-sm text-[#8A5A00]">
            Known conditions: {patient.knownConditions}
          </p>
        )}
        <div className="mt-3 grid grid-cols-2 gap-x-4 gap-y-1.5 text-sm text-gray-600 sm:grid-cols-3">
          <p>Phone: {patient.phone || "—"}</p>
          <p>Email: {patient.email || "—"}</p>
          <p>Blood type: {patient.bloodType || "Not tested"}</p>
          <p>
            {ID_TYPES.find((t) => t.value === patient.idType)?.label ?? "ID"}: {patient.idNumber || "—"}
          </p>
          <p>
            Marital status:{" "}
            {MARITAL_STATUSES.find((m) => m.value === patient.maritalStatus)?.label ?? "—"}
          </p>
          <p>Occupation: {patient.occupation || "—"}</p>
          <p className="col-span-2 sm:col-span-3">
            Address: {[patient.residence, patient.county].filter(Boolean).join(", ") || "—"}
          </p>
          <p className="col-span-2 sm:col-span-3">
            Next of kin:{" "}
            {patient.nextOfKin
              ? [
                  patient.nextOfKin,
                  patient.nextOfKinRelationship && `(${patient.nextOfKinRelationship})`,
                  patient.nextOfKinPhone,
                ]
                  .filter(Boolean)
                  .join(" · ")
              : "—"}
          </p>
          <p className="col-span-2 sm:col-span-3">
            Insurance:{" "}
            {patient.insuranceProvider
              ? [patient.insuranceProvider, patient.insuranceMemberNo].filter(Boolean).join(" · ")
              : "Cash / none"}
          </p>
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
              const isOpen = inv.status === "UNPAID" || inv.status === "PARTIALLY_PAID";
              return (
                <li key={inv.id} className="flex items-center justify-between gap-3 border-b border-gray-100 py-1.5">
                  <span>{inv.status.replace("_", " ")}</span>
                  <span className="flex items-center gap-3">
                    <span>KES {(due - paid).toFixed(2)} balance</span>
                    {canPay && isOpen && (
                      <Link
                        href={`/admin/billing?q=${encodeURIComponent(patient.fileNumber)}&status=OPEN`}
                        className="rounded-md bg-[#D85A30] px-3 py-1 text-xs font-medium text-white hover:opacity-90"
                      >
                        Record payment
                      </Link>
                    )}
                  </span>
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

            <section className="mb-6">
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

      <VisitNotesSection patientId={patient.id} />
    </main>
  );
}