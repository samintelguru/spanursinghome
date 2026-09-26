// Equipment inventory rules shared by the API and the pages.
// Pure functions only (no Prisma import).

export type EquipmentStatusValue = "IN_USE" | "IN_STORAGE" | "UNDER_REPAIR" | "OUT_OF_SERVICE" | "DISPOSED";
export type ServiceKindValue = "SERVICE" | "REPAIR" | "CALIBRATION" | "INSPECTION";

export const EQUIPMENT_STATUSES = [
  { value: "IN_USE", label: "In use" },
  { value: "IN_STORAGE", label: "In storage" },
  { value: "UNDER_REPAIR", label: "Under repair" },
  { value: "OUT_OF_SERVICE", label: "Out of service" },
  { value: "DISPOSED", label: "Disposed / written off" },
] as const;

export const STATUS_STYLE: Record<string, string> = {
  IN_USE: "bg-[#E6F1FB] text-[#0C447C]",
  IN_STORAGE: "bg-gray-100 text-gray-600",
  UNDER_REPAIR: "bg-[#FFF3D6] text-[#8A5A00]",
  OUT_OF_SERVICE: "bg-[#FAECE7] text-[#993C1D]",
  DISPOSED: "bg-gray-100 text-gray-400",
};

export const statusLabel = (v: string) => EQUIPMENT_STATUSES.find((s) => s.value === v)?.label ?? v;

export const SERVICE_KINDS = [
  { value: "SERVICE", label: "Routine service" },
  { value: "REPAIR", label: "Repair" },
  { value: "CALIBRATION", label: "Calibration" },
  { value: "INSPECTION", label: "Safety inspection" },
] as const;

export const kindLabel = (v: string) => SERVICE_KINDS.find((k) => k.value === v)?.label ?? v;

// Suggestions only — staff can type any category.
export const SUGGESTED_CATEGORIES = [
  "Diagnostic",
  "Patient monitoring",
  "Theatre & surgical",
  "Laboratory",
  "Maternity & neonatal",
  "Emergency & resuscitation",
  "Sterilisation",
  "Beds & furniture",
  "Mobility",
  "Power & backup",
  "IT & communication",
  "Vehicles",
  "Kitchen & laundry",
  "Cleaning",
  "Office",
  "Other",
];

export class EquipmentError extends Error {
  status: number;
  constructor(status: number, message: string) {
    super(message);
    this.status = status;
  }
}

// ---------- dates ----------

const DAY = 24 * 60 * 60 * 1000;
export const todayEATString = () => new Date(Date.now() + 3 * 3600_000).toISOString().slice(0, 10);

// Whole-month addition in UTC ("31 Jan + 1 month" -> "28/29 Feb", never "3 Mar").
export function addMonthsUTC(d: Date, months: number) {
  const y = d.getUTCFullYear();
  const m = d.getUTCMonth() + months;
  const day = d.getUTCDate();
  const lastDay = new Date(Date.UTC(y, m + 1, 0)).getUTCDate();
  return new Date(Date.UTC(y, m, Math.min(day, lastDay)));
}

// When the next service is due: interval after the last service, or after
// purchase if it has never been serviced. null when we can't tell.
export function computeNextService(
  intervalMonths: number | null,
  lastServiceDate: Date | null,
  purchaseDate: Date | null
): Date | null {
  if (!intervalMonths) return null;
  const base = lastServiceDate ?? purchaseDate;
  return base ? addMonthsUTC(base, intervalMonths) : null;
}

// "overdue" | "soon" (within 30 days) | null.  Due dates are whole dates
// (stored at UTC midnight), so compare against today's Nairobi date.
export function serviceState(nextDue: string | Date | null, status: string): "overdue" | "soon" | null {
  if (!nextDue || status === "DISPOSED") return null;
  const today = new Date(`${todayEATString()}T00:00:00.000Z`).getTime();
  const days = (new Date(nextDue).getTime() - today) / DAY;
  if (days < 0) return "overdue";
  return days <= 30 ? "soon" : null;
}

// "expired" | "soon" (within 60 days) | null
export function warrantyState(expiry: string | Date | null, status: string): "expired" | "soon" | null {
  if (!expiry || status === "DISPOSED") return null;
  const today = new Date(`${todayEATString()}T00:00:00.000Z`).getTime();
  const days = (new Date(expiry).getTime() - today) / DAY;
  if (days < 0) return "expired";
  return days <= 60 ? "soon" : null;
}

// ---------- validation ----------

export type EquipmentInput = {
  name: string;
  category: string;
  make: string | null;
  model: string | null;
  serialNumber: string | null;
  location: string | null;
  quantity: number;
  status: EquipmentStatusValue;
  purchaseDate: Date | null;
  purchaseCost: number | null;
  supplier: string | null;
  warrantyExpiry: Date | null;
  serviceIntervalMonths: number | null;
  lastServiceDate: Date | null;
  notes: string | null;
};

function text(v: unknown, max: number, label: string): string | null {
  if (v === undefined || v === null) return null;
  if (typeof v !== "string") throw new EquipmentError(400, `${label} is not valid`);
  const t = v.replace(/[\u0000-\u0008\u000B\u000C\u000E-\u001F]/g, "").replace(/[ \t]+/g, " ").trim();
  if (!t) return null;
  if (t.length > max) throw new EquipmentError(400, `${label} is too long (max ${max} characters)`);
  return t;
}

export function parseDate(v: unknown, label: string, opts: { notFuture?: boolean } = {}): Date | null {
  const t = typeof v === "string" ? v.trim() : "";
  if (!t) return null;
  if (!/^\d{4}-\d{2}-\d{2}$/.test(t)) throw new EquipmentError(400, `${label} must be a date`);
  const d = new Date(`${t}T00:00:00.000Z`);
  if (Number.isNaN(d.getTime()) || d.toISOString().slice(0, 10) !== t) {
    throw new EquipmentError(400, `${label} isn't a real date`);
  }
  if (t < "1950-01-01" || t > "2100-12-31") throw new EquipmentError(400, `${label} is out of range`);
  if (opts.notFuture && t > todayEATString()) throw new EquipmentError(400, `${label} can't be in the future`);
  return d;
}

function money(v: unknown, label: string): number | null {
  if (v === undefined || v === null || v === "") return null;
  const n = Number(v);
  if (!Number.isFinite(n) || n < 0 || n > 1_000_000_000) throw new EquipmentError(400, `Enter a valid ${label}`);
  return Math.round(n * 100) / 100;
}

export function parseEquipmentInput(raw: unknown): EquipmentInput {
  const b = (raw ?? {}) as Record<string, unknown>;

  const name = text(b.name, 100, "Name");
  if (!name || name.length < 2) throw new EquipmentError(400, "Enter the equipment name");

  let category = text(b.category, 40, "Category");
  if (!category || category.length < 2) throw new EquipmentError(400, "Enter or choose a category");
  category = category[0].toUpperCase() + category.slice(1);

  const quantity = Number(b.quantity ?? 1);
  if (!Number.isInteger(quantity) || quantity < 1 || quantity > 10000) {
    throw new EquipmentError(400, "Quantity must be a whole number from 1 to 10000");
  }

  const statusRaw = typeof b.status === "string" ? b.status : "IN_USE";
  const status = EQUIPMENT_STATUSES.find((s) => s.value === statusRaw)?.value;
  if (!status) throw new EquipmentError(400, "Choose a valid status");

  let interval: number | null = null;
  if (b.serviceIntervalMonths !== undefined && b.serviceIntervalMonths !== null && b.serviceIntervalMonths !== "") {
    interval = Number(b.serviceIntervalMonths);
    if (!Number.isInteger(interval) || interval < 1 || interval > 120) {
      throw new EquipmentError(400, "Service interval must be 1 to 120 months");
    }
  }

  const purchaseDate = parseDate(b.purchaseDate, "Purchase date", { notFuture: true });
  const lastServiceDate = parseDate(b.lastServiceDate, "Last service date", { notFuture: true });
  if (purchaseDate && lastServiceDate && lastServiceDate < purchaseDate) {
    throw new EquipmentError(400, "Last service can't be before the purchase date");
  }

  return {
    name,
    category,
    make: text(b.make, 60, "Make"),
    model: text(b.model, 60, "Model"),
    serialNumber: text(b.serialNumber, 60, "Serial number"),
    location: text(b.location, 80, "Location"),
    quantity,
    status,
    purchaseDate,
    purchaseCost: money(b.purchaseCost, "purchase cost"),
    supplier: text(b.supplier, 100, "Supplier"),
    warrantyExpiry: parseDate(b.warrantyExpiry, "Warranty expiry"),
    serviceIntervalMonths: interval,
    lastServiceDate,
    notes: text(b.notes, 500, "Notes"),
  };
}

export type ServiceInput = {
  kind: ServiceKindValue;
  performedOn: Date;
  performedBy: string | null;
  cost: number | null;
  notes: string | null;
  statusAfter: EquipmentStatusValue | null;
};

export function parseServiceInput(raw: unknown): ServiceInput {
  const b = (raw ?? {}) as Record<string, unknown>;
  const kind = SERVICE_KINDS.find((k) => k.value === b.kind)?.value;
  if (!kind) throw new EquipmentError(400, "Choose what was done");

  const performedOn = parseDate(b.performedOn, "Date", { notFuture: true });
  if (!performedOn) throw new EquipmentError(400, "Enter the date it was done");

  let statusAfter: EquipmentStatusValue | null = null;
  if (typeof b.statusAfter === "string" && b.statusAfter) {
    statusAfter = EQUIPMENT_STATUSES.find((s) => s.value === b.statusAfter)?.value ?? null;
    if (!statusAfter) throw new EquipmentError(400, "Choose a valid status");
  }

  return {
    kind,
    performedOn,
    performedBy: text(b.performedBy, 100, "Done by"),
    cost: money(b.cost, "cost"),
    notes: text(b.notes, 500, "Notes"),
    statusAfter,
  };
}

// Custom asset tag typed in for an item that already has a number on it.
export function parseAssetTag(v: unknown): string | null {
  const t = text(v, 30, "Asset tag")?.toUpperCase() ?? null;
  if (!t) return null;
  if (!/^[A-Z0-9][A-Z0-9/._-]{0,29}$/.test(t)) {
    throw new EquipmentError(400, "Asset tag can only contain letters, numbers and / . _ -");
  }
  return t;
}
