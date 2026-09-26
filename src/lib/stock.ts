// Pharmacy stock rules shared by the API and the pharmacy page.
// Pure functions only (no Prisma import).

export const ADJUST_REASONS = [
  "Expired",
  "Damaged",
  "Lost or missing",
  "Stock count correction",
  "Returned to supplier",
  "Other",
] as const;

export class StockError extends Error {
  status: number;
  constructor(status: number, message: string) {
    super(message);
    this.status = status;
  }
}

export type StockInput = {
  kind: "RECEIVED" | "ADJUSTED";
  quantity: number; // signed: + added, - removed
  supplier: string | null;
  batchNo: string | null;
  expiryDate: Date | null;
  unitCost: number | null;
  reason: string | null;
  note: string | null;
};

const MAX_QTY = 1_000_000;

function text(v: unknown, max: number, label: string): string | null {
  if (v === undefined || v === null) return null;
  if (typeof v !== "string") throw new StockError(400, `${label} is not valid`);
  const t = v.replace(/\s+/g, " ").trim();
  if (!t) return null;
  if (t.length > max) throw new StockError(400, `${label} is too long (max ${max} characters)`);
  return t;
}

// Today's date in Nairobi as YYYY-MM-DD (servers run in UTC).
const todayEAT = () => new Date(Date.now() + 3 * 3600_000).toISOString().slice(0, 10);

export function parseStockInput(raw: unknown): StockInput {
  const b = (raw ?? {}) as Record<string, unknown>;
  const kind = b.kind;
  if (kind !== "RECEIVED" && kind !== "ADJUSTED") {
    throw new StockError(400, "Choose whether stock is being received or adjusted");
  }

  const qty = Number(b.quantity);
  if (!Number.isInteger(qty) || qty === 0 || Math.abs(qty) > MAX_QTY) {
    throw new StockError(400, "Enter the quantity as a whole number");
  }

  const note = text(b.note, 300, "Note");

  if (kind === "RECEIVED") {
    if (qty < 0) throw new StockError(400, "Quantity received must be more than 0");

    let expiryDate: Date | null = null;
    const exp = typeof b.expiryDate === "string" ? b.expiryDate.trim() : "";
    if (exp) {
      if (!/^\d{4}-\d{2}-\d{2}$/.test(exp)) throw new StockError(400, "Enter the expiry date as a date");
      const d = new Date(`${exp}T00:00:00.000Z`);
      if (Number.isNaN(d.getTime()) || d.toISOString().slice(0, 10) !== exp) {
        throw new StockError(400, "That expiry date isn't a real date");
      }
      if (exp <= todayEAT()) throw new StockError(400, "That batch has already expired — check the expiry date");
      if (exp > "2100-01-01") throw new StockError(400, "Expiry date is too far away");
      expiryDate = d;
    }

    let unitCost: number | null = null;
    if (b.unitCost !== undefined && b.unitCost !== null && b.unitCost !== "") {
      const c = Number(b.unitCost);
      if (!Number.isFinite(c) || c < 0 || c > 10_000_000) {
        throw new StockError(400, "Enter a valid buying price");
      }
      unitCost = Math.round(c * 100) / 100;
    }

    return {
      kind,
      quantity: qty,
      supplier: text(b.supplier, 100, "Supplier"),
      batchNo: text(b.batchNo, 50, "Batch number"),
      expiryDate,
      unitCost,
      reason: null,
      note,
    };
  }

  // ADJUSTED
  const reason = text(b.reason, 40, "Reason");
  if (!reason || !(ADJUST_REASONS as readonly string[]).includes(reason)) {
    throw new StockError(400, "Choose a reason for the adjustment");
  }
  if (reason === "Other" && !note) {
    throw new StockError(400, "Add a note explaining the adjustment");
  }
  return {
    kind,
    quantity: qty,
    supplier: null,
    batchNo: null,
    expiryDate: null,
    unitCost: null,
    reason,
    note,
  };
}
