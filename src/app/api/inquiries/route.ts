import { NextRequest, NextResponse } from "next/server";
import { PrismaClient, Prisma, InquiryStatus } from "@prisma/client";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";

const prisma = new PrismaClient();

const STATUSES: InquiryStatus[] = ["NEW", "IN_PROGRESS", "RESOLVED"];

// GET /api/inquiries?status=NEW|IN_PROGRESS|RESOLVED&q=...
export async function GET(req: NextRequest) {
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  if (!session || !can(role, "viewsInquiries")) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const status = req.nextUrl.searchParams.get("status") ?? "";
  const q = req.nextUrl.searchParams.get("q")?.trim();

  const where: Prisma.ContactMessageWhereInput = {};
  if ((STATUSES as string[]).includes(status)) where.status = status as InquiryStatus;
  if (q) {
    where.OR = [
      { fullName: { contains: q, mode: "insensitive" } },
      { phone: { contains: q } },
      { message: { contains: q, mode: "insensitive" } },
    ];
  }

  const [inquiries, grouped] = await Promise.all([
    prisma.contactMessage.findMany({
      where,
      orderBy: { createdAt: "desc" },
      take: 200,
      include: { handledBy: { select: { fullName: true } } },
    }),
    prisma.contactMessage.groupBy({ by: ["status"], _count: { _all: true } }),
  ]);

  const counts: Record<string, number> = { NEW: 0, IN_PROGRESS: 0, RESOLVED: 0 };
  for (const g of grouped) counts[g.status] = g._count._all;

  return NextResponse.json({
    inquiries,
    counts,
    canDelete: role === "ADMIN",
  });
}
