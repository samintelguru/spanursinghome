"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { EQUIPMENT_STATUSES, SERVICE_KINDS } from "@/lib/equipment";

const input = "mt-1 w-full rounded-md border border-gray-300 bg-white px-3 py-2 text-sm";
const isoToday = () => {
  const d = new Date();
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, "0")}-${String(d.getDate()).padStart(2, "0")}`;
};

// Record a service, repair, calibration or inspection.
export function LogService({ equipmentId, currentStatus }: { equipmentId: string; currentStatus: string }) {
  const router = useRouter();
  const [open, setOpen] = useState(false);
  const [f, setF] = useState({ kind: "SERVICE", performedOn: isoToday(), performedBy: "", cost: "", notes: "", statusAfter: "" });
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState("");

  const submit = async () => {
    setBusy(true);
    setError("");
    try {
      const res = await fetch(`/api/equipment/${equipmentId}/service`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(f),
      });
      const data = await res.json().catch(() => ({}));
      if (!res.ok) {
        setError(data.error || "Something went wrong");
        return;
      }
      setOpen(false);
      setF({ kind: "SERVICE", performedOn: isoToday(), performedBy: "", cost: "", notes: "", statusAfter: "" });
      router.refresh();
    } catch {
      setError("Lost connection to the server. It may not have been saved — refresh the page to check.");
    } finally {
      setBusy(false);
    }
  };

  if (!open) {
    return (
      <button
        onClick={() => setOpen(true)}
        className="rounded-md bg-[#0982e8] px-4 py-2 text-sm font-medium text-white hover:bg-[#0a70c4]"
      >
        Log service / repair
      </button>
    );
  }

  return (
    <div className="rounded-lg border border-[#8FB8D9] bg-white p-4">
      <p className="mb-3 text-sm font-medium text-[#0B3D63]">Log service or repair</p>
      <div className="grid gap-3 sm:grid-cols-2">
        <label className="text-xs text-gray-500">
          What was done *
          <select value={f.kind} onChange={(e) => setF({ ...f, kind: e.target.value })} className={input}>
            {SERVICE_KINDS.map((k) => (
              <option key={k.value} value={k.value}>
                {k.label}
              </option>
            ))}
          </select>
        </label>
        <label className="text-xs text-gray-500">
          Date *
          <input type="date" max={isoToday()} value={f.performedOn} onChange={(e) => setF({ ...f, performedOn: e.target.value })} className={input} />
        </label>
        <label className="text-xs text-gray-500">
          Done by (technician or company)
          <input value={f.performedBy} onChange={(e) => setF({ ...f, performedBy: e.target.value })} className={input} />
        </label>
        <label className="text-xs text-gray-500">
          Cost (KES)
          <input type="number" min="0" step="0.01" value={f.cost} onChange={(e) => setF({ ...f, cost: e.target.value })} className={input} />
        </label>
        <label className="text-xs text-gray-500">
          Status afterwards
          <select value={f.statusAfter} onChange={(e) => setF({ ...f, statusAfter: e.target.value })} className={input}>
            <option value="">Keep as it is</option>
            {EQUIPMENT_STATUSES.filter((s) => s.value !== currentStatus).map((s) => (
              <option key={s.value} value={s.value}>
                {s.label}
              </option>
            ))}
          </select>
        </label>
        <label className="text-xs text-gray-500">
          Notes
          <input value={f.notes} onChange={(e) => setF({ ...f, notes: e.target.value })} placeholder="What was found / replaced" className={input} />
        </label>
      </div>
      <p className="mt-2 text-xs text-gray-400">
        Services, calibrations and inspections reset the service schedule. A repair is recorded but doesn&apos;t change it.
      </p>
      {error && <p className="mt-2 text-sm text-red-600">{error}</p>}
      <div className="mt-3 flex gap-2">
        <button
          onClick={submit}
          disabled={busy}
          className="rounded-md bg-[#0982e8] px-4 py-2 text-sm font-medium text-white hover:bg-[#0a70c4] disabled:opacity-50"
        >
          {busy ? "Saving..." : "Save"}
        </button>
        <button onClick={() => setOpen(false)} className="rounded-md border border-gray-300 px-4 py-2 text-sm">
          Cancel
        </button>
      </div>
    </div>
  );
}

// Administrators only — for a record made by mistake.
export function DeleteEquipment({ equipmentId, name }: { equipmentId: string; name: string }) {
  const router = useRouter();
  const [error, setError] = useState("");
  const [busy, setBusy] = useState(false);

  const remove = async () => {
    if (!confirm(`Delete “${name}” from the register? This can't be undone.`)) return;
    setBusy(true);
    setError("");
    try {
      const res = await fetch(`/api/equipment/${equipmentId}`, { method: "DELETE" });
      const data = await res.json().catch(() => ({}));
      if (!res.ok) {
        setError(data.error || "Could not delete");
        return;
      }
      router.push("/admin/equipment");
      router.refresh();
    } catch {
      setError("Can't reach the server. Check your internet connection.");
    } finally {
      setBusy(false);
    }
  };

  return (
    <div>
      <button onClick={remove} disabled={busy} className="text-xs text-gray-400 hover:text-red-600 disabled:opacity-50">
        Delete this record
      </button>
      {error && <p className="mt-1 text-xs text-red-600">{error}</p>}
    </div>
  );
}
