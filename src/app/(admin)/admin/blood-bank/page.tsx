"use client";

import { useEffect, useState } from "react";
import PatientPicker, { type PatientLite } from "@/components/patient-picker";

type Stock = { id: string; bloodType: string; unitsHeld: number };

const BLOOD_TYPES = ["O+", "O-", "A+", "A-", "B+", "B-", "AB+", "AB-"];

export default function AdminBloodBankPage() {
  const [stock, setStock] = useState<Stock[]>([]);
  const [patient, setPatient] = useState<PatientLite | null>(null);
  const [error, setError] = useState("");
  const [message, setMessage] = useState("");

  const [addForm, setAddForm] = useState({ bloodType: "O+", units: "" });
  const [issueForm, setIssueForm] = useState({
    bloodStockId: "",
    units: "1",
  });

  const load = async () => {
    try {
      const stockRes = await fetch("/api/blood-bank");
      if (stockRes.ok) setStock((await stockRes.json()).stock);
    } catch {
      // Connection dropped — keep showing what we have.
    }
  };

  useEffect(() => {
    load();
  }, []);

  const handleAddStock = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");
    const res = await fetch("/api/blood-bank", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(addForm),
    });
    if (!res.ok) {
      const data = await res.json();
      setError(data.error || "Could not add stock");
      return;
    }
    setAddForm({ bloodType: "O+", units: "" });
    load();
  };

  const handleIssue = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");
    setMessage("");
    if (!patient) {
      setError("Choose a patient first");
      return;
    }
    const res = await fetch("/api/blood-bank/issue", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        bloodStockId: issueForm.bloodStockId,
        patientId: patient.id,
        units: Number(issueForm.units),
      }),
    });
    if (!res.ok) {
      const data = await res.json();
      setError(data.error || "Could not issue blood");
      return;
    }
    setMessage("Units issued and stock updated.");
    setPatient(null);
    setIssueForm({ bloodStockId: "", units: "1" });
    load();
  };

  return (
    <main className="grid gap-8 p-4 sm:p-8 md:grid-cols-2">
      <section>
        <h1 className="mb-4 text-xl font-medium">Blood stock</h1>
        <div className="overflow-x-auto">
        <table className="mb-6 w-full text-left text-sm">
          <thead>
            <tr className="border-b border-gray-200 text-gray-500">
              <th className="py-2 pr-4">Type</th>
              <th className="py-2 pr-4">Units held</th>
            </tr>
          </thead>
          <tbody>
            {stock.map((s) => (
              <tr key={s.id} className="border-b border-gray-100">
                <td className="py-2 pr-4">{s.bloodType}</td>
                <td className="py-2 pr-4">
                  {s.unitsHeld}
                  {s.unitsHeld <= 2 && (
                    <span className="ml-2 text-xs text-red-600">low</span>
                  )}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
        </div>

        <h2 className="mb-2 text-sm font-medium">Add stock</h2>
        <form onSubmit={handleAddStock} className="flex flex-col gap-2">
          <select
            value={addForm.bloodType}
            onChange={(e) => setAddForm({ ...addForm, bloodType: e.target.value })}
            className="rounded-md border border-gray-300 px-3 py-2 text-sm"
          >
            {BLOOD_TYPES.map((t) => (
              <option key={t} value={t}>{t}</option>
            ))}
          </select>
          <input
            type="number"
            min="1"
            placeholder="Units to add"
            value={addForm.units}
            onChange={(e) => setAddForm({ ...addForm, units: e.target.value })}
            required
            className="rounded-md border border-gray-300 px-3 py-2 text-sm"
          />
          <button
            type="submit"
            className="rounded-md bg-[#0982e8] px-4 py-2 text-sm font-medium text-white"
          >
            Add stock
          </button>
        </form>
      </section>

      <section>
        <h1 className="mb-4 text-xl font-medium">Issue to patient</h1>
        <form onSubmit={handleIssue} className="flex flex-col gap-2">
          <PatientPicker value={patient} onChange={setPatient} />

          <select
            value={issueForm.bloodStockId}
            onChange={(e) => setIssueForm({ ...issueForm, bloodStockId: e.target.value })}
            required
            className="rounded-md border border-gray-300 px-3 py-2 text-sm"
          >
            <option value="">Select blood type</option>
            {stock.map((s) => (
              <option key={s.id} value={s.id}>
                {s.bloodType} ({s.unitsHeld} units left)
              </option>
            ))}
          </select>

          <input
            type="number"
            min="1"
            placeholder="Units to issue"
            value={issueForm.units}
            onChange={(e) => setIssueForm({ ...issueForm, units: e.target.value })}
            required
            className="rounded-md border border-gray-300 px-3 py-2 text-sm"
          />

          {error && <p className="text-sm text-red-600">{error}</p>}
          {message && <p className="text-sm text-[#0982e8]">{message}</p>}

          <button
            type="submit"
            className="rounded-md bg-[#D85A30] px-4 py-2 text-sm font-medium text-white"
          >
            Issue blood
          </button>
        </form>
      </section>
    </main>
  );
}