"use client";

import { useEffect, useState } from "react";

type Patient = { id: string; fileNumber: string; fullName: string };
type Trip = {
  id: string;
  pickupLocation: string;
  destination: string;
  status: string;
  dispatchedAt: string;
  patient: Patient | null;
};

const statusColor: Record<string, string> = {
  DISPATCHED: "text-amber-600",
  EN_ROUTE: "text-[#D85A30]",
  COMPLETED: "text-[#0982e8 ]",
  CANCELLED: "text-gray-500",
};

const NEXT_STATUS: Record<string, string> = {
  DISPATCHED: "EN_ROUTE",
  EN_ROUTE: "COMPLETED",
};

export default function AdminAmbulancePage() {
  const [trips, setTrips] = useState<Trip[]>([]);
  const [patients, setPatients] = useState<Patient[]>([]);
  const [error, setError] = useState("");
  const [form, setForm] = useState({
    patientId: "",
    pickupLocation: "",
    destination: "",
  });

  const load = async () => {
    const [tripsRes, patientsRes] = await Promise.all([
      fetch("/api/ambulance"),
      fetch("/api/patients"),
    ]);
    if (tripsRes.ok) setTrips((await tripsRes.json()).trips);
    if (patientsRes.ok) setPatients((await patientsRes.json()).patients);
  };

  useEffect(() => {
    load();
  }, []);

  const handleDispatch = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");
    const res = await fetch("/api/ambulance", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        patientId: form.patientId || null,
        pickupLocation: form.pickupLocation,
        destination: form.destination,
      }),
    });
    if (!res.ok) {
      const data = await res.json();
      setError(data.error || "Could not dispatch trip");
      return;
    }
    setForm({ patientId: "", pickupLocation: "", destination: "" });
    load();
  };

  const advanceStatus = async (trip: Trip) => {
    const next = NEXT_STATUS[trip.status];
    if (!next) return;
    await fetch(`/api/ambulance/${trip.id}/status`, {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ status: next }),
    });
    load();
  };

  const cancelTrip = async (trip: Trip) => {
    await fetch(`/api/ambulance/${trip.id}/status`, {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ status: "CANCELLED" }),
    });
    load();
  };

  return (
    <main className="grid gap-8 p-8 md:grid-cols-2">
      <section>
        <h1 className="mb-4 text-xl font-medium">Ambulance trips</h1>
        <div className="flex flex-col gap-3">
          {trips.length === 0 && (
            <p className="text-sm text-gray-500">No trips dispatched yet.</p>
          )}
          {trips.map((trip) => (
            <div key={trip.id} className="rounded-lg border border-gray-200 p-3">
              <div className="mb-1 flex items-center justify-between">
                <p className="text-sm font-medium">
                  {trip.pickupLocation} → {trip.destination}
                </p>
                <span className={`text-xs font-medium ${statusColor[trip.status]}`}>
                  {trip.status.replace("_", " ")}
                </span>
              </div>
              {trip.patient && (
                <p className="text-xs text-gray-500">
                  Patient: {trip.patient.fileNumber} — {trip.patient.fullName}
                </p>
              )}
              <p className="text-xs text-gray-400">
                {new Date(trip.dispatchedAt).toLocaleString()}
              </p>
              {(trip.status === "DISPATCHED" || trip.status === "EN_ROUTE") && (
                <div className="mt-2 flex gap-2">
                  <button
                    onClick={() => advanceStatus(trip)}
                    className="rounded-md bg-[#0982e8] px-3 py-1 text-xs font-medium text-white"
                  >
                    Mark {NEXT_STATUS[trip.status].replace("_", " ").toLowerCase()}
                  </button>
                  <button
                    onClick={() => cancelTrip(trip)}
                    className="rounded-md border border-gray-300 px-3 py-1 text-xs"
                  >
                    Cancel
                  </button>
                </div>
              )}
            </div>
          ))}
        </div>
      </section>

      <section>
        <h1 className="mb-4 text-xl font-medium">Dispatch trip</h1>
        <form onSubmit={handleDispatch} className="flex flex-col gap-2">
          <select
            value={form.patientId}
            onChange={(e) => setForm({ ...form, patientId: e.target.value })}
            className="rounded-md border border-gray-300 px-3 py-2 text-sm"
          >
            <option value="">No patient linked yet (optional)</option>
            {patients.map((p) => (
              <option key={p.id} value={p.id}>
                {p.fileNumber} — {p.fullName}
              </option>
            ))}
          </select>

          <input
            placeholder="Pickup location"
            value={form.pickupLocation}
            onChange={(e) => setForm({ ...form, pickupLocation: e.target.value })}
            required
            className="rounded-md border border-gray-300 px-3 py-2 text-sm"
          />

          <input
            placeholder="Destination"
            value={form.destination}
            onChange={(e) => setForm({ ...form, destination: e.target.value })}
            required
            className="rounded-md border border-gray-300 px-3 py-2 text-sm"
          />

          {error && <p className="text-sm text-red-600">{error}</p>}

          <button
            type="submit"
            className="rounded-md bg-[#D85A30] px-4 py-2 text-sm font-medium text-white"
          >
            Dispatch
          </button>
        </form>
      </section>
    </main>
  );
}