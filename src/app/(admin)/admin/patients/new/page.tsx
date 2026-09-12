"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";

export default function NewPatientPage() {
  const router = useRouter();
  const [form, setForm] = useState({
    fileNumber: "",
    fullName: "",
    gender: "FEMALE",
    dateOfBirth: "",
    phone: "",
    nextOfKin: "",
  });
  const [error, setError] = useState("");
  const [saving, setSaving] = useState(false);

  const update = (field: string, value: string) =>
    setForm((f) => ({ ...f, [field]: value }));

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");
    setSaving(true);

    const res = await fetch("/api/patients", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(form),
    });

    setSaving(false);

    if (!res.ok) {
      const data = await res.json();
      setError(data.error || "Something went wrong");
      return;
    }

    router.push("/admin/patients");
    router.refresh();
  };

  return (
    <main className="mx-auto max-w-lg p-8">
      <h1 className="mb-6 text-xl font-medium">Register patient</h1>
      <form onSubmit={handleSubmit} className="flex flex-col gap-3">
        <label className="text-sm text-gray-600">
          File number
          <input
            type="text"
            value={form.fileNumber}
            onChange={(e) => update("fileNumber", e.target.value)}
            required
            className="mt-1 w-full rounded-md border border-gray-300 px-3 py-2 text-sm"
          />
        </label>

        <label className="text-sm text-gray-600">
          Full name
          <input
            type="text"
            value={form.fullName}
            onChange={(e) => update("fullName", e.target.value)}
            required
            className="mt-1 w-full rounded-md border border-gray-300 px-3 py-2 text-sm"
          />
        </label>

        <label className="text-sm text-gray-600">
          Gender
          <select
            value={form.gender}
            onChange={(e) => update("gender", e.target.value)}
            className="mt-1 w-full rounded-md border border-gray-300 px-3 py-2 text-sm"
          >
            <option value="FEMALE">Female</option>
            <option value="MALE">Male</option>
          </select>
        </label>

        <label className="text-sm text-gray-600">
          Date of birth
          <input
            type="date"
            value={form.dateOfBirth}
            onChange={(e) => update("dateOfBirth", e.target.value)}
            required
            className="mt-1 w-full rounded-md border border-gray-300 px-3 py-2 text-sm"
          />
        </label>

        <label className="text-sm text-gray-600">
          Phone (optional)
          <input
            type="text"
            value={form.phone}
            onChange={(e) => update("phone", e.target.value)}
            className="mt-1 w-full rounded-md border border-gray-300 px-3 py-2 text-sm"
          />
        </label>

        <label className="text-sm text-gray-600">
          Next of kin (optional)
          <input
            type="text"
            value={form.nextOfKin}
            onChange={(e) => update("nextOfKin", e.target.value)}
            className="mt-1 w-full rounded-md border border-gray-300 px-3 py-2 text-sm"
          />
        </label>

        {error && <p className="text-sm text-red-600">{error}</p>}

        <button
          type="submit"
          disabled={saving}
          className="mt-2 rounded-md bg-[#0982e8] px-4 py-2 text-sm font-medium text-white disabled:opacity-60"
        >
          {saving ? "Saving..." : "Register patient"}
        </button>
      </form>
    </main>
  );
}