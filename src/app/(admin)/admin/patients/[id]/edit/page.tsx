import { PrismaClient } from "@prisma/client";
import Link from "next/link";
import { notFound } from "next/navigation";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";
import PatientForm, { type PatientFormValues } from "@/components/patient-form";

const prisma = new PrismaClient();

export default async function EditPatientPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;

  if (!session || !can(role, "registersPatients")) {
    return (
      <main className="mx-auto max-w-2xl p-4 sm:p-8">
        <p className="text-sm text-gray-600">Your role can&apos;t edit patient details.</p>
      </main>
    );
  }

  const { id } = await params;
  const p = await prisma.patient.findUnique({ where: { id } });
  if (!p) notFound();

  const initial: PatientFormValues = {
    fullName: p.fullName,
    gender: p.gender,
    dateOfBirth: p.dateOfBirth.toISOString().slice(0, 10),
    dobEstimated: p.dobEstimated,
    phone: p.phone ?? "",
    email: p.email ?? "",
    idType: p.idType ?? "",
    idNumber: p.idNumber ?? "",
    maritalStatus: p.maritalStatus ?? "",
    occupation: p.occupation ?? "",
    county: p.county ?? "",
    residence: p.residence ?? "",
    nextOfKin: p.nextOfKin ?? "",
    nextOfKinPhone: p.nextOfKinPhone ?? "",
    nextOfKinRelationship: p.nextOfKinRelationship ?? "",
    bloodType: p.bloodType ?? "",
    allergies: p.allergies ?? "",
    knownConditions: p.knownConditions ?? "",
    insuranceProvider: p.insuranceProvider ?? "",
    insuranceMemberNo: p.insuranceMemberNo ?? "",
  };

  return (
    <main className="mx-auto max-w-2xl p-4 sm:p-8">
      <Link href={`/admin/patients/${p.id}`} className="text-sm text-[#0982e8] hover:underline">
        ← Back to patient
      </Link>
      <h1 className="mb-6 mt-3 text-xl font-medium text-[#2C2C2A]">Edit {p.fullName}</h1>
      <PatientForm mode="edit" patientId={p.id} fileNumber={p.fileNumber} initial={initial} />
    </main>
  );
}
