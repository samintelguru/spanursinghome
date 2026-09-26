"use client";

import { useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import {
  BLOOD_TYPES,
  COUNTIES,
  FILE_NUMBER_INCLUDES_YEAR,
  FILE_PREFIX,
  ID_TYPES,
  INSURERS,
  MARITAL_STATUSES,
  OUTSIDE_KENYA,
  RELATIONSHIPS,
  formatFileNumber,
} from "@/lib/patient";

export type PatientFormValues = {
  fullName: string;
  gender: "MALE" | "FEMALE";
  dateOfBirth: string; // YYYY-MM-DD
  dobEstimated: boolean;
  phone: string;
  email: string;
  idType: string;
  idNumber: string;
  maritalStatus: string;
  occupation: string;
  county: string;
  residence: string;
  nextOfKin: string;
  nextOfKinPhone: string;
  nextOfKinRelationship: string;
  bloodType: string;
  allergies: string;
  knownConditions: string;
  insuranceProvider: string;
  insuranceMemberNo: string;
};

export const EMPTY_PATIENT: PatientFormValues = {
  fullName: "",
  gender: "FEMALE",
  dateOfBirth: "",
  dobEstimated: false,
  phone: "",
  email: "",
  idType: "",
  idNumber: "",
  maritalStatus: "",
  occupation: "",
  county: "",
  residence: "",
  nextOfKin: "",
  nextOfKinPhone: "",
  nextOfKinRelationship: "",
  bloodType: "",
  allergies: "",
  knownConditions: "",
  insuranceProvider: "",
  insuranceMemberNo: "",
};

type Duplicate = { id: string; fullName: string; fileNumber: string; reason: string };

const inputCls = "mt-1 w-full rounded-md border border-gray-300 bg-white px-3 py-2 text-sm";

const isoToday = () => {
  const d = new Date();
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, "0")}-${String(d.getDate()).padStart(2, "0")}`;
};
const yearsSince = (iso: string) => {
  if (!iso) return null;
  const [y, m, d] = iso.split("-").map(Number);
  const now = new Date();
  let age = now.getFullYear() - y;
  if (now.getMonth() + 1 < m || (now.getMonth() + 1 === m && now.getDate() < d)) age--;
  return age >= 0 ? age : null;
};

function Field({ label, hint, children, wide }: { label: string; hint?: string; children: React.ReactNode; wide?: boolean }) {
  return (
    <label className={`text-sm text-gray-600 ${wide ? "sm:col-span-2" : ""}`}>
      {label}
      {children}
      {hint && <span className="mt-1 block text-xs text-gray-400">{hint}</span>}
    </label>
  );
}

function Section({ title, children }: { title: string; children: React.ReactNode }) {
  return (
    <fieldset className="rounded-lg border border-gray-200 bg-white p-4">
      <legend className="px-2 text-sm font-medium text-[#0B3D63]">{title}</legend>
      <div className="grid gap-3 sm:grid-cols-2">{children}</div>
    </fieldset>
  );
}

export default function PatientForm({
  mode,
  patientId,
  fileNumber,
  initial = EMPTY_PATIENT,
}: {
  mode: "create" | "edit";
  patientId?: string;
  fileNumber?: string;
  initial?: PatientFormValues;
}) {
  const router = useRouter();
  const [form, setForm] = useState<PatientFormValues>(initial);
  const [ageInput, setAgeInput] = useState("");
  const [hasOldNumber, setHasOldNumber] = useState(false);
  const [oldNumber, setOldNumber] = useState("");
  const [error, setError] = useState("");
  const [duplicate, setDuplicate] = useState<Duplicate | null>(null);
  const [saving, setSaving] = useState(false);
  const [created, setCreated] = useState<{ id: string; fileNumber: string; fullName: string } | null>(null);

  const set = <K extends keyof PatientFormValues>(key: K, value: PatientFormValues[K]) => {
    setForm((f) => ({ ...f, [key]: value }));
    setDuplicate(null);
  };

  const onDobChange = (value: string) => {
    setAgeInput("");
    setForm((f) => ({ ...f, dateOfBirth: value, dobEstimated: false }));
    setDuplicate(null);
  };

  // Only an age is known: estimate the birth date from it and flag it as estimated.
  const onAgeChange = (value: string) => {
    setAgeInput(value);
    const n = Number(value);
    if (value === "" || !Number.isInteger(n) || n < 0 || n > 120) return;
    const d = new Date();
    d.setFullYear(d.getFullYear() - n);
    const iso = `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, "0")}-${String(d.getDate()).padStart(2, "0")}`;
    setForm((f) => ({ ...f, dateOfBirth: iso, dobEstimated: true }));
    setDuplicate(null);
  };

  const submit = async (confirmDuplicate = false) => {
    setError("");
    setSaving(true);

    const url = mode === "create" ? "/api/patients" : `/api/patients/${patientId}`;
    let res: Response;
    let data: Record<string, any> = {}; // eslint-disable-line @typescript-eslint/no-explicit-any
    try {
      res = await fetch(url, {
        method: mode === "create" ? "POST" : "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          ...form,
          confirmDuplicate,
          ...(mode === "create" && hasOldNumber ? { legacyFileNumber: oldNumber } : {}),
        }),
      });
      data = await res.json().catch(() => ({}));
    } catch {
      setSaving(false);
      setError("Lost connection to the server. The record may not have been saved — check the Patients list before trying again.");
      return;
    }
    setSaving(false);

    if (res.status === 409 && data.duplicate) {
      setDuplicate(data.duplicate as Duplicate);
      setError(data.error);
      return;
    }
    if (!res.ok) {
      setError(data.error || "Something went wrong");
      return;
    }

    if (mode === "create") {
      setCreated({ id: data.patient.id, fileNumber: data.patient.fileNumber, fullName: data.patient.fullName });
    } else {
      router.push(`/admin/patients/${patientId}`);
      router.refresh();
    }
  };

  const reset = () => {
    setForm(EMPTY_PATIENT);
    setAgeInput("");
    setHasOldNumber(false);
    setOldNumber("");
    setError("");
    setDuplicate(null);
    setCreated(null);
    window.scrollTo({ top: 0 });
  };

  // ---------- success screen (new registrations) ----------
  if (created) {
    return (
      <div className="rounded-xl border border-gray-200 bg-white p-8 text-center">
        <p className="text-sm text-gray-500">Patient registered</p>
        <p className="mt-1 text-lg font-medium">{created.fullName}</p>
        <p className="mt-4 text-xs uppercase tracking-wide text-gray-400">File number</p>
        <p className="font-serif text-3xl font-semibold text-[#0B3D63]">{created.fileNumber}</p>
        <div className="mt-6 flex flex-wrap justify-center gap-3">
          <Link
            href={`/admin/patients/${created.id}`}
            className="rounded-md bg-[#0982e8] px-4 py-2 text-sm font-medium text-white hover:bg-[#0a70c4]"
          >
            Open patient file &amp; print ID card
          </Link>
          <button onClick={reset} className="rounded-md border border-gray-300 px-4 py-2 text-sm hover:bg-gray-50">
            Register another patient
          </button>
        </div>
      </div>
    );
  }

  const age = yearsSince(form.dateOfBirth);
  const example = formatFileNumber(1, new Date().getFullYear());

  return (
    <form
      onSubmit={(e) => {
        e.preventDefault();
        submit(false);
      }}
      className="flex flex-col gap-5"
    >
      {/* File number */}
      <div className="rounded-lg bg-[#E6F1FB] p-4 text-sm text-[#0C447C]">
        {mode === "edit" ? (
          <>
            File number: <span className="font-medium">{fileNumber}</span> (can&apos;t be changed)
          </>
        ) : (
          <>
            <p>
              <span className="font-medium">File number is assigned automatically</span> when you save, in the
              format <span className="font-mono">{example}</span>
              {FILE_NUMBER_INCLUDES_YEAR ? " (numbering restarts each year)" : ""}.
            </p>
            <label className="mt-2 flex items-center gap-2 text-xs">
              <input type="checkbox" checked={hasOldNumber} onChange={(e) => setHasOldNumber(e.target.checked)} />
              This patient already has a file number from the old system
            </label>
            {hasOldNumber && (
              <input
                value={oldNumber}
                onChange={(e) => setOldNumber(e.target.value.toUpperCase())}
                placeholder="Old file number, exactly as on their card"
                className="mt-2 w-full rounded-md border border-[#8FB8D9] bg-white px-3 py-2 text-sm text-gray-800"
              />
            )}
          </>
        )}
      </div>

      <Section title="Patient details">
        <Field label="Full name *" wide>
          <input
            value={form.fullName}
            onChange={(e) => set("fullName", e.target.value)}
            required
            autoFocus={mode === "create"}
            placeholder="First, middle and last name"
            className={inputCls}
          />
        </Field>

        <Field label="Gender *">
          <select value={form.gender} onChange={(e) => set("gender", e.target.value as "MALE" | "FEMALE")} className={inputCls}>
            <option value="FEMALE">Female</option>
            <option value="MALE">Male</option>
          </select>
        </Field>

        <Field label="Marital status">
          <select value={form.maritalStatus} onChange={(e) => set("maritalStatus", e.target.value)} className={inputCls}>
            <option value="">—</option>
            {MARITAL_STATUSES.map((m) => (
              <option key={m.value} value={m.value}>
                {m.label}
              </option>
            ))}
          </select>
        </Field>

        <Field label="Date of birth *" hint={age !== null ? `${form.dobEstimated ? "About " : ""}${age} year${age === 1 ? "" : "s"} old` : undefined}>
          <input
            type="date"
            value={form.dateOfBirth}
            max={isoToday()}
            onChange={(e) => onDobChange(e.target.value)}
            required
            className={inputCls}
          />
        </Field>

        <Field label="…or age, if date of birth is unknown" hint={form.dobEstimated ? "Date of birth will be saved as an estimate" : undefined}>
          <input
            type="number"
            min="0"
            max="120"
            value={ageInput}
            onChange={(e) => onAgeChange(e.target.value)}
            placeholder="Age in years"
            className={inputCls}
          />
        </Field>

        <Field label="ID type">
          <select value={form.idType} onChange={(e) => set("idType", e.target.value)} className={inputCls}>
            <option value="">—</option>
            {ID_TYPES.map((t) => (
              <option key={t.value} value={t.value}>
                {t.label}
              </option>
            ))}
          </select>
        </Field>

        <Field label="ID number">
          <input value={form.idNumber} onChange={(e) => set("idNumber", e.target.value.toUpperCase())} className={inputCls} />
        </Field>

        <Field label="Occupation" wide>
          <input value={form.occupation} onChange={(e) => set("occupation", e.target.value)} className={inputCls} />
        </Field>
      </Section>

      <Section title="Contact & address">
        <Field label="Phone">
          <input type="tel" inputMode="tel" value={form.phone} onChange={(e) => set("phone", e.target.value)} placeholder="0712 345 678" className={inputCls} />
        </Field>
        <Field label="Email">
          <input type="email" value={form.email} onChange={(e) => set("email", e.target.value)} className={inputCls} />
        </Field>
        <Field label="County">
          <select value={form.county} onChange={(e) => set("county", e.target.value)} className={inputCls}>
            <option value="">—</option>
            {COUNTIES.map((c) => (
              <option key={c} value={c}>
                {c}
              </option>
            ))}
            <option value={OUTSIDE_KENYA}>{OUTSIDE_KENYA}</option>
          </select>
        </Field>
        <Field label="Town / estate / village">
          <input value={form.residence} onChange={(e) => set("residence", e.target.value)} className={inputCls} />
        </Field>
      </Section>

      <Section title="Next of kin">
        <Field label="Name">
          <input value={form.nextOfKin} onChange={(e) => set("nextOfKin", e.target.value)} className={inputCls} />
        </Field>
        <Field label="Relationship">
          <select value={form.nextOfKinRelationship} onChange={(e) => set("nextOfKinRelationship", e.target.value)} className={inputCls}>
            <option value="">—</option>
            {RELATIONSHIPS.map((r) => (
              <option key={r} value={r}>
                {r}
              </option>
            ))}
          </select>
        </Field>
        <Field label="Phone" wide>
          <input type="tel" inputMode="tel" value={form.nextOfKinPhone} onChange={(e) => set("nextOfKinPhone", e.target.value)} className={inputCls} />
        </Field>
      </Section>

      <Section title="Medical">
        <Field label="Blood type">
          <select value={form.bloodType} onChange={(e) => set("bloodType", e.target.value)} className={inputCls}>
            <option value="">Unknown / not tested</option>
            {BLOOD_TYPES.map((b) => (
              <option key={b} value={b}>
                {b}
              </option>
            ))}
          </select>
        </Field>
        <span className="hidden sm:block" />
        <Field label="Allergies" hint="Drugs, foods, latex... leave blank if none reported" wide>
          <input value={form.allergies} onChange={(e) => set("allergies", e.target.value)} maxLength={300} className={inputCls} />
        </Field>
        <Field label="Known conditions" hint="e.g. diabetes, hypertension, asthma, HIV, epilepsy" wide>
          <textarea value={form.knownConditions} onChange={(e) => set("knownConditions", e.target.value)} rows={2} maxLength={500} className={inputCls} />
        </Field>
      </Section>

      <Section title="Insurance / payment">
        <Field label="Insurance provider" hint="Leave blank for cash patients">
          <input list="insurers" value={form.insuranceProvider} onChange={(e) => set("insuranceProvider", e.target.value)} className={inputCls} />
          <datalist id="insurers">
            {INSURERS.map((i) => (
              <option key={i} value={i} />
            ))}
          </datalist>
        </Field>
        <Field label="Member / policy number">
          <input value={form.insuranceMemberNo} onChange={(e) => set("insuranceMemberNo", e.target.value)} className={inputCls} />
        </Field>
      </Section>

      {error && (
        <div className="rounded-md border border-red-200 bg-red-50 p-3 text-sm text-red-700">
          <p>{error}</p>
          {duplicate && (
            <div className="mt-2 flex flex-wrap items-center gap-3">
              <span className="text-gray-700">
                {duplicate.fullName} · {duplicate.fileNumber}
              </span>
              <Link href={`/admin/patients/${duplicate.id}`} target="_blank" className="text-[#0982e8] underline">
                Open existing record
              </Link>
              <button
                type="button"
                onClick={() => submit(true)}
                disabled={saving}
                className="rounded-md border border-red-300 bg-white px-3 py-1 text-xs font-medium text-red-700 hover:bg-red-100 disabled:opacity-50"
              >
                It&apos;s a different person — {mode === "create" ? "register anyway" : "save anyway"}
              </button>
            </div>
          )}
        </div>
      )}

      <div className="flex gap-3">
        <button
          type="submit"
          disabled={saving}
          className="rounded-md bg-[#0982e8] px-5 py-2 text-sm font-medium text-white hover:bg-[#0a70c4] disabled:opacity-60"
        >
          {saving ? "Saving..." : mode === "create" ? "Register patient" : "Save changes"}
        </button>
        {mode === "edit" && (
          <Link href={`/admin/patients/${patientId}`} className="rounded-md border border-gray-300 px-5 py-2 text-sm hover:bg-gray-50">
            Cancel
          </Link>
        )}
      </div>
      <p className="-mt-2 text-xs text-gray-400">
        Fields marked * are required. The {FILE_PREFIX} file number is never reused or changed.
      </p>
    </form>
  );
}
