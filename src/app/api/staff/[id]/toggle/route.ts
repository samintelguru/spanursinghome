import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";

const prisma = new PrismaClient();

export async function PATCH(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  if (!session || !can(role, "managesStaff")) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { id } = await params;

  const existing = await prisma.staff.findUnique({ where: { id } });
  if (!existing) {
    return NextResponse.json({ error: "Staff account not found" }, { status: 404 });
  }

  const staff = await prisma.staff.update({
    where: { id },
    data: { active: !existing.active },
    select: {
      id: true,
      fullName: true,
      email: true,
      role: true,
      active: true,
      createdAt: true,
    },
  });

  return NextResponse.json({ staff });
}