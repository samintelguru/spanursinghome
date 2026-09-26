"use client";

import { useEffect, useMemo, useState } from "react";
import PatientPicker, { type PatientLite } from "@/components/patient-picker";
import { fmtDate, fmtDateTime } from "@/lib/billing";
import { ADJUST_REASONS } from "@/lib/stock";

type Drug = {
  id: string;
  name: string;
  unit: string;
  unitPrice: string;
  stockQty: number;
  reorderAt: number;
  expiryDate: string | null;
};
type DrugType = { id: string; name: string; drugCount: number };
type Mode = "restock" | "adjust" | "history" | "edit";
type HistoryEntry = {
  id: string;
  at: string;
  type: "RECEIVED" | "ADJUSTED" | "DISPENSED";
  quantity: number;
  stockAfter: number | null;
  by: string | null;
  detail: string;
};

const ADD_NEW = "__add_new__";
const input = "rounded-md border border-gray-300 bg-white px-3 py-2 text-sm";
const DAY = 24 * 60 * 60 * 1000;

async function send(url: string, method: string, body?: unknown) {
  try {
    const res = await fetch(url, {
      method,
      headers: { "Content-Type": "application/json" },
      body: body === undefined ? undefined : JSON.stringify(body),
    });
    const data = await res.json().catch(() => ({}));
    return { ok: res.ok, data, error: (data.error as string) || "Something went wrong" };
  } catch {
    return { ok: false, data: {}, error: "Can't reach the server. Check your internet connection." };
  }
}

// "expired" | "soon" (within 90 days) | null
function expiryState(iso: string | null): "expired" | "soon" | null {
  if (!iso) return null;
  const days = (new Date(iso).getTime() - Date.now()) / DAY;
  if (days <= 0) return "expired";
  return days <= 90 ? "soon" : null;
}

export default function AdminPharmacyPage() {
  const [drugs, setDrugs] = useState<Drug[]>([]);
  const [types, setTypes] = useState<DrugType[]>([]);
  const [canManage, setCanManage] = useState(false);
  const [patient, setPatient] = useState<PatientLite | null>(null);
  const [message, setMessage] = useState("");
  const [error, setError] = useState("");
  const [notice, setNotice] = useState("");

  // inventory filters
  const [search, setSearch] = useState("");
  const [typeFilter, setTypeFilter] = useState("");
  const [attentionOnly, setAttentionOnly] = useState(false);

  // add drug
  const [newDrug, setNewDrug] = useState({ name: "", unit: "", unitPrice: "", stockQty: "" });
  const [addError, setAddError] = useState("");

  // drug types
  const [newTypeName, setNewTypeName] = useState("");
  const [typeError, setTypeError] = useState("");
  const [showTypes, setShowTypes] = useState(false);

  // the open row panel (restock / adjust / history / edit)
  const [active, setActive] = useState<{ id: string; mode: Mode } | null>(null);

  const [dispenseForm, setDispenseForm] = useState({ drugId: "", quantity: "1" });

  const loadData = async () => {
    try {
      const [drugsRes, typesRes] = await Promise.all([
        fetch("/api/pharmacy/drugs"),
        fetch("/api/pharmacy/drug-types"),
      ]);
      if (drugsRes.ok) {
        const d = await drugsRes.json();
        setDrugs(d.drugs);
        setCanManage(d.canManage);
      }
      if (typesRes.ok) setTypes((await typesRes.json()).types);
    } catch {
      // Connection dropped — keep showing what we have.
    }
  };

  useEffect(() => {
    loadData();
  }, []);

  const needsAttention = (d: Drug) => d.stockQty <= d.reorderAt || expiryState(d.expiryDate) !== null;
  const attentionCount = drugs.filter(needsAttention).length;

  const shownDrugs = useMemo(() => {
    const q = search.trim().toLowerCase();
    return drugs.filter(
      (d) =>
        (!q || d.name.toLowerCase().includes(q)) &&
        (!typeFilter || d.unit.toLowerCase() === typeFilter.toLowerCase()) &&
        (!attentionOnly || needsAttention(d))
    );
  }, [drugs, search, typeFilter, attentionOnly]);

  // ----- types -----
  const addType = async () => {
    setTypeError("");
    const r = await send("/api/pharmacy/drug-types", "POST", { name: newTypeName });
    if (!r.ok) {
      setTypeError(r.error);
      return null;
    }
    setNewTypeName("");
    await loadData();
    return r.data.type as DrugType;
  };

  const addTypeFromDropdown = async () => {
    const type = await addType();
    if (type) setNewDrug((n) => ({ ...n, unit: type.name }));
  };

  const removeType = async (t: DrugType) => {
    setTypeError("");
    const r = await send(`/api/pharmacy/drug-types/${t.id}`, "DELETE");
    if (!r.ok) {
      setTypeError(r.error);
      return;
    }
    loadData();
  };

  // ----- drugs -----
  const handleAddDrug = async (e: React.FormEvent) => {
    e.preventDefault();
    setAddError("");
    if (!newDrug.unit || newDrug.unit === ADD_NEW) {
      setAddError("Choose a drug type");
      return;
    }
    const r = await send("/api/pharmacy/drugs", "POST", newDrug);
    if (!r.ok) {
      setAddError(r.error);
      return;
    }
    setNewDrug({ name: "", unit: newDrug.unit, unitPrice: "", stockQty: "" });
    loadData();
  };

  const panelDone = (msg?: string) => {
    setActive(null);
    if (msg) setNotice(msg);
    loadData();
  };

  const handleDispense = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");
    setMessage("");
    if (!patient) {
      setError("Choose a patient first");
      return;
    }
    const res = await fetch("/api/pharmacy/dispense", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        patientId: patient.id,
        drugId: dispenseForm.drugId,
        quantity: Number(dispenseForm.quantity),
      }),
    });
    if (!res.ok) {
      const data = await res.json();
      setError(data.error || "Could not dispense");
      return;
    }
    setMessage("Dispensed and added to patient's bill.");
    setPatient(null);
    setDispenseForm({ drugId: "", quantity: "1" });
    loadData();
  };

  const colSpan = canManage ? 6 : 5;

  return (
    <main className="grid gap-8 p-8 lg:grid-cols-[minmax(0,3fr)_minmax(0,2fr)]">
      <section>
        <h1 className="mb-4 text-xl font-medium">Drug inventory</h1>

        <div className="mb-3 flex flex-wrap items-center gap-2">
          <input
            placeholder="Search drugs..."
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            className={`${input} min-w-0 flex-1`}
          />
          <select value={typeFilter} onChange={(e) => setTypeFilter(e.target.value)} className={input}>
            <option value="">All types</option>
            {types
              .filter((t) => t.drugCount > 0)
              .map((t) => (
                <option key={t.id} value={t.name}>
                  {t.name} ({t.drugCount})
                </option>
              ))}
          </select>
          <label className="flex items-center gap-1.5 text-sm text-gray-600">
            <input type="checkbox" checked={attentionOnly} onChange={(e) => setAttentionOnly(e.target.checked)} />
            Low / expiring ({attentionCount})
          </label>
        </div>

        {notice && (
          <p className="mb-3 rounded-md bg-[#E6F1FB] px-3 py-2 text-sm text-[#0C447C]">{notice}</p>
        )}

        <div className="mb-6 overflow-x-auto">
          <table className="w-full text-left text-sm">
            <thead>
              <tr className="border-b border-gray-200 text-gray-500">
                <th className="py-2 pr-3">Name</th>
                <th className="py-2 pr-3">Type</th>
                <th className="py-2 pr-3">Stock</th>
                <th className="py-2 pr-3">Expiry</th>
                <th className="py-2 pr-3">Unit price</th>
                {canManage && <th className="py-2" />}
              </tr>
            </thead>
            <tbody>
              {shownDrugs.map((d) => {
                const exp = expiryState(d.expiryDate);
                const isOpen = active?.id === d.id;
                return (
                  <FragmentRows key={d.id}>
                    <tr className={`border-b border-gray-100 ${isOpen ? "bg-[#E6F1FB]/40" : ""}`}>
                      <td className="py-2 pr-3">{d.name}</td>
                      <td className="py-2 pr-3 capitalize text-gray-600">{d.unit}</td>
                      <td className="py-2 pr-3">
                        {d.stockQty}
                        {d.stockQty === 0 ? (
                          <span className="ml-2 text-xs font-medium text-red-600">out</span>
                        ) : d.stockQty <= d.reorderAt ? (
                          <span className="ml-2 text-xs text-red-600">low</span>
                        ) : null}
                      </td>
                      <td className="py-2 pr-3 text-xs">
                        {d.expiryDate ? (
                          <span
                            className={
                              exp === "expired"
                                ? "font-medium text-red-600"
                                : exp === "soon"
                                ? "text-[#8A5A00]"
                                : "text-gray-500"
                            }
                          >
                            {fmtDate(d.expiryDate)}
                            {exp === "expired" && " · expired"}
                            {exp === "soon" && " · soon"}
                          </span>
                        ) : (
                          <span className="text-gray-300">—</span>
                        )}
                      </td>
                      <td className="py-2 pr-3">KES {d.unitPrice}</td>
                      {canManage && (
                        <td className="whitespace-nowrap py-2 text-right text-xs">
                          {(["restock", "adjust", "history", "edit"] as Mode[]).map((m, i) => (
                            <span key={m}>
                              {i > 0 && <span className="text-gray-300"> · </span>}
                              <button
                                onClick={() => setActive(isOpen && active?.mode === m ? null : { id: d.id, mode: m })}
                                className={`hover:underline ${
                                  isOpen && active?.mode === m ? "font-medium text-[#0B3D63]" : "text-[#0982e8]"
                                } ${m === "restock" ? "font-medium" : ""}`}
                              >
                                {m === "restock" ? "Restock" : m === "adjust" ? "Adjust" : m === "history" ? "History" : "Edit"}
                              </button>
                            </span>
                          ))}
                        </td>
                      )}
                    </tr>
                    {isOpen && active && (
                      <tr className="border-b border-gray-100 bg-[#E6F1FB]/40">
                        <td colSpan={colSpan} className="px-1 pb-3 pt-1">
                          {active.mode === "restock" && (
                            <RestockPanel drug={d} onDone={panelDone} onCancel={() => setActive(null)} />
                          )}
                          {active.mode === "adjust" && (
                            <AdjustPanel drug={d} onDone={panelDone} onCancel={() => setActive(null)} />
                          )}
                          {active.mode === "history" && <HistoryPanel drug={d} onClose={() => setActive(null)} />}
                          {active.mode === "edit" && (
                            <EditPanel drug={d} types={types} onDone={panelDone} onCancel={() => setActive(null)} />
                          )}
                        </td>
                      </tr>
                    )}
                  </FragmentRows>
                );
              })}
              {shownDrugs.length === 0 && (
                <tr>
                  <td colSpan={colSpan} className="py-4 text-gray-400">
                    {drugs.length === 0 ? "No drugs yet." : "No drugs match your search."}
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>

        {canManage && (
          <>
            <h2 className="mb-2 text-sm font-medium">Add a new drug</h2>
            <form onSubmit={handleAddDrug} className="flex flex-col gap-2">
              <input
                placeholder="Drug name"
                value={newDrug.name}
                onChange={(e) => setNewDrug({ ...newDrug, name: e.target.value })}
                required
                className={input}
              />

              <select
                value={newDrug.unit}
                onChange={(e) => {
                  setTypeError("");
                  setNewDrug({ ...newDrug, unit: e.target.value });
                }}
                required
                className={input}
              >
                <option value="">Select drug type</option>
                {types.map((t) => (
                  <option key={t.id} value={t.name}>
                    {t.name}
                  </option>
                ))}
                <option value={ADD_NEW}>＋ Add new type…</option>
              </select>

              {newDrug.unit === ADD_NEW && (
                <div className="rounded-md border border-[#8FB8D9] bg-[#E6F1FB]/50 p-3">
                  <p className="mb-2 text-xs text-gray-600">
                    New drug type (e.g. Nebuliser solution, Lozenge, Sachet)
                  </p>
                  <div className="flex gap-2">
                    <input
                      value={newTypeName}
                      onChange={(e) => setNewTypeName(e.target.value)}
                      onKeyDown={(e) => {
                        if (e.key === "Enter") {
                          e.preventDefault();
                          addTypeFromDropdown();
                        }
                      }}
                      placeholder="Type name"
                      autoFocus
                      className={`${input} min-w-0 flex-1`}
                    />
                    <button
                      type="button"
                      onClick={addTypeFromDropdown}
                      className="rounded-md bg-[#0B3D63] px-3 py-2 text-sm font-medium text-white"
                    >
                      Add type
                    </button>
                  </div>
                  {typeError && <p className="mt-1 text-sm text-red-600">{typeError}</p>}
                </div>
              )}

              <div className="flex gap-2">
                <input
                  placeholder="Unit price (KES)"
                  type="number"
                  step="0.01"
                  min="0"
                  value={newDrug.unitPrice}
                  onChange={(e) => setNewDrug({ ...newDrug, unitPrice: e.target.value })}
                  required
                  className={`${input} w-1/2`}
                />
                <input
                  placeholder="Starting stock"
                  type="number"
                  min="0"
                  value={newDrug.stockQty}
                  onChange={(e) => setNewDrug({ ...newDrug, stockQty: e.target.value })}
                  required
                  className={`${input} w-1/2`}
                />
              </div>
              <p className="text-xs text-gray-400">
                For a drug you already stock, use <span className="font-medium">Restock</span> in the table above
                instead of adding it again.
              </p>

              {addError && <p className="text-sm text-red-600">{addError}</p>}

              <button
                type="submit"
                className="rounded-md bg-[#0982e8] px-4 py-2 text-sm font-medium text-white hover:bg-[#0a70c4]"
              >
                Add drug
              </button>
            </form>

            <button
              onClick={() => {
                setShowTypes(!showTypes);
                setTypeError("");
              }}
              className="mt-4 text-sm text-[#0982e8] hover:underline"
            >
              {showTypes ? "Hide drug types" : `Manage drug types (${types.length})`}
            </button>

            {showTypes && (
              <div className="mt-2 rounded-lg border border-gray-200 bg-white p-3">
                <div className="mb-3 flex gap-2">
                  <input
                    value={newTypeName}
                    onChange={(e) => setNewTypeName(e.target.value)}
                    onKeyDown={(e) => {
                      if (e.key === "Enter") {
                        e.preventDefault();
                        addType();
                      }
                    }}
                    placeholder="Add a new type..."
                    className={`${input} min-w-0 flex-1`}
                  />
                  <button onClick={addType} className="rounded-md bg-[#0B3D63] px-3 py-2 text-sm font-medium text-white">
                    Add
                  </button>
                </div>
                {typeError && <p className="mb-2 text-sm text-red-600">{typeError}</p>}
                <ul className="flex flex-wrap gap-2">
                  {types.map((t) => (
                    <li
                      key={t.id}
                      className="flex items-center gap-1.5 rounded-full border border-gray-200 bg-gray-50 px-3 py-1 text-xs"
                    >
                      {t.name}
                      <span className="text-gray-400">{t.drugCount}</span>
                      {t.drugCount === 0 && (
                        <button
                          onClick={() => removeType(t)}
                          className="text-gray-400 hover:text-red-600"
                          aria-label={`Delete ${t.name}`}
                          title="Delete (no drugs use it)"
                        >
                          ×
                        </button>
                      )}
                    </li>
                  ))}
                </ul>
                <p className="mt-2 text-xs text-gray-400">
                  The number is how many drugs use the type. A type can only be deleted when it&apos;s 0.
                </p>
              </div>
            )}
          </>
        )}
      </section>

      <section>
        <h1 className="mb-4 text-xl font-medium">Dispense to patient</h1>
        <form onSubmit={handleDispense} className="flex flex-col gap-2">
          <PatientPicker value={patient} onChange={setPatient} />

          <select
            value={dispenseForm.drugId}
            onChange={(e) => setDispenseForm({ ...dispenseForm, drugId: e.target.value })}
            required
            className={input}
          >
            <option value="">Select drug</option>
            {drugs.map((d) => (
              <option key={d.id} value={d.id} disabled={d.stockQty === 0}>
                {d.name} · {d.unit} ({d.stockQty} left)
                {expiryState(d.expiryDate) === "expired" ? " — EXPIRED" : ""}
              </option>
            ))}
          </select>

          <input
            type="number"
            min="1"
            placeholder="Quantity"
            value={dispenseForm.quantity}
            onChange={(e) => setDispenseForm({ ...dispenseForm, quantity: e.target.value })}
            required
            className={input}
          />

          {error && <p className="text-sm text-red-600">{error}</p>}
          {message && <p className="text-sm text-[#0982e8]">{message}</p>}

          <button
            type="submit"
            className="rounded-md bg-[#D85A30] px-4 py-2 text-sm font-medium text-white hover:opacity-90"
          >
            Dispense
          </button>
        </form>
      </section>
    </main>
  );
}

// A tiny wrapper so a drug can render its row plus an optional panel row.
function FragmentRows({ children }: { children: React.ReactNode }) {
  return <>{children}</>;
}

// ---------------------------------------------------------------- Restock

function RestockPanel({
  drug,
  onDone,
  onCancel,
}: {
  drug: Drug;
  onDone: (msg?: string) => void;
  onCancel: () => void;
}) {
  const [f, setF] = useState({ quantity: "", supplier: "", batchNo: "", expiryDate: "", unitCost: "", note: "" });
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState("");
  const qty = Number(f.quantity);
  const valid = Number.isInteger(qty) && qty > 0;

  const submit = async () => {
    setBusy(true);
    setError("");
    const r = await send(`/api/pharmacy/drugs/${drug.id}/stock`, "POST", {
      kind: "RECEIVED",
      ...f,
      quantity: qty,
    });
    setBusy(false);
    if (!r.ok) {
      setError(r.error);
      return;
    }
    onDone(`${drug.name}: added ${qty} ${drug.unit.toLowerCase()} — stock is now ${r.data.drug.stockQty}.`);
  };

  return (
    <div className="rounded-md border border-[#8FB8D9] bg-white p-3">
      <p className="mb-2 text-sm font-medium text-[#0B3D63]">
        Restock {drug.name}{" "}
        <span className="font-normal text-gray-500">
          (now {drug.stockQty}
          {valid ? ` → ${drug.stockQty + qty}` : ""})
        </span>
      </p>
      <div className="grid gap-2 sm:grid-cols-2">
        <label className="text-xs text-gray-500">
          Quantity received *
          <input
            type="number"
            min="1"
            value={f.quantity}
            onChange={(e) => setF({ ...f, quantity: e.target.value })}
            autoFocus
            className={`${input} mt-1 w-full`}
          />
        </label>
        <label className="text-xs text-gray-500">
          Supplier
          <input value={f.supplier} onChange={(e) => setF({ ...f, supplier: e.target.value })} className={`${input} mt-1 w-full`} />
        </label>
        <label className="text-xs text-gray-500">
          Batch number
          <input value={f.batchNo} onChange={(e) => setF({ ...f, batchNo: e.target.value })} className={`${input} mt-1 w-full`} />
        </label>
        <label className="text-xs text-gray-500">
          Expiry date of this batch
          <input type="date" value={f.expiryDate} onChange={(e) => setF({ ...f, expiryDate: e.target.value })} className={`${input} mt-1 w-full`} />
        </label>
        <label className="text-xs text-gray-500">
          Buying price per unit (KES)
          <input type="number" min="0" step="0.01" value={f.unitCost} onChange={(e) => setF({ ...f, unitCost: e.target.value })} className={`${input} mt-1 w-full`} />
        </label>
        <label className="text-xs text-gray-500">
          Note
          <input value={f.note} onChange={(e) => setF({ ...f, note: e.target.value })} placeholder="e.g. delivery note no." className={`${input} mt-1 w-full`} />
        </label>
      </div>
      {error && <p className="mt-2 text-sm text-red-600">{error}</p>}
      <div className="mt-3 flex gap-2">
        <button
          onClick={submit}
          disabled={busy || !valid}
          className="rounded-md bg-[#0982e8] px-4 py-2 text-sm font-medium text-white hover:bg-[#0a70c4] disabled:opacity-50"
        >
          {busy ? "Saving..." : "Add to stock"}
        </button>
        <button onClick={onCancel} className="rounded-md border border-gray-300 px-4 py-2 text-sm">
          Cancel
        </button>
      </div>
    </div>
  );
}

// ----------------------------------------------------------------- Adjust

function AdjustPanel({
  drug,
  onDone,
  onCancel,
}: {
  drug: Drug;
  onDone: (msg?: string) => void;
  onCancel: () => void;
}) {
  const [direction, setDirection] = useState<"remove" | "add">("remove");
  const [quantity, setQuantity] = useState("");
  const [reason, setReason] = useState("");
  const [note, setNote] = useState("");
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState("");
  const qty = Number(quantity);
  const valid = Number.isInteger(qty) && qty > 0 && reason !== "";
  const signed = direction === "remove" ? -qty : qty;

  const submit = async () => {
    setBusy(true);
    setError("");
    const r = await send(`/api/pharmacy/drugs/${drug.id}/stock`, "POST", {
      kind: "ADJUSTED",
      quantity: signed,
      reason,
      note,
    });
    setBusy(false);
    if (!r.ok) {
      setError(r.error);
      return;
    }
    onDone(`${drug.name}: stock ${signed < 0 ? "reduced" : "increased"} by ${qty} — now ${r.data.drug.stockQty}.`);
  };

  return (
    <div className="rounded-md border border-[#8FB8D9] bg-white p-3">
      <p className="mb-1 text-sm font-medium text-[#0B3D63]">
        Adjust stock of {drug.name}{" "}
        <span className="font-normal text-gray-500">
          (now {drug.stockQty}
          {valid ? ` → ${Math.max(0, drug.stockQty + signed)}` : ""})
        </span>
      </p>
      <p className="mb-2 text-xs text-gray-500">
        For expired, damaged or missing stock, or to correct a miscount. Use <span className="font-medium">Restock</span> for
        new deliveries. Every adjustment is recorded with your name.
      </p>
      <div className="grid gap-2 sm:grid-cols-2">
        <label className="text-xs text-gray-500">
          Change
          <div className="mt-1 flex gap-2">
            <select value={direction} onChange={(e) => setDirection(e.target.value as "remove" | "add")} className={input}>
              <option value="remove">Remove</option>
              <option value="add">Add</option>
            </select>
            <input
              type="number"
              min="1"
              value={quantity}
              onChange={(e) => setQuantity(e.target.value)}
              placeholder="Quantity"
              autoFocus
              className={`${input} min-w-0 flex-1`}
            />
          </div>
        </label>
        <label className="text-xs text-gray-500">
          Reason *
          <select value={reason} onChange={(e) => setReason(e.target.value)} className={`${input} mt-1 w-full`}>
            <option value="">Choose a reason</option>
            {ADJUST_REASONS.map((r) => (
              <option key={r} value={r}>
                {r}
              </option>
            ))}
          </select>
        </label>
        <label className="text-xs text-gray-500 sm:col-span-2">
          Note {reason === "Other" ? "*" : "(optional)"}
          <input value={note} onChange={(e) => setNote(e.target.value)} className={`${input} mt-1 w-full`} />
        </label>
      </div>
      {error && <p className="mt-2 text-sm text-red-600">{error}</p>}
      <div className="mt-3 flex gap-2">
        <button
          onClick={submit}
          disabled={busy || !valid}
          className="rounded-md bg-[#D85A30] px-4 py-2 text-sm font-medium text-white hover:opacity-90 disabled:opacity-50"
        >
          {busy ? "Saving..." : "Record adjustment"}
        </button>
        <button onClick={onCancel} className="rounded-md border border-gray-300 px-4 py-2 text-sm">
          Cancel
        </button>
      </div>
    </div>
  );
}

// ---------------------------------------------------------------- History

function HistoryPanel({ drug, onClose }: { drug: Drug; onClose: () => void }) {
  const [entries, setEntries] = useState<HistoryEntry[] | null>(null);
  const [error, setError] = useState("");

  useEffect(() => {
    let cancelled = false;
    (async () => {
      const res = await fetch(`/api/pharmacy/drugs/${drug.id}/history`);
      const data = await res.json().catch(() => ({}));
      if (cancelled) return;
      if (!res.ok) setError(data.error || "Could not load history");
      else setEntries(data.entries);
    })();
    return () => {
      cancelled = true;
    };
  }, [drug.id]);

  const label = { RECEIVED: "Received", ADJUSTED: "Adjusted", DISPENSED: "Dispensed" } as const;

  return (
    <div className="rounded-md border border-[#8FB8D9] bg-white p-3">
      <div className="mb-2 flex items-center justify-between">
        <p className="text-sm font-medium text-[#0B3D63]">Stock history — {drug.name}</p>
        <button onClick={onClose} className="text-xs text-gray-500 hover:underline">
          Close
        </button>
      </div>
      {error && <p className="text-sm text-red-600">{error}</p>}
      {!entries && !error && <p className="text-sm text-gray-500">Loading...</p>}
      {entries && entries.length === 0 && <p className="text-sm text-gray-400">Nothing recorded yet.</p>}
      {entries && entries.length > 0 && (
        <ul className="max-h-72 divide-y divide-gray-100 overflow-auto text-sm">
          {entries.map((e) => (
            <li key={`${e.type}-${e.id}`} className="flex items-start justify-between gap-3 py-1.5">
              <div className="min-w-0">
                <p>
                  <span className="font-medium">{label[e.type]}</span>
                  <span className="text-gray-400"> · {fmtDateTime(e.at)}</span>
                  {e.by && <span className="text-gray-400"> · {e.by}</span>}
                </p>
                {e.detail && <p className="break-words text-xs text-gray-500">{e.detail}</p>}
              </div>
              <div className="shrink-0 text-right">
                <p className={e.quantity > 0 ? "font-medium text-[#0C447C]" : "font-medium text-[#993C1D]"}>
                  {e.quantity > 0 ? "+" : ""}
                  {e.quantity}
                </p>
                {e.stockAfter !== null && <p className="text-xs text-gray-400">stock {e.stockAfter}</p>}
              </div>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}

// ------------------------------------------------------------------- Edit

function EditPanel({
  drug,
  types,
  onDone,
  onCancel,
}: {
  drug: Drug;
  types: DrugType[];
  onDone: (msg?: string) => void;
  onCancel: () => void;
}) {
  // Older drugs may store "tablet" where the list says "Tablet".
  const match = types.find((t) => t.name.toLowerCase() === drug.unit.toLowerCase());
  const [f, setF] = useState({
    name: drug.name,
    unit: match?.name ?? drug.unit,
    unitPrice: String(drug.unitPrice),
    reorderAt: String(drug.reorderAt),
  });
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState("");

  const submit = async () => {
    setBusy(true);
    setError("");
    const r = await send(`/api/pharmacy/drugs/${drug.id}`, "PATCH", f);
    setBusy(false);
    if (!r.ok) {
      setError(r.error);
      return;
    }
    onDone(`${f.name} updated.`);
  };

  return (
    <div className="rounded-md border border-[#8FB8D9] bg-white p-3">
      <p className="mb-2 text-sm font-medium text-[#0B3D63]">Edit {drug.name}</p>
      <div className="grid gap-2 sm:grid-cols-2">
        <label className="text-xs text-gray-500 sm:col-span-2">
          Name
          <input value={f.name} onChange={(e) => setF({ ...f, name: e.target.value })} className={`${input} mt-1 w-full`} />
        </label>
        <label className="text-xs text-gray-500">
          Type
          <select value={f.unit} onChange={(e) => setF({ ...f, unit: e.target.value })} className={`${input} mt-1 w-full`}>
            {types.map((t) => (
              <option key={t.id} value={t.name}>
                {t.name}
              </option>
            ))}
          </select>
        </label>
        <label className="text-xs text-gray-500">
          Unit price (KES)
          <input type="number" min="0" step="0.01" value={f.unitPrice} onChange={(e) => setF({ ...f, unitPrice: e.target.value })} className={`${input} mt-1 w-full`} />
        </label>
        <label className="text-xs text-gray-500">
          Low-stock warning at
          <input type="number" min="0" value={f.reorderAt} onChange={(e) => setF({ ...f, reorderAt: e.target.value })} className={`${input} mt-1 w-full`} />
        </label>
      </div>
      <p className="mt-2 text-xs text-gray-400">
        A new price applies to future dispenses only — invoices already raised keep the price they were billed at.
        Stock is changed with Restock / Adjust.
      </p>
      {error && <p className="mt-2 text-sm text-red-600">{error}</p>}
      <div className="mt-3 flex gap-2">
        <button
          onClick={submit}
          disabled={busy}
          className="rounded-md bg-[#0B3D63] px-4 py-2 text-sm font-medium text-white disabled:opacity-50"
        >
          {busy ? "Saving..." : "Save"}
        </button>
        <button onClick={onCancel} className="rounded-md border border-gray-300 px-4 py-2 text-sm">
          Cancel
        </button>
      </div>
    </div>
  );
}
