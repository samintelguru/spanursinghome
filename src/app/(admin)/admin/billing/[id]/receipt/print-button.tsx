"use client";

export default function PrintButton() {
  return (
    <button
      onClick={() => window.print()}
      className="rounded-md bg-[#0B3D63 ] px-4 py-2 text-sm font-medium text-white print:hidden"
    >
      Print / Save as PDF
    </button>
  );
}