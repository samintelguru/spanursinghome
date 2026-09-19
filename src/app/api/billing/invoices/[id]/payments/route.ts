import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";
import {
  HttpError,
  PAYMENT_METHODS,
  invoiceTotals,
  isValidMpesaRef,
  kes,
  normalizeRef,
  statusFor,
  toCents,
} from "@/lib/billing";
import { billingError, loadOpenInvoice } from "@/lib/billing-server";

const prisma = new PrismaClient();

// POST /api/billing/invoices/[id]/payments
// body: { amount, method: "cash" | "mpesa" | "insurance", reference? }
//
// M-Pesa is recorded by hand for now: the clerk types the transaction code
// from the customer's confirmation SMS. Codes must be unique so the same
// message can't be used to "pay" two invoices. When the Daraja API is added
// later, it will create Payment rows in exactly the same shape.
export async function POST(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const session = await auth();
    const role = (session?.user as { role?: string })?.role;
    if (!session || !can(role, "recordsPayments")) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }
    const staffId = (session.user as { id?: string }).id ?? null;

    const { id: invoiceId } = await params;
    const body = await req.json();
    const method = String(body?.method ?? "");
    const amountC = toCents(body?.amount);
    const reference = normalizeRef(body?.reference);

    if (!(PAYMENT_METHODS as readonly string[]).includes(method)) {
      throw new HttpError(400, "Choose a payment method");
    }
    if (!Number.isFinite(amountC) || amountC <= 0) {
      throw new HttpError(400, "Enter an amount greater than 0");
    }
    if (method === "mpesa" && !isValidMpesaRef(reference)) {
      throw new HttpError(
        400,
        "Enter the M-Pesa transaction code from the confirmation SMS (8–12 letters/numbers)"
      );
    }

    const invoice = await prisma.$transaction(async (tx) => {
      const inv = await loadOpenInvoice(tx, invoiceId);
      const { dueC, paidC, balanceC } = invoiceTotals(inv.items, inv.payments);

      if (dueC <= 0) throw new HttpError(409, "This invoice has no items to pay for");
      if (amountC > balanceC) {
        throw new HttpError(
          409,
          `Amount is more than the balance. Balance is ${kes(balanceC / 100)}`
        );
      }

      if (method === "mpesa") {
        const dup = await tx.payment.findFirst({ where: { method: "mpesa", reference } });
        if (dup) {
          throw new HttpError(409, `M-Pesa code ${reference} has already been recorded`);
        }
      }

      await tx.payment.create({
        data: {
          invoiceId,
          amount: amountC / 100,
          method,
          reference: reference || null,
          receivedById: staffId,
        },
      });

      return tx.invoice.update({
        where: { id: invoiceId },
        data: { status: statusFor(dueC, paidC + amountC) },
        include: { items: true, payments: true, patient: true },
      });
    });

    return NextResponse.json({ invoice }, { status: 201 });
  } catch (err) {
    return billingError(err, "POST /api/billing/invoices/[id]/payments");
  }
}
