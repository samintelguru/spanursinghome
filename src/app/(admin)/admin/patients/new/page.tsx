import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";
import PatientForm from "@/components/patient-form";

export default async function NewPatientPage() {
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;

  if (!session || !can(role, "registersPatients")) {
    return (
      <main className="mx-auto max-w-2xl p-8">
        <p className="text-sm text-gray-600">Your role can&apos;t register patients.</p>
      </main>
    );
  }

  return (
    <main className="mx-auto max-w-2xl p-8">
      <h1 className="mb-6 text-xl font-medium text-[#2C2C2A]">Register patient</h1>
      <PatientForm mode="create" />
    </main>
  );
}
