import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";

const prisma = new PrismaClient();

export async function POST(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const session = await auth();
  if (!session) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { id: invoiceId } = await params;
  const body = await req.json();
  const { amount, method, reference } = body;

  if (!amount || !method) {
    return NextResponse.json(
      { error: "amount and method are required" },
      { status: 400 }
    );
  }

  const invoice = await prisma.invoice.findUnique({
    where: { id: invoiceId },
    include: { items: true, payments: true },
  });
  if (!invoice) {
    return NextResponse.json({ error: "Invoice not found" }, { status: 404 });
  }

  const result = await prisma.$transaction(async (tx) => {
    await tx.payment.create({
      data: { invoiceId, amount, method, reference: reference || null },
    });

    const totalDue = invoice.items.reduce(
      (sum, item) => sum + Number(item.amount),
      0
    );
    const totalPaidSoFar =
      invoice.payments.reduce((sum, p) => sum + Number(p.amount), 0) +
      Number(amount);

    const newStatus =
      totalPaidSoFar >= totalDue
        ? "PAID"
        : totalPaidSoFar > 0
        ? "PARTIALLY_PAID"
        : "UNPAID";

    return tx.invoice.update({
      where: { id: invoiceId },
      data: { status: newStatus },
      include: { items: true, payments: true, patient: true },
    });
  });

  return NextResponse.json({ invoice: result }, { status: 201 });
}