"use client";

import { useEffect, useState } from "react";

type Drug = {
  id: string;
  name: string;
  unit: string;
  unitPrice: string;
  stockQty: number;
  reorderAt: number;
};

type Patient = {
  id: string;
  fileNumber: string;
  fullName: string;
};

export default function AdminPharmacyPage() {
  const [drugs, setDrugs] = useState<Drug[]>([]);
  const [patients, setPatients] = useState<Patient[]>([]);
  const [message, setMessage] = useState("");
  const [error, setError] = useState("");

  const [newDrug, setNewDrug] = useState({
    name: "",
    unit: "tablet",
    unitPrice: "",
    stockQty: "",
  });

  const [dispenseForm, setDispenseForm] = useState({
    patientId: "",
    drugId: "",
    quantity: "1",
  });

  const loadData = async () => {
    const [drugsRes, patientsRes] = await Promise.all([
      fetch("/api/pharmacy/drugs"),
      fetch("/api/patients"),
    ]);
    if (drugsRes.ok) setDrugs((await drugsRes.json()).drugs);
    if (patientsRes.ok) setPatients((await patientsRes.json()).patients);
  };

  useEffect(() => {
    loadData();
  }, []);

  const handleAddDrug = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");
    const res = await fetch("/api/pharmacy/drugs", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(newDrug),
    });
    if (!res.ok) {
      const data = await res.json();
      setError(data.error || "Could not add drug");
      return;
    }
    setNewDrug({ name: "", unit: "tablet", unitPrice: "", stockQty: "" });
    loadData();
  };

  const handleDispense = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");
    setMessage("");
    const res = await fetch("/api/pharmacy/dispense", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        patientId: dispenseForm.patientId,
        drugId: dispenseForm.drugId,
        quantity: Number(dispenseForm.quantity),
      }),
    });
    if (!res.ok) {
      const data = await res.json();
      setError(data.error || "Could not dispense");
      return;
    }
    setMessage("Dispensed and added to patient's bill.");
    setDispenseForm({ patientId: "", drugId: "", quantity: "1" });
    loadData();
  };

  return (
    <main className="grid gap-8 p-8 md:grid-cols-2">
      <section>
        <h1 className="mb-4 text-xl font-medium">Drug inventory</h1>
        <table className="mb-6 w-full text-left text-sm">
          <thead>
            <tr className="border-b border-gray-200 text-gray-500">
              <th className="py-2 pr-4">Name</th>
              <th className="py-2 pr-4">Stock</th>
              <th className="py-2 pr-4">Unit price</th>
            </tr>
          </thead>
          <tbody>
            {drugs.map((d) => (
              <tr key={d.id} className="border-b border-gray-100">
                <td className="py-2 pr-4">{d.name}</td>
                <td className="py-2 pr-4">
                  {d.stockQty} {d.unit}
                  {d.stockQty <= d.reorderAt && (
                    <span className="ml-2 text-xs text-red-600">low</span>
                  )}
                </td>
                <td className="py-2 pr-4">KES {d.unitPrice}</td>
              </tr>
            ))}
          </tbody>
        </table>

        <h2 className="mb-2 text-sm font-medium">Add drug</h2>
        <form onSubmit={handleAddDrug} className="flex flex-col gap-2">
          <input
            placeholder="Drug name"
            value={newDrug.name}
            onChange={(e) => setNewDrug({ ...newDrug, name: e.target.value })}
            required
            className="rounded-md border border-gray-300 px-3 py-2 text-sm"
          />
          <div className="flex gap-2">
            <input
              placeholder="Unit (tablet, ml...)"
              value={newDrug.unit}
              onChange={(e) => setNewDrug({ ...newDrug, unit: e.target.value })}
              className="w-1/2 rounded-md border border-gray-300 px-3 py-2 text-sm"
            />
            <input
              placeholder="Unit price (KES)"
              type="number"
              step="0.01"
              value={newDrug.unitPrice}
              onChange={(e) =>
                setNewDrug({ ...newDrug, unitPrice: e.target.value })
              }
              required
              className="w-1/2 rounded-md border border-gray-300 px-3 py-2 text-sm"
            />
          </div>
          <input
            placeholder="Starting stock quantity"
            type="number"
            value={newDrug.stockQty}
            onChange={(e) =>
              setNewDrug({ ...newDrug, stockQty: e.target.value })
            }
            required
            className="rounded-md border border-gray-300 px-3 py-2 text-sm"
          />
          <button
            type="submit"
            className="rounded-md bg-[#0982e8] px-4 py-2 text-sm font-medium text-white"
          >
            Add drug
          </button>
        </form>
      </section>

      <section>
        <h1 className="mb-4 text-xl font-medium">Dispense to patient</h1>
        <form onSubmit={handleDispense} className="flex flex-col gap-2">
          <select
            value={dispenseForm.patientId}
            onChange={(e) =>
              setDispenseForm({ ...dispenseForm, patientId: e.target.value })
            }
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
            value={dispenseForm.drugId}
            onChange={(e) =>
              setDispenseForm({ ...dispenseForm, drugId: e.target.value })
            }
            required
            className="rounded-md border border-gray-300 px-3 py-2 text-sm"
          >
            <option value="">Select drug</option>
            {drugs.map((d) => (
              <option key={d.id} value={d.id}>
                {d.name} ({d.stockQty} {d.unit} left)
              </option>
            ))}
          </select>

          <input
            type="number"
            min="1"
            placeholder="Quantity"
            value={dispenseForm.quantity}
            onChange={(e) =>
              setDispenseForm({ ...dispenseForm, quantity: e.target.value })
            }
            required
            className="rounded-md border border-gray-300 px-3 py-2 text-sm"
          />

          {error && <p className="text-sm text-red-600">{error}</p>}
          {message && <p className="text-sm text-[#0982e8]">{message}</p>}

          <button
            type="submit"
            className="rounded-md bg-[#D85A30] px-4 py-2 text-sm font-medium text-white"
          >
            Dispense
          </button>
        </form>
      </section>
    </main>
  );
}