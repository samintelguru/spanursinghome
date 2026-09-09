"use client";

import { useEffect, useState } from "react";
import Link from "next/link";

type InvoiceItem = { id: string; description: string; amount: string };
type Payment = { id: string; amount: string; method: string };
type Invoice = {
  id: string;
  status: string;
  createdAt: string;
  patient: { fileNumber: string; fullName: string };
  items: InvoiceItem[];
  payments: Payment[];
};

const statusColor: Record<string, string> = {
  UNPAID: "text-red-600",
  PARTIALLY_PAID: "text-amber-600",
  PAID: "text-[#0B3D63 ]",
  WAIVED: "text-gray-500",
};

export default function AdminBillingPage() {
  const [invoices, setInvoices] = useState<Invoice[]>([]);
  const [payingId, setPayingId] = useState<string | null>(null);
  const [amount, setAmount] = useState("");
  const [method, setMethod] = useState("cash");
  const [reference, setReference] = useState("");
  const [error, setError] = useState("");

    const load = async () => {
    const res = await fetch("/api/billing/invoices");
    if (!res.ok) {
      const data = await res.json().catch(() => ({}));
      setError(data.error || `Could not load invoices (status ${res.status})`);
      return;
    }
    setError("");
    setInvoices((await res.json()).invoices);
  };

  useEffect(() => {
    load();
  }, []);

  const totalDue = (inv: Invoice) =>
    inv.items.reduce((sum, i) => sum + Number(i.amount), 0);
  const totalPaid = (inv: Invoice) =>
    inv.payments.reduce((sum, p) => sum + Number(p.amount), 0);

  const handlePay = async (invoiceId: string) => {
    setError("");
    const res = await fetch(`/api/billing/invoices/${invoiceId}/payments`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ amount: Number(amount), method, reference }),
    });
    if (!res.ok) {
      const data = await res.json();
      setError(data.error || "Could not record payment");
      return;
    }
    setPayingId(null);
    setAmount("");
    setReference("");
    load();
  };

  return (
    <main className="p-8">
      <h1 className="mb-6 text-xl font-medium">Billing</h1>

      {invoices.length === 0 ? (
        <p className="text-sm text-gray-500">No invoices yet.</p>
      ) : (
        <div className="flex flex-col gap-4">
          {invoices.map((inv) => {
            const due = totalDue(inv);
            const paid = totalPaid(inv);
            const balance = due - paid;

            return (
              <div
                key={inv.id}
                className="rounded-lg border border-gray-200 p-4"
              >
                <div className="mb-2 flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium">
                      {inv.patient.fileNumber} — {inv.patient.fullName}
                    </p>
                    <p className="text-xs text-gray-500">
                      {new Date(inv.createdAt).toLocaleDateString()}
                    </p>
                  </div>
                                    <div className="flex items-center gap-3">
                    <span className={`text-xs font-medium ${statusColor[inv.status]}`}>
                      {inv.status.replace("_", " ")}
                    </span>
                    <Link
                      href={`/admin/billing/${inv.id}/receipt`}
                      className="text-xs text-[#0B3D63 ] hover:underline"
                    >
                      Receipt
                    </Link>
                  </div>
                </div>

                <ul className="mb-2 text-sm text-gray-600">
                  {inv.items.map((item) => (
                    <li key={item.id} className="flex justify-between">
                      <span>{item.description}</span>
                      <span>KES {item.amount}</span>
                    </li>
                  ))}
                </ul>

                <div className="flex justify-between text-sm">
                  <span>Balance</span>
                  <span className="font-medium">KES {balance.toFixed(2)}</span>
                </div>

                {balance > 0 && (
                  <div className="mt-3 border-t border-gray-100 pt-3">
                    {payingId === inv.id ? (
                      <div className="flex flex-col gap-2">
                        <input
                          type="number"
                          placeholder="Amount (KES)"
                          value={amount}
                          onChange={(e) => setAmount(e.target.value)}
                          className="rounded-md border border-gray-300 px-3 py-2 text-sm"
                        />
                        <select
                          value={method}
                          onChange={(e) => setMethod(e.target.value)}
                          className="rounded-md border border-gray-300 px-3 py-2 text-sm"
                        >
                          <option value="cash">Cash</option>
                          <option value="mpesa">M-Pesa</option>
                          <option value="insurance">Insurance</option>
                        </select>
                        <input
                          placeholder="Reference (optional)"
                          value={reference}
                          onChange={(e) => setReference(e.target.value)}
                          className="rounded-md border border-gray-300 px-3 py-2 text-sm"
                        />
                        {error && <p className="text-sm text-red-600">{error}</p>}
                        <div className="flex gap-2">
                          <button
                            onClick={() => handlePay(inv.id)}
                            className="rounded-md bg-[#0B3D63 ] px-4 py-2 text-sm font-medium text-white"
                          >
                            Record payment
                          </button>
                          <button
                            onClick={() => setPayingId(null)}
                            className="rounded-md border border-gray-300 px-4 py-2 text-sm"
                          >
                            Cancel
                          </button>
                        </div>
                      </div>
                    ) : (
                      <button
                        onClick={() => setPayingId(inv.id)}
                        className="rounded-md bg-[#D85A30] px-4 py-2 text-sm font-medium text-white"
                      >
                        Record payment
                      </button>
                    )}
                  </div>
                )}
              </div>
            );
          })}
        </div>
      )}
    </main>
  );
}