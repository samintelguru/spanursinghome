import { NextRequest, NextResponse } from "next/server";
import { PrismaClient, Prisma } from "@prisma/client";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";
import { HttpError, OPEN_STATUSES, parseLineItem } from "@/lib/billing";
import { billingError } from "@/lib/billing-server";

const prisma = new PrismaClient();

const STATUS_FILTERS = ["UNPAID", "PARTIALLY_PAID", "PAID", "WAIVED"] as const;

// GET /api/billing/invoices?status=OPEN|UNPAID|PARTIALLY_PAID|PAID|WAIVED&q=...
export async function GET(req: NextRequest) {
  try {
    const session = await auth();
    const role = (session?.user as { role?: string })?.role;
    if (!session || !can(role, "recordsPayments")) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const status = req.nextUrl.searchParams.get("status") ?? "";
    const q = req.nextUrl.searchParams.get("q")?.trim();
    const take = Math.min(Number(req.nextUrl.searchParams.get("take")) || 100, 300);

    const where: Prisma.InvoiceWhereInput = {};
    if (status === "OPEN") where.status = { in: OPEN_STATUSES };
    else if ((STATUS_FILTERS as readonly string[]).includes(status)) {
      where.status = status as (typeof STATUS_FILTERS)[number];
    }
    if (q) {
      where.patient = {
        OR: [
          { fullName: { contains: q, mode: "insensitive" } },
          { fileNumber: { contains: q, mode: "insensitive" } },
        ],
      };
    }

    const invoices = await prisma.invoice.findMany({
      where,
      orderBy: { createdAt: "desc" },
      take,
      include: {
        patient: { select: { id: true, fileNumber: true, fullName: true } },
        items: true,
        payments: {
          orderBy: { paidAt: "asc" },
          include: { receivedBy: { select: { fullName: true } } },
        },
      },
    });

    return NextResponse.json({ invoices, canManage: can(role, "managesBilling") });
  } catch (err) {
    return billingError(err, "GET /api/billing/invoices");
  }
}

// POST /api/billing/invoices
// body: { patientId, items: [{ description, quantity, unitPrice }] }
export async function POST(req: NextRequest) {
  try {
    const session = await auth();
    const role = (session?.user as { role?: string })?.role;
    if (!session || !can(role, "recordsPayments")) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }
    const staffId = (session.user as { id?: string }).id ?? null;

    const body = await req.json();
    const { patientId, items } = body ?? {};

    if (!patientId || typeof patientId !== "string") {
      throw new HttpError(400, "Choose a patient first");
    }
    if (!Array.isArray(items) || items.length === 0) {
      throw new HttpError(400, "Add at least one item to the invoice");
    }
    if (items.length > 30) {
      throw new HttpError(400, "An invoice can have at most 30 items");
    }
    const lines = items.map(parseLineItem);

    const patient = await prisma.patient.findUnique({ where: { id: patientId } });
    if (!patient) throw new HttpError(404, "Patient not found");

    const invoice = await prisma.invoice.create({
      data: {
        patientId,
        createdById: staffId,
        items: { create: lines },
      },
      include: { items: true, patient: true },
    });

    return NextResponse.json({ invoice }, { status: 201 });
  } catch (err) {
    return billingError(err, "POST /api/billing/invoices");
  }
}
