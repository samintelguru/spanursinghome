"use client";

export default function PrintButton() {
  return (
    <button
      onClick={() => window.print()}
      className="rounded-md bg-[#0982e8] px-4 py-2 text-sm font-medium text-white print:hidden"
    >
      Print / Save as PDF
    </button>
  );
}