import { PrismaClient } from "@prisma/client";
import Link from "next/link";
import { notFound } from "next/navigation";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";
import { fmtDate, kes } from "@/lib/billing";
import { STATUS_STYLE, kindLabel, serviceState, statusLabel, warrantyState } from "@/lib/equipment";
import { DeleteEquipment, LogService } from "./equipment-actions";

const prisma = new PrismaClient();

function Row({ label, children }: { label: string; children: React.ReactNode }) {
  return (
    <div className="flex justify-between gap-4 border-b border-gray-100 py-1.5 text-sm">
      <span className="text-gray-500">{label}</span>
      <span className="text-right text-gray-800">{children}</span>
    </div>
  );
}

export default async function EquipmentDetailPage({ params }: { params: Promise<{ id: string }> }) {
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  const canManage = can(role, "managesEquipment");

  const { id } = await params;
  const e = await prisma.equipment.findUnique({
    where: { id },
    include: {
      serviceLogs: {
        orderBy: { performedOn: "desc" },
        include: { recordedBy: { select: { fullName: true } } },
      },
    },
  });
  if (!e) notFound();

  const svc = serviceState(e.nextServiceDue, e.status);
  const war = warrantyState(e.warrantyExpiry, e.status);
  const dash = <span className="text-gray-300">—</span>;

  return (
    <main className="mx-auto max-w-3xl p-4 sm:p-8">
      <Link href="/admin/equipment" className="text-sm text-[#0982e8] hover:underline">
        ← Back to equipment
      </Link>

      <div className="mb-6 mt-3 flex flex-wrap items-start justify-between gap-3">
        <div>
          <h1 className="text-xl font-medium text-[#2C2C2A]">{e.name}</h1>
          <p className="text-sm text-gray-500">
            <span className="font-mono">{e.assetTag}</span> · {e.category}
            {e.quantity > 1 ? ` · ${e.quantity} units` : ""}
          </p>
        </div>
        <div className="flex items-center gap-3">
          <span className={`rounded-full px-3 py-1 text-xs font-medium ${STATUS_STYLE[e.status]}`}>{statusLabel(e.status)}</span>
          {canManage && (
            <Link
              href={`/admin/equipment/${e.id}/edit`}
              className="rounded-md border border-gray-300 px-3 py-1.5 text-sm hover:bg-gray-50"
            >
              Edit details
            </Link>
          )}
        </div>
      </div>

      {(svc === "overdue" || e.status === "OUT_OF_SERVICE" || e.status === "UNDER_REPAIR") && (
        <p className="mb-4 rounded-md bg-[#FAECE7] px-3 py-2 text-sm font-medium text-[#993C1D]">
          {e.status === "OUT_OF_SERVICE" && "This equipment is out of service. "}
          {e.status === "UNDER_REPAIR" && "This equipment is under repair. "}
          {svc === "overdue" && e.nextServiceDue && `Service was due on ${fmtDate(e.nextServiceDue)}.`}
        </p>
      )}

      <div className="mb-6 grid gap-6 sm:grid-cols-2">
        <section className="rounded-lg border border-gray-200 bg-white p-4">
          <h2 className="mb-2 text-sm font-medium text-[#0B3D63]">Details</h2>
          <Row label="Make">{e.make || dash}</Row>
          <Row label="Model">{e.model || dash}</Row>
          <Row label="Serial number">{e.serialNumber || dash}</Row>
          <Row label="Kept in">{e.location || dash}</Row>
          <Row label="Registered">{fmtDate(e.createdAt)}</Row>
        </section>

        <section className="rounded-lg border border-gray-200 bg-white p-4">
          <h2 className="mb-2 text-sm font-medium text-[#0B3D63]">Servicing & warranty</h2>
          <Row label="Service every">
            {e.serviceIntervalMonths ? (e.serviceIntervalMonths === 1 ? "1 month" : `${e.serviceIntervalMonths} months`) : "Not scheduled"}
          </Row>
          <Row label="Last serviced">{e.lastServiceDate ? fmtDate(e.lastServiceDate) : dash}</Row>
          <Row label="Next service due">
            {e.nextServiceDue ? (
              <span className={svc === "overdue" ? "font-medium text-red-600" : svc === "soon" ? "text-[#8A5A00]" : ""}>
                {fmtDate(e.nextServiceDue)}
                {svc === "overdue" && " · overdue"}
                {svc === "soon" && " · soon"}
              </span>
            ) : (
              dash
            )}
          </Row>
          <Row label="Warranty ends">
            {e.warrantyExpiry ? (
              <span className={war === "expired" ? "text-gray-400" : war === "soon" ? "text-[#8A5A00]" : ""}>
                {fmtDate(e.warrantyExpiry)}
                {war === "expired" && " · expired"}
                {war === "soon" && " · ending soon"}
              </span>
            ) : (
              dash
            )}
          </Row>
        </section>
      </div>

      {canManage && (
        <section className="mb-6 rounded-lg border border-gray-200 bg-white p-4">
          <h2 className="mb-2 text-sm font-medium text-[#0B3D63]">Purchase</h2>
          <Row label="Bought on">{e.purchaseDate ? fmtDate(e.purchaseDate) : dash}</Row>
          <Row label="Supplier">{e.supplier || dash}</Row>
          <Row label="Cost per item">{e.purchaseCost ? kes(Number(e.purchaseCost)) : dash}</Row>
          {e.purchaseCost && e.quantity > 1 && (
            <Row label={`Total for ${e.quantity} items`}>{kes(Number(e.purchaseCost) * e.quantity)}</Row>
          )}
        </section>
      )}

      {e.notes && (
        <section className="mb-6 rounded-lg border border-gray-200 bg-white p-4">
          <h2 className="mb-1 text-sm font-medium text-[#0B3D63]">Notes</h2>
          <p className="whitespace-pre-wrap break-words text-sm text-gray-700">{e.notes}</p>
        </section>
      )}

      <section className="mb-6">
        <div className="mb-3 flex items-center justify-between gap-3">
          <h2 className="text-sm font-medium text-gray-700">Service history ({e.serviceLogs.length})</h2>
        </div>
        {canManage && (
          <div className="mb-4">
            <LogService equipmentId={e.id} currentStatus={e.status} />
          </div>
        )}
        {e.serviceLogs.length === 0 ? (
          <p className="text-sm text-gray-400">No services or repairs recorded yet.</p>
        ) : (
          <ul className="divide-y divide-gray-100 rounded-lg border border-gray-200 bg-white">
            {e.serviceLogs.map((l) => (
              <li key={l.id} className="flex items-start justify-between gap-4 px-4 py-2.5 text-sm">
                <div className="min-w-0">
                  <p>
                    <span className="font-medium">{kindLabel(l.kind)}</span>
                    <span className="text-gray-400"> · {fmtDate(l.performedOn)}</span>
                  </p>
                  <p className="break-words text-xs text-gray-500">
                    {[l.performedBy && `By ${l.performedBy}`, l.notes].filter(Boolean).join(" · ") || "—"}
                  </p>
                  <p className="text-xs text-gray-400">Recorded by {l.recordedBy.fullName}</p>
                </div>
                {canManage && l.cost && <span className="shrink-0 text-gray-600">{kes(Number(l.cost))}</span>}
              </li>
            ))}
          </ul>
        )}
      </section>

      {role === "ADMIN" && (
        <div className="border-t border-gray-200 pt-4">
          <DeleteEquipment equipmentId={e.id} name={e.name} />
        </div>
      )}
    </main>
  );
}
