"use client";

import { useEffect, useRef, useState } from "react";
import QRCode from "qrcode";

export default function PatientIdCard({
  patientId,
  fileNumber,
  fullName,
}: {
  patientId: string;
  fileNumber: string;
  fullName: string;
}) {
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const [showCard, setShowCard] = useState(false);

  useEffect(() => {
    if (!showCard || !canvasRef.current) return;
    const url = `${window.location.origin}/admin/patients/${patientId}`;
    QRCode.toCanvas(canvasRef.current, url, { width: 160, margin: 1 });
  }, [showCard, patientId]);

  return (
    <div>
      <button
        onClick={() => setShowCard(!showCard)}
        className="text-xs text-[#0B3D63] underline print:hidden"
      >
        {showCard ? "Hide ID card" : "Show / print ID card"}
      </button>

      {showCard && (
        <div className="mt-3 flex items-center gap-4 rounded-xl border border-gray-200 p-4 print:border-0">
          <canvas ref={canvasRef} />
          <div>
            <p className="text-xs font-medium text-[#0B3D63]">SPA NURSING HOME</p>
            <p className="mt-1 text-sm font-medium">{fullName}</p>
            <p className="text-xs text-gray-500">File no. {fileNumber}</p>
            <button
              onClick={() => window.print()}
              className="mt-3 rounded-md bg-[#0982e8] px-3 py-1.5 text-xs font-medium text-white print:hidden"
            >
              Print
            </button>
          </div>
        </div>
      )}
    </div>
  );
}