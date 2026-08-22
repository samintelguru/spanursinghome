"use client";

import { useEffect, useState } from "react";
import Link from "next/link";

type Patient = {
  id: string;
  fileNumber: string;
  fullName: string;
  gender: string;
  phone: string | null;
  createdAt: string;
};

export default function AdminPatientsPage() {
  const [patients, setPatients] = useState<Patient[]>([]);
  const [query, setQuery] = useState("");

  useEffect(() => {
    let cancelled = false;
    const timeout = setTimeout(async () => {
      const url = query
        ? `/api/patients?q=${encodeURIComponent(query)}`
        : "/api/patients";
      const res = await fetch(url);
      if (!cancelled && res.ok) {
        setPatients((await res.json()).patients);
      }
    }, 200);

    return () => {
      cancelled = true;
      clearTimeout(timeout);
    };
  }, [query]);

  return (
    <main className="p-8">
      <div className="mb-6 flex items-center justify-between">
        <h1 className="text-xl font-medium">Patients</h1>
        <Link
          href="/admin/patients/new"
          className="rounded-md bg-[#0F6E56] px-4 py-2 text-sm font-medium text-white"
        >
          Register patient
        </Link>
      </div>

      <input
        type="text"
        placeholder="Search by name or file number..."
        value={query}
        onChange={(e) => setQuery(e.target.value)}
        className="mb-4 w-full max-w-sm rounded-md border border-gray-300 px-3 py-2 text-sm"
      />

      {patients.length === 0 ? (
        <p className="text-sm text-gray-500">
          {query
            ? "No patients match your search."
            : "No patients registered yet. Register the first one to get started."}
        </p>
      ) : (
        <table className="w-full text-left text-sm">
          <thead>
            <tr className="border-b border-gray-200 text-gray-500">
              <th className="py-2 pr-4">File no.</th>
              <th className="py-2 pr-4">Name</th>
              <th className="py-2 pr-4">Gender</th>
              <th className="py-2 pr-4">Phone</th>
              <th className="py-2 pr-4">Registered</th>
            </tr>
          </thead>
          <tbody>
            {patients.map((p) => (
              <tr key={p.id} className="border-b border-gray-100">
                <td className="py-2 pr-4">
                  <Link
                    href={`/admin/patients/${p.id}`}
                    className="text-[#0F6E56] hover:underline"
                  >
                    {p.fileNumber}
                  </Link>
                </td>
                <td className="py-2 pr-4">
                  <Link href={`/admin/patients/${p.id}`} className="hover:underline">
                    {p.fullName}
                  </Link>
                </td>
                <td className="py-2 pr-4">{p.gender}</td>
                <td className="py-2 pr-4">{p.phone || "—"}</td>
                <td className="py-2 pr-4">
                  {new Date(p.createdAt).toLocaleDateString()}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </main>
  );
}