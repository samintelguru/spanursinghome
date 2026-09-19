import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";
import { HttpError, invoiceTotals } from "@/lib/billing";
import { billingError, loadOpenInvoice } from "@/lib/billing-server";

const prisma = new PrismaClient();

// POST /api/billing/invoices/[id]/waive   body: { reason }
// Writes off whatever is still owing (charity case, staff/family discount,
// billing error...). Payments already taken stay on the invoice. A reason is
// mandatory and the staff member is recorded, so write-offs can be audited.
export async function POST(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const session = await auth();
    const role = (session?.user as { role?: string })?.role;
    if (!session || !can(role, "managesBilling")) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }
    const staffId = (session.user as { id?: string }).id ?? null;

    const { id } = await params;
    const body = await req.json();
    const reason = typeof body?.reason === "string" ? body.reason.trim() : "";
    if (reason.length < 5 || reason.length > 300) {
      throw new HttpError(400, "Give a reason for the waiver (5–300 characters)");
    }

    const invoice = await prisma.$transaction(async (tx) => {
      const inv = await loadOpenInvoice(tx, id);
      const { balanceC } = invoiceTotals(inv.items, inv.payments);
      if (balanceC <= 0) throw new HttpError(409, "Nothing is owing on this invoice");

      return tx.invoice.update({
        where: { id },
        data: {
          status: "WAIVED",
          waivedReason: reason,
          waivedAt: new Date(),
          waivedById: staffId,
        },
        include: { items: true, payments: true, patient: true },
      });
    });

    return NextResponse.json({ invoice });
  } catch (err) {
    return billingError(err, "POST /api/billing/invoices/[id]/waive");
  }
}
