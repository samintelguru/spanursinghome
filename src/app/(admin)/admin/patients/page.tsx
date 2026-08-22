import { PrismaClient } from "@prisma/client";
import Link from "next/link";

const prisma = new PrismaClient();

export default async function AdminPatientsPage() {
  const patients = await prisma.patient.findMany({
    orderBy: { createdAt: "desc" },
  });

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

      {patients.length === 0 ? (
        <p className="text-sm text-gray-500">
          No patients registered yet. Register the first one to get started.
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
                <td className="py-2 pr-4">{p.fileNumber}</td>
                <td className="py-2 pr-4">{p.fullName}</td>
                <td className="py-2 pr-4">{p.gender}</td>
                <td className="py-2 pr-4">{p.phone || "—"}</td>
                <td className="py-2 pr-4">
                  {p.createdAt.toLocaleDateString()}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </main>
  );
}