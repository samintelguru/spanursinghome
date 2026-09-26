"use client";

import { useCallback, useEffect, useState } from "react";
import Link from "next/link";
import { fmtDate, kes } from "@/lib/billing";
import { EQUIPMENT_STATUSES, STATUS_STYLE, serviceState, statusLabel } from "@/lib/equipment";

type Item = {
  id: string;
  assetTag: string;
  name: string;
  category: string;
  make: string | null;
  model: string | null;
  serialNumber: string | null;
  location: string | null;
  quantity: number;
  status: string;
  warrantyExpiry: string | null;
  lastServiceDate: string | null;
  nextServiceDue: string | null;
};
type Summary = {
  total: number;
  units: number;
  inUse: number;
  underRepair: number;
  outOfService: number;
  serviceOverdue: number;
  serviceSoon: number;
  warrantyEnding: number;
  totalValue: number | null;
};

const input = "rounded-md border border-gray-300 bg-white px-3 py-2 text-sm";

export default function EquipmentListPage() {
  const [items, setItems] = useState<Item[]>([]);
  const [summary, setSummary] = useState<Summary | null>(null);
  const [categories, setCategories] = useState<string[]>([]);
  const [canManage, setCanManage] = useState(false);
  const [query, setQuery] = useState("");
  const [status, setStatus] = useState("");
  const [category, setCategory] = useState("");
  const [attention, setAttention] = useState(false);
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(true);

  const load = useCallback(async () => {
    try {
      const params = new URLSearchParams();
      if (query.trim()) params.set("q", query.trim());
      if (status) params.set("status", status);
      if (category) params.set("category", category);
      if (attention) params.set("attention", "1");
      const res = await fetch(`/api/equipment?${params}`);
      if (!res.ok) {
        const data = await res.json().catch(() => ({}));
        setError(data.error || `Could not load equipment (status ${res.status})`);
        return;
      }
      const data = await res.json();
      setError("");
      setItems(data.items);
      setSummary(data.summary);
      setCategories(data.categories);
      setCanManage(data.canManage);
    } catch {
      setError("Can't reach the server. Check your internet connection.");
    } finally {
      setLoading(false);
    }
  }, [query, status, category, attention]);

  useEffect(() => {
    const t = setTimeout(load, 200);
    return () => clearTimeout(t);
  }, [load]);

  const cards = summary
    ? [
        { label: "Equipment items", value: summary.total, sub: `${summary.units} units in total`, warn: false },
        { label: "In use", value: summary.inUse, warn: false },
        {
          label: "Repair / out of service",
          value: summary.underRepair + summary.outOfService,
          sub: `${summary.underRepair} under repair · ${summary.outOfService} out of service`,
          warn: summary.underRepair + summary.outOfService > 0,
        },
        { label: "Service overdue", value: summary.serviceOverdue, warn: summary.serviceOverdue > 0 },
        { label: "Service due in 30 days", value: summary.serviceSoon, warn: false },
        { label: "Warranty ends in 60 days", value: summary.warrantyEnding, warn: false },
      ]
    : [];

  return (
    <main className="p-8">
      <div className="mb-6 flex flex-wrap items-center justify-between gap-3">
        <div>
          <h1 className="text-xl font-medium text-[#2C2C2A]">Equipment inventory</h1>
          {summary?.totalValue != null && summary.totalValue > 0 && (
            <p className="text-xs text-gray-500">Total value at purchase cost: {kes(summary.totalValue)}</p>
          )}
        </div>
        {canManage && (
          <Link
            href="/admin/equipment/new"
            className="rounded-md bg-[#0982e8] px-4 py-2 text-sm font-medium text-white hover:bg-[#0a70c4]"
          >
            Add equipment
          </Link>
        )}
      </div>

      {summary && (
        <div className="mb-6 grid gap-3 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-6">
          {cards.map((c) => (
            <div key={c.label} className={`rounded-xl p-3 ${c.warn ? "bg-[#FAECE7]" : "bg-[#E6F1FB]"}`}>
              <p className={`text-xs ${c.warn ? "text-[#993C1D]" : "text-[#0C447C]"}`}>{c.label}</p>
              <p className={`mt-0.5 text-2xl font-medium ${c.warn ? "text-[#4A1B0C]" : "text-[#042C53]"}`}>{c.value}</p>
              {c.sub && <p className={`mt-0.5 text-[11px] ${c.warn ? "text-[#993C1D]" : "text-[#0C447C]"}`}>{c.sub}</p>}
            </div>
          ))}
        </div>
      )}

      <div className="mb-4 flex flex-wrap items-center gap-2">
        <input
          placeholder="Search name, tag, serial number, location..."
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          className={`${input} min-w-0 flex-1 sm:max-w-sm`}
        />
        <select value={category} onChange={(e) => setCategory(e.target.value)} className={input}>
          <option value="">All categories</option>
          {categories.map((c) => (
            <option key={c} value={c}>
              {c}
            </option>
          ))}
        </select>
        <select value={status} onChange={(e) => setStatus(e.target.value)} className={input}>
          <option value="">All (except disposed)</option>
          {EQUIPMENT_STATUSES.map((s) => (
            <option key={s.value} value={s.value}>
              {s.label}
            </option>
          ))}
        </select>
        <label className="flex items-center gap-1.5 text-sm text-gray-600">
          <input type="checkbox" checked={attention} onChange={(e) => setAttention(e.target.checked)} />
          Needs attention
        </label>
      </div>

      {error && <p className="mb-4 text-sm text-red-600">{error}</p>}

      {loading ? (
        <p className="text-sm text-gray-500">Loading...</p>
      ) : items.length === 0 ? (
        <p className="text-sm text-gray-500">
          {query || status || category || attention
            ? "No equipment matches these filters."
            : canManage
            ? "No equipment recorded yet. Use “Add equipment” to start the register."
            : "No equipment recorded yet."}
        </p>
      ) : (
        <div className="overflow-x-auto rounded-lg border border-gray-200 bg-white">
          <table className="w-full text-left text-sm">
            <thead>
              <tr className="border-b border-gray-200 text-gray-500">
                <th className="px-3 py-2">Tag</th>
                <th className="px-3 py-2">Equipment</th>
                <th className="px-3 py-2">Category</th>
                <th className="px-3 py-2">Location</th>
                <th className="px-3 py-2 text-right">Qty</th>
                <th className="px-3 py-2">Status</th>
                <th className="px-3 py-2">Next service</th>
              </tr>
            </thead>
            <tbody>
              {items.map((e) => {
                const svc = serviceState(e.nextServiceDue, e.status);
                return (
                  <tr key={e.id} className="border-b border-gray-100 last:border-b-0 hover:bg-[#E6F1FB]/40">
                    <td className="whitespace-nowrap px-3 py-2 font-mono text-xs text-gray-500">{e.assetTag}</td>
                    <td className="px-3 py-2">
                      <Link href={`/admin/equipment/${e.id}`} className="font-medium text-[#0982e8] hover:underline">
                        {e.name}
                      </Link>
                      {(e.make || e.model || e.serialNumber) && (
                        <span className="block text-xs text-gray-400">
                          {[e.make, e.model].filter(Boolean).join(" ")}
                          {e.serialNumber ? ` · S/N ${e.serialNumber}` : ""}
                        </span>
                      )}
                    </td>
                    <td className="px-3 py-2 text-gray-600">{e.category}</td>
                    <td className="px-3 py-2 text-gray-600">{e.location || <span className="text-gray-300">—</span>}</td>
                    <td className="px-3 py-2 text-right">{e.quantity}</td>
                    <td className="px-3 py-2">
                      <span className={`rounded-full px-2.5 py-0.5 text-xs font-medium ${STATUS_STYLE[e.status]}`}>
                        {statusLabel(e.status)}
                      </span>
                    </td>
                    <td className="whitespace-nowrap px-3 py-2 text-xs">
                      {e.nextServiceDue ? (
                        <span
                          className={
                            svc === "overdue" ? "font-medium text-red-600" : svc === "soon" ? "text-[#8A5A00]" : "text-gray-500"
                          }
                        >
                          {fmtDate(e.nextServiceDue)}
                          {svc === "overdue" && " · overdue"}
                          {svc === "soon" && " · soon"}
                        </span>
                      ) : (
                        <span className="text-gray-300">—</span>
                      )}
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      )}
    </main>
  );
}
