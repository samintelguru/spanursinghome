"use client";

import { useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { EQUIPMENT_STATUSES, SUGGESTED_CATEGORIES } from "@/lib/equipment";

export type EquipmentFormValues = {
  name: string;
  category: string;
  make: string;
  model: string;
  serialNumber: string;
  location: string;
  quantity: string;
  status: string;
  purchaseDate: string;
  purchaseCost: string;
  supplier: string;
  warrantyExpiry: string;
  serviceIntervalMonths: string;
  lastServiceDate: string;
  notes: string;
};

export const EMPTY_EQUIPMENT: EquipmentFormValues = {
  name: "",
  category: "",
  make: "",
  model: "",
  serialNumber: "",
  location: "",
  quantity: "1",
  status: "IN_USE",
  purchaseDate: "",
  purchaseCost: "",
  supplier: "",
  warrantyExpiry: "",
  serviceIntervalMonths: "",
  lastServiceDate: "",
  notes: "",
};

const INTERVALS = [1, 2, 3, 6, 12, 18, 24, 36, 60];
const inputCls = "mt-1 w-full rounded-md border border-gray-300 bg-white px-3 py-2 text-sm";

const isoToday = () => {
  const d = new Date();
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, "0")}-${String(d.getDate()).padStart(2, "0")}`;
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

export default function EquipmentForm({
  mode,
  equipmentId,
  assetTag,
  initial = EMPTY_EQUIPMENT,
  categories = [],
  locations = [],
}: {
  mode: "create" | "edit";
  equipmentId?: string;
  assetTag?: string;
  initial?: EquipmentFormValues;
  categories?: string[];
  locations?: string[];
}) {
  const router = useRouter();
  const [form, setForm] = useState<EquipmentFormValues>(initial);
  const [hasTag, setHasTag] = useState(false);
  const [tag, setTag] = useState("");
  const [error, setError] = useState("");
  const [saving, setSaving] = useState(false);

  const set = (key: keyof EquipmentFormValues, value: string) => setForm((f) => ({ ...f, [key]: value }));

  const categoryOptions = [...new Set([...categories, ...SUGGESTED_CATEGORIES])].sort();
  const intervals = form.serviceIntervalMonths && !INTERVALS.includes(Number(form.serviceIntervalMonths))
    ? [...INTERVALS, Number(form.serviceIntervalMonths)].sort((a, b) => a - b)
    : INTERVALS;

  const submit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");
    setSaving(true);
    try {
      const res = await fetch(mode === "create" ? "/api/equipment" : `/api/equipment/${equipmentId}`, {
        method: mode === "create" ? "POST" : "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ ...form, ...(mode === "create" && hasTag ? { assetTag: tag } : {}) }),
      });
      const data = await res.json().catch(() => ({}));
      if (!res.ok) {
        setError(data.error || "Something went wrong");
        return;
      }
      router.push(`/admin/equipment/${mode === "create" ? data.equipment.id : equipmentId}`);
      router.refresh();
    } catch {
      setError("Lost connection to the server. The record may not have been saved — check the Equipment list before trying again.");
    } finally {
      setSaving(false);
    }
  };

  return (
    <form onSubmit={submit} className="flex flex-col gap-5">
      <div className="rounded-lg bg-[#E6F1FB] p-4 text-sm text-[#0C447C]">
        {mode === "edit" ? (
          <>
            Asset tag: <span className="font-medium">{assetTag}</span> (can&apos;t be changed)
          </>
        ) : (
          <>
            <p>
              <span className="font-medium">An asset tag is assigned automatically</span> when you save
              (<span className="font-mono">EQ-0001</span>, <span className="font-mono">EQ-0002</span>…). Write it on the
              item or stick a label on it.
            </p>
            <label className="mt-2 flex items-center gap-2 text-xs">
              <input type="checkbox" checked={hasTag} onChange={(e) => setHasTag(e.target.checked)} />
              This item already has a number on it — use that instead
            </label>
            {hasTag && (
              <input
                value={tag}
                onChange={(e) => setTag(e.target.value.toUpperCase())}
                placeholder="Existing asset number"
                className="mt-2 w-full rounded-md border border-[#8FB8D9] bg-white px-3 py-2 text-sm text-gray-800"
              />
            )}
          </>
        )}
      </div>

      <Section title="The equipment">
        <Field label="Name *" wide>
          <input
            value={form.name}
            onChange={(e) => set("name", e.target.value)}
            required
            autoFocus={mode === "create"}
            placeholder="e.g. Ultrasound scanner, Oxygen concentrator, Wheelchair"
            className={inputCls}
          />
        </Field>
        <Field label="Category *">
          <input list="eq-categories" value={form.category} onChange={(e) => set("category", e.target.value)} required className={inputCls} />
          <datalist id="eq-categories">
            {categoryOptions.map((c) => (
              <option key={c} value={c} />
            ))}
          </datalist>
        </Field>
        <Field label="Status">
          <select value={form.status} onChange={(e) => set("status", e.target.value)} className={inputCls}>
            {EQUIPMENT_STATUSES.map((s) => (
              <option key={s.value} value={s.value}>
                {s.label}
              </option>
            ))}
          </select>
        </Field>
        <Field label="Make / brand">
          <input value={form.make} onChange={(e) => set("make", e.target.value)} className={inputCls} />
        </Field>
        <Field label="Model">
          <input value={form.model} onChange={(e) => set("model", e.target.value)} className={inputCls} />
        </Field>
        <Field label="Serial number">
          <input value={form.serialNumber} onChange={(e) => set("serialNumber", e.target.value)} className={inputCls} />
        </Field>
        <Field label="Quantity" hint="More than 1 for a group of identical items, e.g. 6 wheelchairs">
          <input type="number" min="1" value={form.quantity} onChange={(e) => set("quantity", e.target.value)} className={inputCls} />
        </Field>
        <Field label="Where it is kept" hint="Ward, room or department" wide>
          <input list="eq-locations" value={form.location} onChange={(e) => set("location", e.target.value)} className={inputCls} />
          <datalist id="eq-locations">
            {locations.map((l) => (
              <option key={l} value={l} />
            ))}
          </datalist>
        </Field>
      </Section>

      <Section title="Purchase & warranty">
        <Field label="Purchase date">
          <input type="date" max={isoToday()} value={form.purchaseDate} onChange={(e) => set("purchaseDate", e.target.value)} className={inputCls} />
        </Field>
        <Field label="Cost per item (KES)">
          <input type="number" min="0" step="0.01" value={form.purchaseCost} onChange={(e) => set("purchaseCost", e.target.value)} className={inputCls} />
        </Field>
        <Field label="Supplier">
          <input value={form.supplier} onChange={(e) => set("supplier", e.target.value)} className={inputCls} />
        </Field>
        <Field label="Warranty ends">
          <input type="date" value={form.warrantyExpiry} onChange={(e) => set("warrantyExpiry", e.target.value)} className={inputCls} />
        </Field>
      </Section>

      <Section title="Servicing">
        <Field label="Service every" hint="Leave as “not scheduled” if it doesn't need regular servicing">
          <select value={form.serviceIntervalMonths} onChange={(e) => set("serviceIntervalMonths", e.target.value)} className={inputCls}>
            <option value="">Not scheduled</option>
            {intervals.map((m) => (
              <option key={m} value={m}>
                {m === 1 ? "1 month" : `${m} months`}
              </option>
            ))}
          </select>
        </Field>
        <Field label="Last serviced" hint="The next service date is worked out from this">
          <input type="date" max={isoToday()} value={form.lastServiceDate} onChange={(e) => set("lastServiceDate", e.target.value)} className={inputCls} />
        </Field>
        <Field label="Notes" wide>
          <textarea value={form.notes} onChange={(e) => set("notes", e.target.value)} rows={2} maxLength={500} className={inputCls} />
        </Field>
      </Section>

      {error && <p className="rounded-md border border-red-200 bg-red-50 p-3 text-sm text-red-700">{error}</p>}

      <div className="flex gap-3">
        <button
          type="submit"
          disabled={saving}
          className="rounded-md bg-[#0982e8] px-5 py-2 text-sm font-medium text-white hover:bg-[#0a70c4] disabled:opacity-60"
        >
          {saving ? "Saving..." : mode === "create" ? "Add equipment" : "Save changes"}
        </button>
        <Link
          href={mode === "edit" ? `/admin/equipment/${equipmentId}` : "/admin/equipment"}
          className="rounded-md border border-gray-300 px-5 py-2 text-sm hover:bg-gray-50"
        >
          Cancel
        </Link>
      </div>
    </form>
  );
}
