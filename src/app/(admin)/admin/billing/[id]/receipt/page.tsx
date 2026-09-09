import { PrismaClient } from "@prisma/client";
import { notFound } from "next/navigation";
import PrintButton from "./print-button";

const prisma = new PrismaClient();

export default async function ReceiptPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;

  const invoice = await prisma.invoice.findUnique({
    where: { id },
    include: {
      patient: true,
      items: true,
      payments: { orderBy: { paidAt: "asc" } },
    },
  });

  if (!invoice) notFound();

  const due = invoice.items.reduce((s, i) => s + Number(i.amount), 0);
  const paid = invoice.payments.reduce((s, p) => s + Number(p.amount), 0);
  const balance = due - paid;

  return (
    <main className="mx-auto max-w-lg p-8">
      <div className="mb-6 flex items-center justify-between print:hidden">
        <h1 className="text-xl font-medium">Receipt</h1>
        <PrintButton />
      </div>

      <div className="rounded-lg border border-gray-200 p-6 print:border-0 print:p-0">
        <div className="mb-6 text-center">
          <p className="text-sm font-medium tracking-wide text-[#0B3D63 ]">
            SPA NURSING HOME
          </p>
          <p className="text-xs text-gray-500">Ruiru, Kiambu County</p>
        </div>

        <div className="mb-4 flex justify-between text-sm">
          <div>
            <p className="font-medium">{invoice.patient.fullName}</p>
            <p className="text-gray-500">File no. {invoice.patient.fileNumber}</p>
          </div>
          <div className="text-right text-gray-500">
            <p>Invoice #{invoice.id.slice(-8).toUpperCase()}</p>
            <p>{invoice.createdAt.toLocaleDateString()}</p>
          </div>
        </div>

        <table className="mb-4 w-full text-left text-sm">
          <thead>
            <tr className="border-b border-gray-200 text-gray-500">
              <th className="py-1">Description</th>
              <th className="py-1 text-right">Amount</th>
            </tr>
          </thead>
          <tbody>
            {invoice.items.map((item) => (
              <tr key={item.id} className="border-b border-gray-100">
                <td className="py-1">{item.description}</td>
                <td className="py-1 text-right">KES {Number(item.amount).toFixed(2)}</td>
              </tr>
            ))}
          </tbody>
        </table>

        <div className="mb-4 flex justify-between text-sm font-medium">
          <span>Total due</span>
          <span>KES {due.toFixed(2)}</span>
        </div>

        {invoice.payments.length > 0 && (
          <div className="mb-4">
            <p className="mb-1 text-xs font-medium text-gray-500">
              Payments received
            </p>
            {invoice.payments.map((p) => (
              <div key={p.id} className="flex justify-between text-sm text-gray-600">
                <span>
                  {p.method} {p.reference ? `(${p.reference})` : ""} —{" "}
                  {p.paidAt.toLocaleDateString()}
                </span>
                <span>KES {Number(p.amount).toFixed(2)}</span>
              </div>
            ))}
          </div>
        )}

        <div className="flex justify-between border-t border-gray-200 pt-3 text-base font-medium">
          <span>Balance</span>
          <span className={balance > 0 ? "text-red-600" : "text-[#0B3D63 ]"}>
            KES {balance.toFixed(2)}
          </span>
        </div>

        <p className="mt-6 text-center text-xs text-gray-400">
          Thank you for choosing SPA Nursing Home.
        </p>
      </div>
    </main>
  );
}