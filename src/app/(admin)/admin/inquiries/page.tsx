"use client";

import { useCallback, useEffect, useState } from "react";
import { fmtDateTime } from "@/lib/billing";

type Inquiry = {
  id: string;
  fullName: string;
  phone: string;
  message: string;
  status: "NEW" | "IN_PROGRESS" | "RESOLVED";
  internalNote: string | null;
  handledAt: string | null;
  createdAt: string;
  handledBy: { fullName: string } | null;
};

const FILTERS = [
  { value: "NEW", label: "New" },
  { value: "IN_PROGRESS", label: "In progress" },
  { value: "RESOLVED", label: "Resolved" },
  { value: "", label: "All" },
];

const statusStyle: Record<string, string> = {
  NEW: "bg-[#FAECE7] text-[#993C1D]",
  IN_PROGRESS: "bg-[#FFF3D6] text-[#8A5A00]",
  RESOLVED: "bg-[#E6F1FB] text-[#0C447C]",
};
const statusLabel: Record<string, string> = {
  NEW: "New",
  IN_PROGRESS: "In progress",
  RESOLVED: "Resolved",
};

// Kenyan numbers: 0712... or +254712... -> 254712... for a WhatsApp link.
function whatsappLink(phone: string) {
  let d = phone.replace(/\D/g, "");
  if (d.startsWith("0")) d = "254" + d.slice(1);
  if (d.length < 9) return null;
  return `https://wa.me/${d}`;
}

async function send(url: string, method: string, body?: unknown) {
  try {
    const res = await fetch(url, {
      method,
      headers: { "Content-Type": "application/json" },
      body: body === undefined ? undefined : JSON.stringify(body),
    });
    const data = await res.json().catch(() => ({}));
    return { ok: res.ok, error: (data.error as string) || "Something went wrong" };
  } catch {
    return { ok: false, error: "Can't reach the server. Check your internet connection." };
  }
}

export default function AdminInquiriesPage() {
  const [inquiries, setInquiries] = useState<Inquiry[]>([]);
  const [counts, setCounts] = useState<Record<string, number>>({ NEW: 0, IN_PROGRESS: 0, RESOLVED: 0 });
  const [canDelete, setCanDelete] = useState(false);
  const [status, setStatus] = useState("NEW");
  const [query, setQuery] = useState("");
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(true);

  const load = useCallback(async () => {
    try {
      const params = new URLSearchParams();
      if (status) params.set("status", status);
      if (query.trim()) params.set("q", query.trim());
      const res = await fetch(`/api/inquiries?${params}`);
      if (!res.ok) {
        const data = await res.json().catch(() => ({}));
        setError(data.error || `Could not load inquiries (status ${res.status})`);
        return;
      }
      const data = await res.json();
      setError("");
      setInquiries(data.inquiries);
      setCounts(data.counts);
      setCanDelete(data.canDelete);
    } catch {
      setError("Can't reach the server. Check your internet connection — retrying automatically.");
    } finally {
      setLoading(false);
    }
  }, [status, query]);

  useEffect(() => {
    const t = setTimeout(load, 200);
    return () => clearTimeout(t);
  }, [load]);

  // Keep the inbox fresh while the page is open — but only while the tab is
  // actually visible, and straight away when the connection or tab comes back.
  useEffect(() => {
    const tick = () => {
      if (document.visibilityState === "visible") load();
    };
    const t = setInterval(tick, 60_000);
    document.addEventListener("visibilitychange", tick);
    window.addEventListener("online", tick);
    return () => {
      clearInterval(t);
      document.removeEventListener("visibilitychange", tick);
      window.removeEventListener("online", tick);
    };
  }, [load]);

  const total = counts.NEW + counts.IN_PROGRESS + counts.RESOLVED;

  return (
    <main className="p-8">
      <div className="mb-1 flex items-baseline justify-between">
        <h1 className="text-xl font-medium text-[#2C2C2A]">Inquiries</h1>
        <p className="text-xs text-gray-500">Messages sent from the Contact page on the public site</p>
      </div>

      <div className="mb-4 mt-4 flex flex-wrap items-center gap-3">
        <div className="flex overflow-hidden rounded-md border border-gray-300 text-sm">
          {FILTERS.map((f) => {
            const n = f.value ? counts[f.value] : total;
            return (
              <button
                key={f.label}
                onClick={() => setStatus(f.value)}
                className={`px-3 py-1.5 ${
                  status === f.value ? "bg-[#0B3D63] text-white" : "bg-white text-gray-600 hover:bg-gray-50"
                }`}
              >
                {f.label} <span className="opacity-70">({n})</span>
              </button>
            );
          })}
        </div>
        <input
          type="text"
          placeholder="Search name, phone or message..."
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          className="w-full max-w-sm rounded-md border border-gray-300 px-3 py-2 text-sm"
        />
      </div>

      {error && <p className="mb-4 text-sm text-red-600">{error}</p>}

      {loading ? (
        <p className="text-sm text-gray-500">Loading...</p>
      ) : inquiries.length === 0 ? (
        <p className="text-sm text-gray-500">
          {query || status !== "" ? "No inquiries in this view." : "No inquiries yet."}
        </p>
      ) : (
        <div className="flex flex-col gap-4">
          {inquiries.map((inq) => (
            <InquiryCard key={inq.id} inq={inq} canDelete={canDelete} onChanged={load} />
          ))}
        </div>
      )}
    </main>
  );
}

function InquiryCard({
  inq,
  canDelete,
  onChanged,
}: {
  inq: Inquiry;
  canDelete: boolean;
  onChanged: () => void;
}) {
  const [note, setNote] = useState(inq.internalNote ?? "");
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState("");
  const wa = whatsappLink(inq.phone);
  const noteChanged = note.trim() !== (inq.internalNote ?? "");

  const run = async (fn: () => Promise<{ ok: boolean; error: string }>) => {
    setBusy(true);
    setError("");
    const r = await fn();
    setBusy(false);
    if (!r.ok) {
      setError(r.error);
      return;
    }
    onChanged();
  };

  const setStatus = (status: Inquiry["status"]) =>
    run(() => send(`/api/inquiries/${inq.id}`, "PATCH", { status }));
  const saveNote = () => run(() => send(`/api/inquiries/${inq.id}`, "PATCH", { internalNote: note }));
  const remove = () => {
    if (!confirm(`Delete this message from ${inq.fullName}? This can't be undone.`)) return;
    run(() => send(`/api/inquiries/${inq.id}`, "DELETE"));
  };

  return (
    <div className="rounded-lg border border-gray-200 bg-white p-4">
      <div className="mb-2 flex flex-wrap items-start justify-between gap-2">
        <div>
          <p className="text-sm font-medium">{inq.fullName}</p>
          <p className="text-xs text-gray-500">Received {fmtDateTime(inq.createdAt)}</p>
        </div>
        <span className={`rounded-full px-2.5 py-0.5 text-xs font-medium ${statusStyle[inq.status]}`}>
          {statusLabel[inq.status]}
        </span>
      </div>

      <p className="mb-3 whitespace-pre-wrap break-words text-sm text-gray-700">{inq.message}</p>

      <div className="mb-3 flex flex-wrap gap-2 text-sm">
        <a
          href={`tel:${inq.phone.replace(/[^\d+]/g, "")}`}
          className="rounded-md bg-[#0982e8] px-3 py-1.5 font-medium text-white hover:bg-[#0a70c4]"
        >
          Call {inq.phone}
        </a>
        {wa && (
          <a
            href={wa}
            target="_blank"
            rel="noopener noreferrer"
            className="rounded-md border border-gray-300 px-3 py-1.5 hover:bg-gray-50"
          >
            WhatsApp
          </a>
        )}
      </div>

      <div className="mb-3">
        <label className="mb-1 block text-xs text-gray-500">Internal note (staff only)</label>
        <div className="flex gap-2">
          <input
            value={note}
            onChange={(e) => setNote(e.target.value)}
            placeholder="e.g. Called back, booked for Tuesday"
            maxLength={1000}
            className="min-w-0 flex-1 rounded-md border border-gray-300 px-3 py-1.5 text-sm"
          />
          {noteChanged && (
            <button
              onClick={saveNote}
              disabled={busy}
              className="rounded-md bg-[#0B3D63] px-3 py-1.5 text-sm font-medium text-white disabled:opacity-50"
            >
              Save note
            </button>
          )}
        </div>
      </div>

      {error && <p className="mb-2 text-sm text-red-600">{error}</p>}

      <div className="flex flex-wrap items-center gap-2 border-t border-gray-100 pt-3">
        {inq.status === "NEW" && (
          <button
            onClick={() => setStatus("IN_PROGRESS")}
            disabled={busy}
            className="rounded-md border border-gray-300 px-3 py-1.5 text-sm hover:bg-gray-50 disabled:opacity-50"
          >
            Mark in progress
          </button>
        )}
        {inq.status !== "RESOLVED" && (
          <button
            onClick={() => setStatus("RESOLVED")}
            disabled={busy}
            className="rounded-md bg-[#D85A30] px-3 py-1.5 text-sm font-medium text-white hover:opacity-90 disabled:opacity-50"
          >
            Mark resolved
          </button>
        )}
        {inq.status !== "NEW" && (
          <button
            onClick={() => setStatus("NEW")}
            disabled={busy}
            className="rounded-md border border-gray-300 px-3 py-1.5 text-sm text-gray-600 hover:bg-gray-50 disabled:opacity-50"
          >
            Reopen
          </button>
        )}
        {canDelete && (
          <button
            onClick={remove}
            disabled={busy}
            className="ml-auto text-xs text-gray-400 hover:text-red-600 disabled:opacity-50"
          >
            Delete
          </button>
        )}
      </div>

      {inq.handledBy && inq.handledAt && inq.status !== "NEW" && (
        <p className="mt-2 text-xs text-gray-400">
          {statusLabel[inq.status]} by {inq.handledBy.fullName} · {fmtDateTime(inq.handledAt)}
        </p>
      )}
    </div>
  );
}
