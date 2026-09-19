// Server-only billing helpers (uses Prisma types and NextResponse).
import { NextResponse } from "next/server";
import type { Prisma } from "@prisma/client";
import { HttpError, OPEN_STATUSES } from "@/lib/billing";

// Turns anything thrown in a billing route into a clean JSON response.
export function billingError(err: unknown, where: string) {
  if (err instanceof HttpError) {
    return NextResponse.json({ error: err.message }, { status: err.status });
  }
  console.error(`${where} failed:`, err);
  return NextResponse.json({ error: "Something went wrong. Please try again." }, { status: 500 });
}

// Loads an invoice inside a transaction while holding a row lock on it, so two
// clerks acting on the same invoice at the same moment are processed one after
// the other and can never both pass the "balance is enough" check.
export async function loadOpenInvoice(tx: Prisma.TransactionClient, id: string) {
  await tx.$queryRaw`SELECT id FROM "Invoice" WHERE id = ${id} FOR UPDATE`;

  const invoice = await tx.invoice.findUnique({
    where: { id },
    include: { items: true, payments: true },
  });
  if (!invoice) throw new HttpError(404, "Invoice not found");

  if (!(OPEN_STATUSES as string[]).includes(invoice.status)) {
    throw new HttpError(
      409,
      invoice.status === "PAID"
        ? "This invoice is already fully paid"
        : "This invoice has been waived"
    );
  }
  return invoice;
}
