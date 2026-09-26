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

const PAGE_SIZE = 50;

export default function AdminPatientsPage() {
  const [patients, setPatients] = useState<Patient[]>([]);
  const [query, setQuery] = useState("");
  const [offline, setOffline] = useState(false);

  useEffect(() => {
    let cancelled = false;
    const timeout = setTimeout(async () => {
      const url = query.trim()
        ? `/api/patients?q=${encodeURIComponent(query.trim())}&limit=${PAGE_SIZE}`
        : `/api/patients?limit=${PAGE_SIZE}`;
      try {
        const res = await fetch(url);
        if (cancelled) return;
        if (res.ok) {
          setPatients((await res.json()).patients);
          setOffline(false);
        }
      } catch {
        // Connection dropped mid-request — tell the user instead of failing silently.
        if (!cancelled) setOffline(true);
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
          className="rounded-md bg-[#0982e8] px-4 py-2 text-sm font-medium text-white"
        >
          Register patient
        </Link>
      </div>

      {offline && (
        <p className="mb-3 rounded-md bg-[#FFF3D6] px-3 py-2 text-sm text-[#8A5A00]">
          Can&apos;t reach the server. Check your internet connection — the list will refresh when you type again.
        </p>
      )}
      <input
        type="text"
        placeholder="Type the first letters of a name, or a file / phone number..."
        value={query}
        onChange={(e) => setQuery(e.target.value)}
        className="mb-4 w-full max-w-md rounded-md border border-gray-300 px-3 py-2 text-sm"
        autoFocus
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
              <th className="py-2 pr-4">Name</th>
              <th className="py-2 pr-4">File no.</th>
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
                    className="font-medium text-[#0982e8] hover:underline"
                  >
                    {p.fullName}
                  </Link>
                </td>
                <td className="py-2 pr-4 text-gray-600">{p.fileNumber}</td>
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

      {patients.length >= PAGE_SIZE && (
        <p className="mt-3 text-xs text-gray-500">
          Showing {query.trim() ? "the first" : "the latest"} {PAGE_SIZE} patients — type in the box above to find
          someone specific.
        </p>
      )}
    </main>
  );
}