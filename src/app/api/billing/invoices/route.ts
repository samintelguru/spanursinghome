import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";

const prisma = new PrismaClient();

export async function GET() {
   const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  if (!session || !can(role, "recordsPayments")) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
  const invoices = await prisma.invoice.findMany({
    orderBy: { createdAt: "desc" },
    include: {
      patient: true,
      items: true,
      payments: true,
    },
  });

  return NextResponse.json({ invoices });
}