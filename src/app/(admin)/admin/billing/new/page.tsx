"use client";

import { useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { kes } from "@/lib/billing";
import PatientPicker, { type PatientLite } from "@/components/patient-picker";

type Line = { description: string; quantity: string; unitPrice: string };

const QUICK = ["Consultation", "Lab test", "Procedure", "Bed charges", "Ambulance", "Other"];
const input = "rounded-md border border-gray-300 px-3 py-2 text-sm";
const emptyLine = (): Line => ({ description: "", quantity: "1", unitPrice: "" });

const lineTotal = (l: Line) => {
  const q = Number(l.quantity);
  const p = Number(l.unitPrice);
  return Number.isFinite(q) && Number.isFinite(p) ? Math.round(q * p * 100) / 100 : 0;
};

export default function NewInvoicePage() {
  const router = useRouter();
  const [patient, setPatient] = useState<PatientLite | null>(null);
  const [lines, setLines] = useState<Line[]>([emptyLine()]);
  const [error, setError] = useState("");
  const [busy, setBusy] = useState(false);

  const setLine = (i: number, patch: Partial<Line>) =>
    setLines((ls) => ls.map((l, idx) => (idx === i ? { ...l, ...patch } : l)));

  const addQuick = (name: string) => {
    setLines((ls) => {
      const emptyIdx = ls.findIndex((l) => !l.description && !l.unitPrice);
      if (emptyIdx >= 0) return ls.map((l, i) => (i === emptyIdx ? { ...l, description: name } : l));
      return [...ls, { ...emptyLine(), description: name }];
    });
  };

  const total = lines.reduce((s, l) => s + lineTotal(l), 0);
  const filled = lines.filter((l) => l.description.trim() || l.unitPrice);
  const valid =
    !!patient && filled.length > 0 && filled.every((l) => l.description.trim() && Number(l.unitPrice) > 0 && Number(l.quantity) >= 1);

  const submit = async () => {
    if (!patient) return;
    setBusy(true);
    setError("");
    const res = await fetch("/api/billing/invoices", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        patientId: patient.id,
        items: filled.map((l) => ({
          description: l.description,
          quantity: Number(l.quantity),
          unitPrice: Number(l.unitPrice),
        })),
      }),
    });
    setBusy(false);
    if (!res.ok) {
      const data = await res.json().catch(() => ({}));
      setError(data.error || "Could not create the invoice");
      return;
    }
    router.push("/admin/billing");
  };

  return (
    <main className="mx-auto max-w-2xl p-8">
      <Link href="/admin/billing" className="text-sm text-[#0982e8] hover:underline">
        ← Back to billing
      </Link>
      <h1 className="mb-6 mt-3 text-xl font-medium text-[#2C2C2A]">New invoice</h1>

      <section className="mb-6">
        <h2 className="mb-2 text-sm font-medium text-gray-700">Patient</h2>
        <PatientPicker value={patient} onChange={setPatient} autoFocus />
      </section>

      <section className="mb-6">
        <h2 className="mb-2 text-sm font-medium text-gray-700">Items</h2>
        <div className="mb-3 flex flex-wrap gap-2">
          {QUICK.map((q) => (
            <button
              key={q}
              onClick={() => addQuick(q)}
              className="rounded-full border border-gray-300 px-3 py-1 text-xs text-gray-600 hover:bg-gray-50"
            >
              + {q}
            </button>
          ))}
        </div>

        <div className="flex flex-col gap-2">
          {lines.map((l, i) => (
            <div key={i} className="flex items-center gap-2">
              <input
                placeholder="Description"
                value={l.description}
                onChange={(e) => setLine(i, { description: e.target.value })}
                className={`${input} min-w-0 flex-1`}
              />
              <input
                type="number"
                min="1"
                value={l.quantity}
                onChange={(e) => setLine(i, { quantity: e.target.value })}
                className={`${input} w-16`}
                aria-label="Quantity"
              />
              <input
                type="number"
                min="0"
                step="0.01"
                placeholder="Price"
                value={l.unitPrice}
                onChange={(e) => setLine(i, { unitPrice: e.target.value })}
                className={`${input} w-28`}
                aria-label="Unit price"
              />
              <span className="w-24 text-right text-sm text-gray-600">{kes(lineTotal(l))}</span>
              {lines.length > 1 && (
                <button
                  onClick={() => setLines((ls) => ls.filter((_, idx) => idx !== i))}
                  className="text-gray-400 hover:text-red-600"
                  aria-label="Remove line"
                >
                  ×
                </button>
              )}
            </div>
          ))}
        </div>

        <button
          onClick={() => setLines((ls) => [...ls, emptyLine()])}
          className="mt-2 text-sm text-[#0982e8] hover:underline"
        >
          + Add another line
        </button>
      </section>

      <div className="mb-4 flex justify-between border-t border-gray-200 pt-3 text-base font-medium">
        <span>Total</span>
        <span>{kes(total)}</span>
      </div>

      {error && <p className="mb-3 text-sm text-red-600">{error}</p>}

      <button
        onClick={submit}
        disabled={!valid || busy}
        className="rounded-md bg-[#0982e8] px-5 py-2 text-sm font-medium text-white hover:bg-[#0a70c4] disabled:opacity-50"
      >
        {busy ? "Creating..." : "Create invoice"}
      </button>
      <p className="mt-3 text-xs text-gray-500">
        Drugs dispensed from the pharmacy are added to the patient&apos;s unpaid invoice automatically —
        you only need to add consultations, tests, procedures and other charges here.
      </p>
    </main>
  );
}
