import { PrismaClient } from "@prisma/client";
import Link from "next/link";
import { notFound } from "next/navigation";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";
import { METHOD_LABEL, fmtDate, fmtDateTime, invoiceNo, invoiceTotals, kes } from "@/lib/billing";
import PrintButton from "./print-button";

const prisma = new PrismaClient();

export default async function ReceiptPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  if (!session || !can(role, "recordsPayments")) {
    return (
      <main className="mx-auto max-w-lg p-8">
        <p className="text-sm text-gray-600">You don&apos;t have permission to view receipts.</p>
      </main>
    );
  }

  const { id } = await params;

  const invoice = await prisma.invoice.findUnique({
    where: { id },
    include: {
      patient: true,
      items: true,
      payments: {
        orderBy: { paidAt: "asc" },
        include: { receivedBy: { select: { fullName: true } } },
      },
    },
  });

  if (!invoice) notFound();

  const { due, paid, balance } = invoiceTotals(invoice.items, invoice.payments);
  const waived = invoice.status === "WAIVED";

  return (
    <main className="mx-auto max-w-lg p-8">
      <div className="mb-6 flex items-center justify-between print:hidden">
        <Link href="/admin/billing" className="text-sm text-[#0982e8] hover:underline">
          ← Back to billing
        </Link>
        <PrintButton />
      </div>

      <div className="rounded-lg border border-gray-200 bg-white p-6 print:border-0 print:p-0">
        <div className="mb-6 text-center">
          <p className="font-serif text-lg font-semibold tracking-wide text-[#0B3D63]">
            SPA NURSING HOME
          </p>
          <p className="text-xs text-gray-500">Ruiru, Kiambu County · Emergency: 0706 155 600</p>
          <p className="mt-2 text-sm font-medium text-gray-700">
            {invoice.status === "PAID" ? "Receipt" : "Invoice / statement"}
          </p>
        </div>

        <div className="mb-4 flex justify-between text-sm">
          <div>
            <p className="font-medium">{invoice.patient.fullName}</p>
            <p className="text-gray-500">File no. {invoice.patient.fileNumber}</p>
          </div>
          <div className="text-right text-gray-500">
            <p>Invoice {invoiceNo(invoice.id)}</p>
            <p>{fmtDate(invoice.createdAt)}</p>
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
                <td className="py-1 text-right">{kes(Number(item.amount))}</td>
              </tr>
            ))}
          </tbody>
        </table>

        <div className="mb-4 flex justify-between text-sm font-medium">
          <span>Total due</span>
          <span>{kes(due)}</span>
        </div>

        {invoice.payments.length > 0 && (
          <div className="mb-4">
            <p className="mb-1 text-xs font-medium text-gray-500">Payments received</p>
            {invoice.payments.map((p) => (
              <div key={p.id} className="flex justify-between gap-3 text-sm text-gray-600">
                <span>
                  {METHOD_LABEL[p.method] ?? p.method}
                  {p.reference ? ` (${p.reference})` : ""} — {fmtDateTime(p.paidAt)}
                  {p.receivedBy ? ` · ${p.receivedBy.fullName}` : ""}
                </span>
                <span>{kes(Number(p.amount))}</span>
              </div>
            ))}
            <div className="mt-1 flex justify-between border-t border-gray-100 pt-1 text-sm">
              <span>Total paid</span>
              <span>{kes(paid)}</span>
            </div>
          </div>
        )}

        <div className="flex justify-between border-t border-gray-200 pt-3 text-base font-medium">
          <span>{waived ? "Balance written off" : "Balance"}</span>
          <span className={balance > 0 && !waived ? "text-red-600" : "text-[#0B3D63]"}>
            {kes(balance)}
          </span>
        </div>

        {waived && invoice.waivedReason && (
          <p className="mt-2 text-xs text-gray-500">Waived: {invoice.waivedReason}</p>
        )}

        <p className="mt-6 text-center text-xs text-gray-400">
          Thank you for choosing SPA Nursing Home.
        </p>
      </div>
    </main>
  );
}
