// Shared billing helpers. Pure functions only (no Prisma import) so they can be
// used from API routes, server pages and client components alike.
//
// Money rule: everything is compared in whole cents (integers) so that
// 0.1 + 0.2 style floating-point drift can never mark an invoice
// "partially paid" when it is actually settled.

export const TZ = "Africa/Nairobi";
const EAT_OFFSET_MS = 3 * 60 * 60 * 1000; // Kenya is UTC+3 all year, no daylight saving
const DAY_MS = 24 * 60 * 60 * 1000;

export const PAYMENT_METHODS = ["cash", "mpesa", "insurance"] as const;
export type PaymentMethod = (typeof PAYMENT_METHODS)[number];
export const METHOD_LABEL: Record<string, string> = {
  cash: "Cash",
  mpesa: "M-Pesa",
  insurance: "Insurance",
};

export type OpenStatus = "UNPAID" | "PARTIALLY_PAID";
export const OPEN_STATUSES: OpenStatus[] = ["UNPAID", "PARTIALLY_PAID"];

// Thrown inside API routes / transactions to return a clean message + status.
export class HttpError extends Error {
  status: number;
  constructor(status: number, message: string) {
    super(message);
    this.status = status;
  }
}

// ---------- money ----------

type MoneyLike = number | string | { toString(): string };

export const toCents = (v: MoneyLike) => Math.round(Number(v) * 100);

export function kes(n: number) {
  return `KES ${n.toLocaleString("en-KE", {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  })}`;
}

export function invoiceTotals(
  items: { amount: MoneyLike }[],
  payments: { amount: MoneyLike }[]
) {
  const dueC = items.reduce((s, i) => s + toCents(i.amount), 0);
  const paidC = payments.reduce((s, p) => s + toCents(p.amount), 0);
  return {
    dueC,
    paidC,
    balanceC: dueC - paidC,
    due: dueC / 100,
    paid: paidC / 100,
    balance: (dueC - paidC) / 100,
  };
}

// Status an invoice should have given what has been billed and paid.
// (WAIVED is never computed — it is only set by the waive action.)
export function statusFor(dueC: number, paidC: number): "UNPAID" | "PARTIALLY_PAID" | "PAID" {
  if (dueC > 0 && paidC >= dueC) return "PAID";
  if (paidC > 0) return "PARTIALLY_PAID";
  return "UNPAID";
}

// ---------- M-Pesa reference (manual entry until the API is wired up) ----------

export function normalizeRef(ref: unknown): string {
  return typeof ref === "string" ? ref.trim().toUpperCase() : "";
}
export const isValidMpesaRef = (ref: string) => /^[A-Z0-9]{8,12}$/.test(ref);

// ---------- dates (always Nairobi time; servers run in UTC) ----------

const dateFmt = new Intl.DateTimeFormat("en-GB", {
  timeZone: TZ,
  day: "numeric",
  month: "short",
  year: "numeric",
});
const dateTimeFmt = new Intl.DateTimeFormat("en-GB", {
  timeZone: TZ,
  day: "numeric",
  month: "short",
  year: "numeric",
  hour: "2-digit",
  minute: "2-digit",
  hour12: false,
});
export const fmtDate = (d: Date | string) => dateFmt.format(new Date(d));
export const fmtDateTime = (d: Date | string) => dateTimeFmt.format(new Date(d));

export function startOfDayEAT(d: Date = new Date()) {
  const shifted = d.getTime() + EAT_OFFSET_MS;
  return new Date(Math.floor(shifted / DAY_MS) * DAY_MS - EAT_OFFSET_MS);
}

// Weeks start on Monday.
export function startOfWeekEAT(d: Date = new Date()) {
  const dayStart = startOfDayEAT(d);
  const dow = new Date(dayStart.getTime() + EAT_OFFSET_MS).getUTCDay(); // 0 = Sunday
  return new Date(dayStart.getTime() - ((dow + 6) % 7) * DAY_MS);
}

export function startOfMonthEAT(d: Date = new Date()) {
  const s = new Date(d.getTime() + EAT_OFFSET_MS);
  return new Date(Date.UTC(s.getUTCFullYear(), s.getUTCMonth(), 1) - EAT_OFFSET_MS);
}

// "2026-09-19" for the Nairobi calendar day this instant falls on.
export const dayKeyEAT = (d: Date) =>
  new Date(d.getTime() + EAT_OFFSET_MS).toISOString().slice(0, 10);

export const invoiceNo = (id: string) => `#${id.slice(-8).toUpperCase()}`;

// ---------- invoice line validation ----------

// Turns { description, quantity, unitPrice } from the UI into a stored line:
// the amount is the line TOTAL (quantity x price) and the description carries
// "x<qty>", matching how pharmacy dispenses are already written.
export function parseLineItem(raw: unknown): { description: string; amount: number } {
  const r = (raw ?? {}) as Record<string, unknown>;
  const desc = typeof r.description === "string" ? r.description.trim() : "";
  const qty = Number(r.quantity ?? 1);
  const price = Number(r.unitPrice);

  if (!desc || desc.length > 120) {
    throw new HttpError(400, "Each item needs a description (max 120 characters)");
  }
  if (!Number.isInteger(qty) || qty < 1 || qty > 1000) {
    throw new HttpError(400, `Quantity for "${desc}" must be a whole number from 1 to 1000`);
  }
  if (!Number.isFinite(price) || price <= 0 || price > 10_000_000) {
    throw new HttpError(400, `Enter a price greater than 0 for "${desc}"`);
  }
  const unitC = Math.round(price * 100);
  if (Math.abs(price * 100 - unitC) > 1e-6) {
    throw new HttpError(400, `Price for "${desc}" can have at most 2 decimal places`);
  }
  return {
    description: qty > 1 ? `${desc} x${qty}` : desc,
    amount: (unitC * qty) / 100,
  };
}
