"use client";

import { useEffect, useState } from "react";
import PatientPicker, { type PatientLite } from "@/components/patient-picker";

type Bed = {
  id: string;
  label: string;
  ward: string;
  status: "AVAILABLE" | "OCCUPIED" | "CLEANING";
  patient: { fullName: string; fileNumber: string } | null;
};

const statusStyle: Record<string, string> = {
  AVAILABLE: "bg-[#E6F1FB] border-[#B8D9F0]",
  OCCUPIED: "bg-[#FAECE7] border-[#E8C4B0]",
  CLEANING: "bg-[#F5F0DC] border-[#E0D5A0]",
};

const statusLabel: Record<string, string> = {
  AVAILABLE: "Available",
  OCCUPIED: "Occupied",
  CLEANING: "Needs cleaning",
};

export default function AdminBedsPage() {
  const [beds, setBeds] = useState<Bed[]>([]);
  const [admittingBedId, setAdmittingBedId] = useState<string | null>(null);
  const [selectedPatient, setSelectedPatient] = useState<PatientLite | null>(null);
  const [error, setError] = useState("");
  const [actionError, setActionError] = useState("");
  const [newBed, setNewBed] = useState({ label: "", ward: "General" });

  const load = async () => {
    try {
      const bedsRes = await fetch("/api/beds");
      if (bedsRes.ok) setBeds((await bedsRes.json()).beds);
    } catch {
      // Connection dropped — keep showing what we have.
    }
  };

  useEffect(() => {
    load();
  }, []);

  const handleAddBed = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");
    const res = await fetch("/api/beds", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(newBed),
    });
    if (!res.ok) {
      const data = await res.json();
      setError(data.error || "Could not add bed");
      return;
    }
    setNewBed({ label: "", ward: "General" });
    load();
  };

  // Sends a bed action and shows the server's message if it is refused
  // (e.g. patient already admitted, bed no longer available).
  const sendBedAction = async (bedId: string, payload: Record<string, string>) => {
    setActionError("");
    const res = await fetch(`/api/beds/${bedId}`, {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(payload),
    });
    if (!res.ok) {
      const data = await res.json().catch(() => ({}));
      setActionError(data.error || "Could not update the bed");
    }
    await load();
    return res.ok;
  };

  const handleAdmit = async (bedId: string) => {
    if (!selectedPatient) return;
    await sendBedAction(bedId, { action: "admit", patientId: selectedPatient.id });
    setAdmittingBedId(null);
    setSelectedPatient(null);
  };

  const handleDischarge = async (bedId: string) => {
    await sendBedAction(bedId, { action: "discharge" });
  };

  const handleMarkAvailable = async (bedId: string) => {
    await sendBedAction(bedId, { action: "mark_available" });
  };

  const wards = Array.from(new Set(beds.map((b) => b.ward)));

  return (
    <main className="p-8">
      <div className="mb-6 flex items-center justify-between">
        <h1 className="text-xl font-medium text-[#2C2C2A]">Bed board</h1>
      </div>

      {actionError && (
        <p className="mb-4 rounded-md border border-[#E8C4B0] bg-[#FAECE7] px-3 py-2 text-sm text-[#993C1D]">
          {actionError}
        </p>
      )}

      {wards.length === 0 ? (
        <p className="text-sm text-gray-500">No beds set up yet — add one below.</p>
      ) : (
        wards.map((ward) => (
          <div key={ward} className="mb-8">
            <h2 className="mb-3 text-sm font-medium text-gray-700">{ward}</h2>
            <div className="grid gap-3 sm:grid-cols-3 lg:grid-cols-4">
              {beds
                .filter((b) => b.ward === ward)
                .map((bed) => (
                  <div
                    key={bed.id}
                    className={`rounded-xl border p-4 ${statusStyle[bed.status]}`}
                  >
                    <p className="text-sm font-medium">{bed.label}</p>
                    <p className="mt-1 text-xs text-gray-600">
                      {statusLabel[bed.status]}
                    </p>

                    {bed.status === "OCCUPIED" && bed.patient && (
                      <p className="mt-2 text-xs">
                        {bed.patient.fullName} · {bed.patient.fileNumber}
                      </p>
                    )}

                    <div className="mt-3">
                      {bed.status === "AVAILABLE" &&
                        (admittingBedId === bed.id ? (
                          <div className="flex flex-col gap-1.5">
                            <PatientPicker
                              size="sm"
                              autoFocus
                              value={selectedPatient}
                              onChange={setSelectedPatient}
                              placeholder="Type patient name..."
                            />
                            <button
                              onClick={() => handleAdmit(bed.id)}
                              disabled={!selectedPatient}
                              className="rounded-md bg-[#0982e8] px-2 py-1 text-xs font-medium text-white disabled:opacity-50"
                            >
                              Confirm admit
                            </button>
                            <button
                              onClick={() => {
                                setAdmittingBedId(null);
                                setSelectedPatient(null);
                              }}
                              className="rounded-md border border-gray-300 px-2 py-1 text-xs"
                            >
                              Cancel
                            </button>
                          </div>
                        ) : (
                          <button
                            onClick={() => setAdmittingBedId(bed.id)}
                            className="rounded-md bg-[#0982e8] px-2 py-1 text-xs font-medium text-white"
                          >
                            Admit patient
                          </button>
                        ))}

                      {bed.status === "OCCUPIED" && (
                        <button
                          onClick={() => handleDischarge(bed.id)}
                          className="rounded-md border border-gray-400 px-2 py-1 text-xs"
                        >
                          Discharge
                        </button>
                      )}

                      {bed.status === "CLEANING" && (
                        <button
                          onClick={() => handleMarkAvailable(bed.id)}
                          className="rounded-md bg-[#0982e8] px-2 py-1 text-xs font-medium text-white"
                        >
                          Mark cleaned
                        </button>
                      )}
                    </div>
                  </div>
                ))}
            </div>
          </div>
        ))
      )}

      <div className="mt-10 max-w-sm">
        <h2 className="mb-2 text-sm font-medium text-gray-700">Add a bed</h2>
        <form onSubmit={handleAddBed} className="flex flex-col gap-2">
          <input
            placeholder="Label (e.g. Bed 4)"
            value={newBed.label}
            onChange={(e) => setNewBed({ ...newBed, label: e.target.value })}
            required
            className="rounded-md border border-gray-300 px-3 py-2 text-sm"
          />
          <select
            value={newBed.ward}
            onChange={(e) => setNewBed({ ...newBed, ward: e.target.value })}
            className="rounded-md border border-gray-300 px-3 py-2 text-sm"
          >
            <option value="General">General</option>
            <option value="Semi-Private">Semi-Private</option>
            <option value="Private">Private</option>
          </select>
          {error && <p className="text-sm text-red-600">{error}</p>}
          <button
            type="submit"
            className="rounded-md bg-[#0982e8] px-4 py-2 text-sm font-medium text-white"
          >
            Add bed
          </button>
        </form>
      </div>
    </main>
  );
}