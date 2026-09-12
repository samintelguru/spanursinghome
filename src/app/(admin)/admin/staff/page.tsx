"use client";

import { useEffect, useState } from "react";

type Staff = {
  id: string;
  fullName: string;
  email: string;
  role: string;
  active: boolean;
  createdAt: string;
};

const ROLES = [
  "ADMIN",
  "DOCTOR",
  "NURSE",
  "RECEPTIONIST",
  "PHARMACIST",
  "BILLING_CLERK",
  "LAB_TECH",
];

export default function AdminStaffPage() {
  const [staff, setStaff] = useState<Staff[]>([]);
  const [error, setError] = useState("");
  const [form, setForm] = useState({
    fullName: "",
    email: "",
    password: "",
    role: "RECEPTIONIST",
  });

  const load = async () => {
    const res = await fetch("/api/staff");
    if (!res.ok) {
      const data = await res.json().catch(() => ({}));
      setError(data.error || "Could not load staff");
      return;
    }
    setError("");
    setStaff((await res.json()).staff);
  };

  useEffect(() => {
    load();
  }, []);

  const handleAdd = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");
    const res = await fetch("/api/staff", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(form),
    });
    if (!res.ok) {
      const data = await res.json();
      setError(data.error || "Could not add staff");
      return;
    }
    setForm({ fullName: "", email: "", password: "", role: "RECEPTIONIST" });
    load();
  };

  const toggleActive = async (id: string) => {
    await fetch(`/api/staff/${id}/toggle`, { method: "PATCH" });
    load();
  };

  return (
    <main className="grid gap-8 p-8 md:grid-cols-2">
      <section>
        <h1 className="mb-4 text-xl font-medium">Staff accounts</h1>
        {error && <p className="mb-2 text-sm text-red-600">{error}</p>}
        <table className="w-full text-left text-sm">
          <thead>
            <tr className="border-b border-gray-200 text-gray-500">
              <th className="py-2 pr-4">Name</th>
              <th className="py-2 pr-4">Role</th>
              <th className="py-2 pr-4">Status</th>
              <th className="py-2 pr-4"></th>
            </tr>
          </thead>
          <tbody>
            {staff.map((s) => (
              <tr key={s.id} className="border-b border-gray-100">
                <td className="py-2 pr-4">
                  {s.fullName}
                  <div className="text-xs text-gray-400">{s.email}</div>
                </td>
                <td className="py-2 pr-4">{s.role.replace("_", " ")}</td>
                <td className="py-2 pr-4">
                  <span className={s.active ? "text-[#0982e8 ]" : "text-gray-400"}>
                    {s.active ? "Active" : "Inactive"}
                  </span>
                </td>
                <td className="py-2 pr-4">
                  <button
                    onClick={() => toggleActive(s.id)}
                    className="text-xs text-gray-500 underline"
                  >
                    {s.active ? "Deactivate" : "Reactivate"}
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </section>

      <section>
        <h1 className="mb-4 text-xl font-medium">Add staff account</h1>
        <form onSubmit={handleAdd} className="flex flex-col gap-2">
          <input
            placeholder="Full name"
            value={form.fullName}
            onChange={(e) => setForm({ ...form, fullName: e.target.value })}
            required
            className="rounded-md border border-gray-300 px-3 py-2 text-sm"
          />
          <input
            type="email"
            placeholder="Email"
            value={form.email}
            onChange={(e) => setForm({ ...form, email: e.target.value })}
            required
            className="rounded-md border border-gray-300 px-3 py-2 text-sm"
          />
          <input
            type="password"
            placeholder="Temporary password"
            value={form.password}
            onChange={(e) => setForm({ ...form, password: e.target.value })}
            required
            className="rounded-md border border-gray-300 px-3 py-2 text-sm"
          />
          <select
            value={form.role}
            onChange={(e) => setForm({ ...form, role: e.target.value })}
            className="rounded-md border border-gray-300 px-3 py-2 text-sm"
          >
            {ROLES.map((r) => (
              <option key={r} value={r}>{r.replace("_", " ")}</option>
            ))}
          </select>
          <button
            type="submit"
            className="rounded-md bg-[#0982e8] px-4 py-2 text-sm font-medium text-white"
          >
            Add staff
          </button>
        </form>
      </section>
    </main>
  );
}