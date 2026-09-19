import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";
import { HttpError, invoiceTotals, statusFor } from "@/lib/billing";
import { billingError, loadOpenInvoice } from "@/lib/billing-server";

const prisma = new PrismaClient();

// DELETE /api/billing/invoices/[id]/items/[itemId]
// Removes a manually-added charge (e.g. a wrong price typed in). Charges that
// came from a pharmacy dispense can't be removed here — they are tied to stock.
export async function DELETE(
  _req: NextRequest,
  { params }: { params: Promise<{ id: string; itemId: string }> }
) {
  try {
    const session = await auth();
    const role = (session?.user as { role?: string })?.role;
    if (!session || !can(role, "managesBilling")) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const { id, itemId } = await params;

    const invoice = await prisma.$transaction(async (tx) => {
      const inv = await loadOpenInvoice(tx, id);

      const item = inv.items.find((i) => i.id === itemId);
      if (!item) throw new HttpError(404, "Item not found on this invoice");
      if (item.dispenseId) {
        throw new HttpError(409, "Drug charges can't be removed here — they are linked to pharmacy stock");
      }
      if (inv.items.length === 1) {
        throw new HttpError(409, "This is the only item — waive the invoice instead");
      }

      const remaining = inv.items.filter((i) => i.id !== itemId);
      const { dueC, paidC } = invoiceTotals(remaining, inv.payments);
      if (paidC > dueC) {
        throw new HttpError(
          409,
          "Can't remove this item: payments already recorded exceed the new total"
        );
      }

      await tx.invoiceItem.delete({ where: { id: itemId } });
      return tx.invoice.update({
        where: { id },
        data: { status: statusFor(dueC, paidC) },
        include: { items: true, payments: true, patient: true },
      });
    });

    return NextResponse.json({ invoice });
  } catch (err) {
    return billingError(err, "DELETE /api/billing/invoices/[id]/items/[itemId]");
  }
}
