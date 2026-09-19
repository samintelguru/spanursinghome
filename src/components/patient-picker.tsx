"use client";

import { useEffect, useId, useRef, useState } from "react";

export type PatientLite = {
  id: string;
  fileNumber: string;
  fullName: string;
  phone?: string | null;
};

const LIMIT = 20;

// Type-ahead patient search. Type the first letter(s) of a name and the
// matching patients appear straight away (name first, file number after).
// Also matches file numbers and phone numbers. Arrow keys + Enter work.
export default function PatientPicker({
  value,
  onChange,
  placeholder = "Type a name or file number...",
  size = "md",
  autoFocus = false,
}: {
  value: PatientLite | null;
  onChange: (patient: PatientLite | null) => void;
  placeholder?: string;
  size?: "sm" | "md";
  autoFocus?: boolean;
}) {
  const [query, setQuery] = useState("");
  const [results, setResults] = useState<PatientLite[]>([]);
  const [open, setOpen] = useState(false);
  const [loading, setLoading] = useState(false);
  const [failed, setFailed] = useState(false);
  const [active, setActive] = useState(0);
  const wrapRef = useRef<HTMLDivElement>(null);
  const listId = useId();

  const pad = size === "sm" ? "px-2 py-1 text-xs" : "px-3 py-2 text-sm";

  // Fetch as the user types (short delay so we don't fire on every keystroke).
  useEffect(() => {
    if (!open || value) return;
    const q = query.trim();
    let cancelled = false;

    const t = setTimeout(async () => {
      setLoading(true);
      try {
        const url = q
          ? `/api/patients?q=${encodeURIComponent(q)}&limit=${LIMIT}`
          : "/api/patients?limit=8";
        const res = await fetch(url);
        if (cancelled) return;
        if (!res.ok) {
          setFailed(true);
          setResults([]);
        } else {
          setFailed(false);
          setResults((await res.json()).patients as PatientLite[]);
          setActive(0);
        }
      } catch {
        if (!cancelled) {
          setFailed(true);
          setResults([]);
        }
      } finally {
        if (!cancelled) setLoading(false);
      }
    }, q ? 150 : 0);

    return () => {
      cancelled = true;
      clearTimeout(t);
    };
  }, [query, open, value]);

  // Close the list when clicking elsewhere.
  useEffect(() => {
    const onDown = (e: MouseEvent) => {
      if (wrapRef.current && !wrapRef.current.contains(e.target as Node)) setOpen(false);
    };
    document.addEventListener("mousedown", onDown);
    return () => document.removeEventListener("mousedown", onDown);
  }, []);

  const choose = (p: PatientLite) => {
    onChange(p);
    setQuery("");
    setResults([]);
    setOpen(false);
  };

  if (value) {
    return (
      <div
        className={`flex items-center justify-between gap-2 rounded-md border border-gray-300 bg-white ${pad}`}
      >
        <span className="min-w-0 truncate">
          <span className="font-medium">{value.fullName}</span>
          <span className="text-gray-500"> · {value.fileNumber}</span>
        </span>
        <button
          type="button"
          onClick={() => {
            onChange(null);
            setOpen(true);
          }}
          className="shrink-0 text-xs text-[#0982e8] hover:underline"
        >
          Change
        </button>
      </div>
    );
  }

  return (
    <div ref={wrapRef} className="relative">
      <input
        type="text"
        role="combobox"
        aria-expanded={open}
        aria-controls={listId}
        aria-autocomplete="list"
        autoComplete="off"
        autoFocus={autoFocus}
        placeholder={placeholder}
        value={query}
        onFocus={() => setOpen(true)}
        onChange={(e) => {
          setQuery(e.target.value);
          setOpen(true);
        }}
        onKeyDown={(e) => {
          if (e.key === "ArrowDown") {
            e.preventDefault();
            setOpen(true);
            setActive((a) => Math.min(results.length - 1, a + 1));
          } else if (e.key === "ArrowUp") {
            e.preventDefault();
            setActive((a) => Math.max(0, a - 1));
          } else if (e.key === "Enter") {
            // Never submit the surrounding form just to pick a patient.
            if (open && results[active]) {
              e.preventDefault();
              choose(results[active]);
            } else if (open) {
              e.preventDefault();
            }
          } else if (e.key === "Escape") {
            setOpen(false);
          }
        }}
        className={`w-full rounded-md border border-gray-300 bg-white ${pad}`}
      />

      {open && (
        <ul
          id={listId}
          role="listbox"
          className="absolute left-0 right-0 z-30 mt-1 max-h-72 overflow-auto rounded-md border border-gray-200 bg-white text-sm shadow-lg"
        >
          {!query.trim() && results.length > 0 && (
            <li className="px-3 pt-2 text-[11px] uppercase tracking-wide text-gray-400">
              Recently registered — or start typing a name
            </li>
          )}

          {results.map((p, i) => (
            <li
              key={p.id}
              role="option"
              aria-selected={i === active}
              onMouseDown={(e) => {
                e.preventDefault();
                choose(p);
              }}
              onMouseEnter={() => setActive(i)}
              className={`flex cursor-pointer items-baseline justify-between gap-3 px-3 py-2 ${
                i === active ? "bg-[#E6F1FB]" : ""
              }`}
            >
              <span className="min-w-0 truncate font-medium text-[#2C2C2A]">{p.fullName}</span>
              <span className="shrink-0 text-xs text-gray-500">
                {p.fileNumber}
                {p.phone ? ` · ${p.phone}` : ""}
              </span>
            </li>
          ))}

          {loading && results.length === 0 && (
            <li className="px-3 py-2 text-xs text-gray-500">Searching...</li>
          )}
          {failed && (
            <li className="px-3 py-2 text-xs text-red-600">
              Couldn&apos;t load patients. Check your connection and try again.
            </li>
          )}
          {!loading && !failed && results.length === 0 && (
            <li className="px-3 py-2 text-xs text-gray-500">
              {query.trim() ? `No patients match "${query.trim()}".` : "No patients registered yet."}
            </li>
          )}
          {query.trim() && results.length >= LIMIT && (
            <li className="border-t border-gray-100 px-3 py-2 text-xs text-gray-400">
              Showing the first {LIMIT} — keep typing to narrow it down.
            </li>
          )}
        </ul>
      )}
    </div>
  );
}
