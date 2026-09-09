"use client";

import { useEffect, useState } from "react";

type Note = {
  id: string;
  note: string;
  temperatureC: string | null;
  bloodPressure: string | null;
  pulseBpm: number | null;
  createdAt: string;
  recordedBy: { fullName: string };
};

export default function VisitNotesSection({ patientId }: { patientId: string }) {
  const [notes, setNotes] = useState<Note[]>([]);
  const [showForm, setShowForm] = useState(false);
  const [error, setError] = useState("");
  const [form, setForm] = useState({
    note: "",
    temperatureC: "",
    bloodPressure: "",
    pulseBpm: "",
  });

  const load = async () => {
    const res = await fetch(`/api/patients/${patientId}/visit-notes`);
    if (res.ok) setNotes((await res.json()).notes);
  };

  useEffect(() => {
    load();
  }, [patientId]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");
    const res = await fetch(`/api/patients/${patientId}/visit-notes`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(form),
    });
    if (!res.ok) {
      const data = await res.json();
      setError(data.error || "Could not save note");
      return;
    }
    setForm({ note: "", temperatureC: "", bloodPressure: "", pulseBpm: "" });
    setShowForm(false);
    load();
  };

  return (
    <section>
      <div className="mb-2 flex items-center justify-between">
        <h2 className="text-sm font-medium text-gray-700">Visit notes</h2>
        <button
          onClick={() => setShowForm(!showForm)}
          className="text-xs text-[#0B3D63 ] hover:underline"
        >
          {showForm ? "Cancel" : "+ Add note"}
        </button>
      </div>

      {showForm && (
        <form onSubmit={handleSubmit} className="mb-4 flex flex-col gap-2 rounded-lg border border-gray-200 p-3">
          <textarea
            placeholder="Note (symptoms, observations, treatment given...)"
            value={form.note}
            onChange={(e) => setForm({ ...form, note: e.target.value })}
            required
            rows={3}
            className="rounded-md border border-gray-300 px-3 py-2 text-sm"
          />
          <div className="flex gap-2">
            <input
              placeholder="Temp °C"
              type="number"
              step="0.1"
              value={form.temperatureC}
              onChange={(e) => setForm({ ...form, temperatureC: e.target.value })}
              className="w-1/3 rounded-md border border-gray-300 px-3 py-2 text-sm"
            />
            <input
              placeholder="BP (e.g. 120/80)"
              value={form.bloodPressure}
              onChange={(e) => setForm({ ...form, bloodPressure: e.target.value })}
              className="w-1/3 rounded-md border border-gray-300 px-3 py-2 text-sm"
            />
            <input
              placeholder="Pulse (bpm)"
              type="number"
              value={form.pulseBpm}
              onChange={(e) => setForm({ ...form, pulseBpm: e.target.value })}
              className="w-1/3 rounded-md border border-gray-300 px-3 py-2 text-sm"
            />
          </div>
          {error && <p className="text-sm text-red-600">{error}</p>}
          <button
            type="submit"
            className="self-start rounded-md bg-[#0B3D63 ] px-4 py-2 text-sm font-medium text-white"
          >
            Save note
          </button>
        </form>
      )}

      {notes.length === 0 ? (
        <p className="text-sm text-gray-400">No visit notes recorded.</p>
      ) : (
        <ul className="flex flex-col gap-3">
          {notes.map((n) => (
            <li key={n.id} className="rounded-lg border border-gray-100 p-3 text-sm">
              <div className="mb-1 flex justify-between text-xs text-gray-400">
                <span>{n.recordedBy.fullName}</span>
                <span>{new Date(n.createdAt).toLocaleString()}</span>
              </div>
              <p className="mb-1">{n.note}</p>
              {(n.temperatureC || n.bloodPressure || n.pulseBpm) && (
                <p className="text-xs text-gray-500">
                  {n.temperatureC && `Temp: ${n.temperatureC}°C  `}
                  {n.bloodPressure && `BP: ${n.bloodPressure}  `}
                  {n.pulseBpm && `Pulse: ${n.pulseBpm} bpm`}
                </p>
              )}
            </li>
          ))}
        </ul>
      )}
    </section>
  );
}