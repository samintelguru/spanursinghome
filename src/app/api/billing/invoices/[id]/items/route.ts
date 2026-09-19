import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";
import { invoiceTotals, parseLineItem, statusFor } from "@/lib/billing";
import { billingError, loadOpenInvoice } from "@/lib/billing-server";

const prisma = new PrismaClient();

// POST /api/billing/invoices/[id]/items
// Adds a charge to an invoice that is still open (unpaid or partly paid).
// body: { description, quantity, unitPrice }
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

    const { id } = await params;
    const line = parseLineItem(await req.json());

    const invoice = await prisma.$transaction(async (tx) => {
      const inv = await loadOpenInvoice(tx, id);
      await tx.invoiceItem.create({ data: { invoiceId: id, ...line } });

      const fresh = await tx.invoiceItem.findMany({ where: { invoiceId: id } });
      const { dueC, paidC } = invoiceTotals(fresh, inv.payments);
      return tx.invoice.update({
        where: { id },
        data: { status: statusFor(dueC, paidC) },
        include: { items: true, payments: true, patient: true },
      });
    });

    return NextResponse.json({ invoice }, { status: 201 });
  } catch (err) {
    return billingError(err, "POST /api/billing/invoices/[id]/items");
  }
}
