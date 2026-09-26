// Patient registration rules shared by the API and the forms. Pure functions
// only (no Prisma import) so client components can use them too.

// ---------- File number format ----------
// Change these three lines to change how new file numbers look:
//   year on:  SPA-2026-00001  (numbering restarts at 00001 each January)
//   year off: SPA-00001       (one continuous run)
export const FILE_PREFIX = "SPA";
export const FILE_NUMBER_INCLUDES_YEAR = true;
export const FILE_NUMBER_PAD = 5;

export function formatFileNumber(seq: number, year?: number) {
  const n = String(seq).padStart(FILE_NUMBER_PAD, "0");
  return FILE_NUMBER_INCLUDES_YEAR && year ? `${FILE_PREFIX}-${year}-${n}` : `${FILE_PREFIX}-${n}`;
}

// ---------- Pick lists ----------
export const BLOOD_TYPES = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"] as const;

export const ID_TYPES = [
  { value: "NATIONAL_ID", label: "National ID" },
  { value: "PASSPORT", label: "Passport" },
  { value: "BIRTH_CERTIFICATE", label: "Birth certificate" },
  { value: "ALIEN_ID", label: "Alien / refugee ID" },
  { value: "OTHER", label: "Other" },
] as const;

export const MARITAL_STATUSES = [
  { value: "SINGLE", label: "Single" },
  { value: "MARRIED", label: "Married" },
  { value: "DIVORCED", label: "Divorced / separated" },
  { value: "WIDOWED", label: "Widowed" },
] as const;

export const RELATIONSHIPS = [
  "Spouse",
  "Parent",
  "Child",
  "Sibling",
  "Guardian",
  "Friend",
  "Other",
] as const;

export const OUTSIDE_KENYA = "Outside Kenya";
export const COUNTIES = [
  "Baringo", "Bomet", "Bungoma", "Busia", "Elgeyo-Marakwet", "Embu", "Garissa", "Homa Bay",
  "Isiolo", "Kajiado", "Kakamega", "Kericho", "Kiambu", "Kilifi", "Kirinyaga", "Kisii",
  "Kisumu", "Kitui", "Kwale", "Laikipia", "Lamu", "Machakos", "Makueni", "Mandera",
  "Marsabit", "Meru", "Migori", "Mombasa", "Murang'a", "Nairobi", "Nakuru", "Nandi",
  "Narok", "Nyamira", "Nyandarua", "Nyeri", "Samburu", "Siaya", "Taita-Taveta", "Tana River",
  "Tharaka-Nithi", "Trans Nzoia", "Turkana", "Uasin Gishu", "Vihiga", "Wajir", "West Pokot",
] as const;

export const INSURERS = [
  "SHA", "NHIF", "Jubilee", "AAR", "Britam", "CIC", "Madison", "Old Mutual", "Resolution", "Minet",
];

// ---------- Validation ----------

export class PatientInputError extends Error {}

export type PatientInput = {
  fullName: string;
  gender: "MALE" | "FEMALE";
  dateOfBirth: Date;
  dobEstimated: boolean;
  phone: string | null;
  email: string | null;
  idType: string | null;
  idNumber: string | null;
  maritalStatus: string | null;
  occupation: string | null;
  county: string | null;
  residence: string | null;
  nextOfKin: string | null;
  nextOfKinPhone: string | null;
  nextOfKinRelationship: string | null;
  bloodType: string | null;
  allergies: string | null;
  knownConditions: string | null;
  insuranceProvider: string | null;
  insuranceMemberNo: string | null;
};

// Trim, collapse repeated spaces, cap length; empty -> null.
function text(v: unknown, max: number, label: string): string | null {
  if (v === undefined || v === null) return null;
  if (typeof v !== "string") throw new PatientInputError(`${label} is not valid`);
  const t = v.replace(/[\u0000-\u0008\u000B\u000C\u000E-\u001F]/g, "").replace(/[ \t]+/g, " ").trim();
  if (!t) return null;
  if (t.length > max) throw new PatientInputError(`${label} is too long (max ${max} characters)`);
  return t;
}

function phoneField(v: unknown, label: string): string | null {
  const t = text(v, 20, label);
  if (!t) return null;
  const digits = t.replace(/\D/g, "");
  if (!/^[0-9+()\s-]+$/.test(t) || digits.length < 7 || digits.length > 15) {
    throw new PatientInputError(`${label} doesn't look like a valid phone number`);
  }
  return t;
}

function oneOf(v: unknown, allowed: readonly string[], label: string): string | null {
  const t = text(v, 60, label);
  if (!t) return null;
  if (!allowed.includes(t)) throw new PatientInputError(`${label} is not a valid choice`);
  return t;
}

// Today's date in Nairobi as YYYY-MM-DD (servers run in UTC).
const todayEAT = () => new Date(Date.now() + 3 * 3600_000).toISOString().slice(0, 10);

export function parsePatientInput(raw: unknown): PatientInput {
  const b = (raw ?? {}) as Record<string, unknown>;

  const fullName = text(b.fullName, 100, "Full name");
  if (!fullName || fullName.length < 2) throw new PatientInputError("Enter the patient's full name");

  const gender = b.gender;
  if (gender !== "MALE" && gender !== "FEMALE") throw new PatientInputError("Choose the patient's gender");

  const dob = typeof b.dateOfBirth === "string" ? b.dateOfBirth.trim() : "";
  if (!/^\d{4}-\d{2}-\d{2}$/.test(dob)) throw new PatientInputError("Enter the date of birth (or the age)");
  const dateOfBirth = new Date(`${dob}T00:00:00.000Z`);
  if (Number.isNaN(dateOfBirth.getTime()) || dateOfBirth.toISOString().slice(0, 10) !== dob) {
    throw new PatientInputError("That date of birth isn't a real date");
  }
  if (dob > todayEAT()) throw new PatientInputError("Date of birth can't be in the future");
  if (dob < "1900-01-01") throw new PatientInputError("Date of birth is too far in the past");

  const email = text(b.email, 120, "Email")?.toLowerCase() ?? null;
  if (email && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
    throw new PatientInputError("Email address doesn't look right");
  }

  let idType = oneOf(b.idType, ID_TYPES.map((t) => t.value), "ID type");
  let idNumber = text(b.idNumber, 20, "ID number")?.toUpperCase() ?? null;
  if (idNumber && !/^[A-Z0-9/-]{3,20}$/.test(idNumber)) {
    throw new PatientInputError("ID number can only contain letters, numbers, / and -");
  }
  if (idNumber && !idType) throw new PatientInputError("Choose the ID type for that ID number");
  if (!idNumber) idType = null;

  const county = text(b.county, 40, "County");
  if (county && county !== OUTSIDE_KENYA && !(COUNTIES as readonly string[]).includes(county)) {
    throw new PatientInputError("County is not a valid choice");
  }

  return {
    fullName,
    gender,
    dateOfBirth,
    dobEstimated: b.dobEstimated === true,
    phone: phoneField(b.phone, "Phone number"),
    email,
    idType,
    idNumber,
    maritalStatus: oneOf(b.maritalStatus, MARITAL_STATUSES.map((m) => m.value), "Marital status"),
    occupation: text(b.occupation, 80, "Occupation"),
    county,
    residence: text(b.residence, 120, "Residence"),
    nextOfKin: text(b.nextOfKin, 100, "Next of kin"),
    nextOfKinPhone: phoneField(b.nextOfKinPhone, "Next of kin phone"),
    nextOfKinRelationship: oneOf(b.nextOfKinRelationship, RELATIONSHIPS, "Relationship"),
    bloodType: oneOf(b.bloodType, BLOOD_TYPES, "Blood type"),
    allergies: text(b.allergies, 300, "Allergies"),
    knownConditions: text(b.knownConditions, 500, "Known conditions"),
    insuranceProvider: text(b.insuranceProvider, 60, "Insurance provider"),
    insuranceMemberNo: text(b.insuranceMemberNo, 40, "Insurance member number"),
  };
}

// An old file number typed in for a patient coming from the previous system.
export function parseLegacyFileNumber(v: unknown): string | null {
  const t = text(v, 30, "Old file number")?.toUpperCase() ?? null;
  if (!t) return null;
  if (!/^[A-Z0-9][A-Z0-9/._-]{0,29}$/.test(t)) {
    throw new PatientInputError("Old file number can only contain letters, numbers and / . _ -");
  }
  return t;
}

// Whole years old at the given moment.
export function ageInYears(dob: Date | string, now: Date = new Date()) {
  const d = new Date(dob);
  let age = now.getUTCFullYear() - d.getUTCFullYear();
  const beforeBirthday =
    now.getUTCMonth() < d.getUTCMonth() ||
    (now.getUTCMonth() === d.getUTCMonth() && now.getUTCDate() < d.getUTCDate());
  if (beforeBirthday) age--;
  return Math.max(0, age);
}
