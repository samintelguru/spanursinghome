"use client";

import { useCallback, useEffect, useState } from "react";
import Link from "next/link";
import {
  METHOD_LABEL,
  fmtDate,
  fmtDateTime,
  invoiceNo,
  invoiceTotals,
  kes,
} from "@/lib/billing";

type Item = { id: string; description: string; amount: string; dispenseId: string | null };
type Payment = {
  id: string;
  amount: string;
  method: string;
  reference: string | null;
  paidAt: string;
  receivedBy: { fullName: string } | null;
};
type Invoice = {
  id: string;
  status: string;
  createdAt: string;
  waivedReason: string | null;
  patient: { id: string; fileNumber: string; fullName: string };
  items: Item[];
  payments: Payment[];
};

const FILTERS = [
  { value: "OPEN", label: "Open" },
  { value: "PAID", label: "Paid" },
  { value: "WAIVED", label: "Waived" },
  { value: "", label: "All" },
];

const statusStyle: Record<string, string> = {
  UNPAID: "bg-[#FAECE7] text-[#993C1D]",
  PARTIALLY_PAID: "bg-[#FFF3D6] text-[#8A5A00]",
  PAID: "bg-[#E6F1FB] text-[#0C447C]",
  WAIVED: "bg-gray-100 text-gray-600",
};

const input = "rounded-md border border-gray-300 px-3 py-2 text-sm";

async function send(url: string, method: string, body?: unknown) {
  try {
    const res = await fetch(url, {
      method,
      headers: { "Content-Type": "application/json" },
      body: body === undefined ? undefined : JSON.stringify(body),
    });
    const data = await res.json().catch(() => ({}));
    return { ok: res.ok, error: (data.error as string) || "Something went wrong", data };
  } catch {
    return { ok: false, error: "Can't reach the server. Check your internet connection.", data: {} };
  }
}

export default function AdminBillingPage() {
  const [invoices, setInvoices] = useState<Invoice[]>([]);
  const [canManage, setCanManage] = useState(false);
  const [status, setStatus] = useState("OPEN");
  const [query, setQuery] = useState("");
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(true);

  // Links from elsewhere (e.g. a patient's page) can open this list pre-filtered:
  // /admin/billing?q=SPA-2026-00042&status=OPEN
  useEffect(() => {
    const sp = new URLSearchParams(window.location.search);
    const q = sp.get("q");
    const st = sp.get("status");
    if (q) setQuery(q);
    if (st !== null) setStatus(st);
  }, []);

  const load = useCallback(async () => {
    try {
      const params = new URLSearchParams();
      if (status) params.set("status", status);
      if (query.trim()) params.set("q", query.trim());
      const res = await fetch(`/api/billing/invoices?${params}`);
      if (!res.ok) {
        const data = await res.json().catch(() => ({}));
        setError(data.error || `Could not load invoices (status ${res.status})`);
        return;
      }
      const data = await res.json();
      setError("");
      setInvoices(data.invoices);
      setCanManage(data.canManage);
    } catch {
      setError("Can't reach the server. Check your internet connection.");
    } finally {
      setLoading(false);
    }
  }, [status, query]);

  useEffect(() => {
    const t = setTimeout(load, 200);
    return () => clearTimeout(t);
  }, [load]);

  return (
    <main className="p-4 sm:p-8">
      <div className="mb-6 flex flex-wrap items-center justify-between gap-3">
        <h1 className="text-xl font-medium text-[#2C2C2A]">Billing</h1>
        <div className="flex gap-2">
          {canManage && (
            <Link
              href="/admin/billing/dashboard"
              className="rounded-md border border-[#0B3D63] px-4 py-2 text-sm font-medium text-[#0B3D63] hover:bg-[#E6F1FB]"
            >
              Billing dashboard
            </Link>
          )}
          <Link
            href="/admin/billing/new"
            className="rounded-md bg-[#0982e8] px-4 py-2 text-sm font-medium text-white hover:bg-[#0a70c4]"
          >
            New invoice
          </Link>
        </div>
      </div>

      <div className="mb-4 flex flex-wrap items-center gap-3">
        <div className="flex overflow-hidden rounded-md border border-gray-300 text-sm">
          {FILTERS.map((f) => (
            <button
              key={f.label}
              onClick={() => setStatus(f.value)}
              className={`px-3 py-1.5 ${
                status === f.value ? "bg-[#0B3D63] text-white" : "bg-white text-gray-600 hover:bg-gray-50"
              }`}
            >
              {f.label}
            </button>
          ))}
        </div>
        <input
          type="text"
          placeholder="Search by patient name or file number..."
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          className={`${input} w-full max-w-sm`}
        />
      </div>

      {error && <p className="mb-4 text-sm text-red-600">{error}</p>}

      {loading ? (
        <p className="text-sm text-gray-500">Loading...</p>
      ) : invoices.length === 0 ? (
        <p className="text-sm text-gray-500">
          {query || status ? "No invoices match this view." : "No invoices yet."}
        </p>
      ) : (
        <div className="flex flex-col gap-4">
          {invoices.map((inv) => (
            <InvoiceCard key={inv.id} inv={inv} canManage={canManage} onChanged={load} />
          ))}
        </div>
      )}
    </main>
  );
}

function InvoiceCard({
  inv,
  canManage,
  onChanged,
}: {
  inv: Invoice;
  canManage: boolean;
  onChanged: () => void;
}) {
  const { due, paid, balance } = invoiceTotals(inv.items, inv.payments);
  const isOpen = inv.status === "UNPAID" || inv.status === "PARTIALLY_PAID";

  const [panel, setPanel] = useState<"pay" | "item" | "waive" | null>(null);
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState("");

  // payment form
  const [amount, setAmount] = useState("");
  const [method, setMethod] = useState("cash");
  const [reference, setReference] = useState("");
  // add-item form
  const [desc, setDesc] = useState("");
  const [qty, setQty] = useState("1");
  const [price, setPrice] = useState("");
  // waive form
  const [reason, setReason] = useState("");

  const open = (p: "pay" | "item" | "waive") => {
    setError("");
    if (p === "pay") setAmount(balance.toFixed(2));
    setPanel(p);
  };
  const close = () => {
    setPanel(null);
    setError("");
  };

  const run = async (fn: () => Promise<{ ok: boolean; error: string }>, reset: () => void) => {
    setBusy(true);
    setError("");
    const r = await fn();
    setBusy(false);
    if (!r.ok) {
      setError(r.error);
      return;
    }
    reset();
    setPanel(null);
    onChanged();
  };

  const pay = () =>
    run(
      () =>
        send(`/api/billing/invoices/${inv.id}/payments`, "POST", {
          amount: Number(amount),
          method,
          reference,
        }),
      () => {
        setAmount("");
        setReference("");
        setMethod("cash");
      }
    );

  const addItem = () =>
    run(
      () =>
        send(`/api/billing/invoices/${inv.id}/items`, "POST", {
          description: desc,
          quantity: Number(qty),
          unitPrice: Number(price),
        }),
      () => {
        setDesc("");
        setQty("1");
        setPrice("");
      }
    );

  const waive = () =>
    run(() => send(`/api/billing/invoices/${inv.id}/waive`, "POST", { reason }), () => setReason(""));

  const removeItem = (itemId: string) => {
    if (!confirm("Remove this item from the invoice?")) return;
    run(() => send(`/api/billing/invoices/${inv.id}/items/${itemId}`, "DELETE"), () => {});
  };

  return (
    <div className="rounded-lg border border-gray-200 bg-white p-4">
      <div className="mb-3 flex flex-wrap items-start justify-between gap-2">
        <div>
          <p className="text-sm font-medium">
            <Link href={`/admin/patients/${inv.patient.id}`} className="hover:underline">
              {inv.patient.fileNumber} — {inv.patient.fullName}
            </Link>
          </p>
          <p className="text-xs text-gray-500">
            Invoice {invoiceNo(inv.id)} · {fmtDate(inv.createdAt)}
          </p>
        </div>
        <div className="flex items-center gap-3">
          <span className={`rounded-full px-2.5 py-0.5 text-xs font-medium ${statusStyle[inv.status]}`}>
            {inv.status.replace("_", " ")}
          </span>
          <Link
            href={`/admin/billing/${inv.id}/receipt`}
            className="text-xs text-[#0982e8] hover:underline"
          >
            Receipt
          </Link>
        </div>
      </div>

      {/* Payment action — always right under the header so it can't be missed */}
      {isOpen && panel !== "pay" && (
        <div className="mb-3 flex flex-wrap items-center justify-between gap-2 rounded-md bg-[#FAECE7] px-3 py-2">
          <p className="text-sm text-[#993C1D]">
            Balance due <span className="text-base font-medium">{kes(balance)}</span>
          </p>
          <button
            onClick={() => open("pay")}
            className="rounded-md bg-[#D85A30] px-5 py-2 text-sm font-medium text-white shadow-sm hover:opacity-90"
          >
            Record payment
          </button>
        </div>
      )}
      {inv.status === "PAID" && (
        <div className="mb-3 flex flex-wrap items-center justify-between gap-2 rounded-md bg-[#E6F1FB] px-3 py-2">
          <p className="text-sm text-[#0C447C]">Paid in full — nothing more to collect</p>
          <Link
            href={`/admin/billing/${inv.id}/receipt`}
            className="rounded-md bg-[#0B3D63] px-4 py-2 text-sm font-medium text-white hover:opacity-90"
          >
            Print receipt
          </Link>
        </div>
      )}
      {inv.status === "WAIVED" && (
        <div className="mb-3 flex flex-wrap items-center justify-between gap-2 rounded-md bg-gray-100 px-3 py-2">
          <p className="text-sm text-gray-600">Balance written off — no payment needed</p>
          <Link
            href={`/admin/billing/${inv.id}/receipt`}
            className="rounded-md border border-gray-300 bg-white px-4 py-2 text-sm hover:bg-gray-50"
          >
            View receipt
          </Link>
        </div>
      )}

      {panel === "pay" && (
            <div className="flex max-w-sm flex-col gap-2 rounded-md border border-[#D85A30]/40 bg-[#FAECE7]/40 p-3">
              <label className="text-xs text-gray-500">Amount (balance is {kes(balance)})</label>
              <input
                type="number"
                min="0"
                step="0.01"
                value={amount}
                onChange={(e) => setAmount(e.target.value)}
                className={input}
              />
              <select value={method} onChange={(e) => setMethod(e.target.value)} className={input}>
                <option value="cash">Cash</option>
                <option value="mpesa">M-Pesa (enter code manually)</option>
                <option value="insurance">Insurance</option>
              </select>
              <input
                placeholder={
                  method === "mpesa"
                    ? "M-Pesa transaction code (required)"
                    : method === "insurance"
                    ? "Claim / authorisation no. (optional)"
                    : "Reference (optional)"
                }
                value={reference}
                onChange={(e) => setReference(e.target.value.toUpperCase())}
                className={input}
              />
              {error && <p className="text-sm text-red-600">{error}</p>}
              <div className="flex gap-2">
                <button
                  onClick={pay}
                  disabled={busy}
                  className="rounded-md bg-[#0B3D63] px-4 py-2 text-sm font-medium text-white disabled:opacity-50"
                >
                  {busy ? "Saving..." : "Save payment"}
                </button>
                <button onClick={close} className="rounded-md border border-gray-300 px-4 py-2 text-sm">
                  Cancel
                </button>
              </div>
            </div>
          )}

      <ul className="mb-3 text-sm text-gray-700">
        {inv.items.map((item) => (
          <li key={item.id} className="flex justify-between gap-3 border-b border-gray-50 py-1">
            <span>
              {item.description}
              {canManage && isOpen && !item.dispenseId && inv.items.length > 1 && (
                <button
                  onClick={() => removeItem(item.id)}
                  className="ml-2 text-xs text-gray-400 hover:text-red-600"
                >
                  remove
                </button>
              )}
            </span>
            <span>{kes(Number(item.amount))}</span>
          </li>
        ))}
      </ul>

      {inv.payments.length > 0 && (
        <div className="mb-3 rounded-md bg-gray-50 p-2 text-xs text-gray-600">
          {inv.payments.map((p) => (
            <div key={p.id} className="flex justify-between gap-3 py-0.5">
              <span>
                {METHOD_LABEL[p.method] ?? p.method}
                {p.reference ? ` · ${p.reference}` : ""} · {fmtDateTime(p.paidAt)}
                {p.receivedBy ? ` · ${p.receivedBy.fullName}` : ""}
              </span>
              <span>{kes(Number(p.amount))}</span>
            </div>
          ))}
        </div>
      )}

      <div className="flex justify-between text-sm text-gray-600">
        <span>Total</span>
        <span>{kes(due)}</span>
      </div>
      <div className="flex justify-between text-sm text-gray-600">
        <span>Paid</span>
        <span>{kes(paid)}</span>
      </div>
      <div className="flex justify-between text-sm font-medium">
        <span>{inv.status === "WAIVED" ? "Written off" : "Balance"}</span>
        <span className={balance > 0 && inv.status !== "WAIVED" ? "text-[#993C1D]" : ""}>
          {kes(balance)}
        </span>
      </div>

      {inv.status === "WAIVED" && inv.waivedReason && (
        <p className="mt-2 text-xs text-gray-500">Reason: {inv.waivedReason}</p>
      )}

      {isOpen && panel !== "pay" && (
        <div className="mt-3 border-t border-gray-100 pt-3">
          {panel === null && (
            <div className="flex flex-wrap gap-2">
              <button
                onClick={() => open("item")}
                className="rounded-md border border-gray-300 px-4 py-2 text-sm hover:bg-gray-50"
              >
                Add item
              </button>
              {canManage && (
                <button
                  onClick={() => open("waive")}
                  className="rounded-md border border-gray-300 px-4 py-2 text-sm text-gray-600 hover:bg-gray-50"
                >
                  Waive balance
                </button>
              )}
            </div>
          )}

          {panel === "item" && (
            <div className="flex max-w-md flex-col gap-2">
              <input
                placeholder="Description (e.g. Consultation)"
                value={desc}
                onChange={(e) => setDesc(e.target.value)}
                className={input}
              />
              <div className="flex gap-2">
                <input
                  type="number"
                  min="1"
                  placeholder="Qty"
                  value={qty}
                  onChange={(e) => setQty(e.target.value)}
                  className={`${input} w-20`}
                />
                <input
                  type="number"
                  min="0"
                  step="0.01"
                  placeholder="Unit price (KES)"
                  value={price}
                  onChange={(e) => setPrice(e.target.value)}
                  className={`${input} flex-1`}
                />
              </div>
              {error && <p className="text-sm text-red-600">{error}</p>}
              <div className="flex gap-2">
                <button
                  onClick={addItem}
                  disabled={busy}
                  className="rounded-md bg-[#0B3D63] px-4 py-2 text-sm font-medium text-white disabled:opacity-50"
                >
                  {busy ? "Saving..." : "Add to invoice"}
                </button>
                <button onClick={close} className="rounded-md border border-gray-300 px-4 py-2 text-sm">
                  Cancel
                </button>
              </div>
            </div>
          )}

          {panel === "waive" && (
            <div className="flex max-w-md flex-col gap-2">
              <p className="text-xs text-gray-500">
                This writes off the remaining {kes(balance)}. It can&apos;t be undone, and your name is recorded.
              </p>
              <input
                placeholder="Reason (required)"
                value={reason}
                onChange={(e) => setReason(e.target.value)}
                className={input}
              />
              {error && <p className="text-sm text-red-600">{error}</p>}
              <div className="flex gap-2">
                <button
                  onClick={waive}
                  disabled={busy}
                  className="rounded-md bg-[#993C1D] px-4 py-2 text-sm font-medium text-white disabled:opacity-50"
                >
                  {busy ? "Saving..." : "Waive balance"}
                </button>
                <button onClick={close} className="rounded-md border border-gray-300 px-4 py-2 text-sm">
                  Cancel
                </button>
              </div>
            </div>
          )}
        </div>
      )}
    </div>
  );
}
