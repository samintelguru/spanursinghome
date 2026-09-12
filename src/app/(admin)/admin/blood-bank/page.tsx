"use client";

import { useEffect, useState } from "react";

type Stock = { id: string; bloodType: string; unitsHeld: number };
type Patient = { id: string; fileNumber: string; fullName: string };

const BLOOD_TYPES = ["O+", "O-", "A+", "A-", "B+", "B-", "AB+", "AB-"];

export default function AdminBloodBankPage() {
  const [stock, setStock] = useState<Stock[]>([]);
  const [patients, setPatients] = useState<Patient[]>([]);
  const [error, setError] = useState("");
  const [message, setMessage] = useState("");

  const [addForm, setAddForm] = useState({ bloodType: "O+", units: "" });
  const [issueForm, setIssueForm] = useState({
    bloodStockId: "",
    patientId: "",
    units: "1",
  });

  const load = async () => {
    const [stockRes, patientsRes] = await Promise.all([
      fetch("/api/blood-bank"),
      fetch("/api/patients"),
    ]);
    if (stockRes.ok) setStock((await stockRes.json()).stock);
    if (patientsRes.ok) setPatients((await patientsRes.json()).patients);
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
    const res = await fetch("/api/blood-bank/issue", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        bloodStockId: issueForm.bloodStockId,
        patientId: issueForm.patientId,
        units: Number(issueForm.units),
      }),
    });
    if (!res.ok) {
      const data = await res.json();
      setError(data.error || "Could not issue blood");
      return;
    }
    setMessage("Units issued and stock updated.");
    setIssueForm({ bloodStockId: "", patientId: "", units: "1" });
    load();
  };

  return (
    <main className="grid gap-8 p-8 md:grid-cols-2">
      <section>
        <h1 className="mb-4 text-xl font-medium">Blood stock</h1>
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
          <select
            value={issueForm.patientId}
            onChange={(e) => setIssueForm({ ...issueForm, patientId: e.target.value })}
            required
            className="rounded-md border border-gray-300 px-3 py-2 text-sm"
          >
            <option value="">Select patient</option>
            {patients.map((p) => (
              <option key={p.id} value={p.id}>
                {p.fileNumber} — {p.fullName}
              </option>
            ))}
          </select>

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