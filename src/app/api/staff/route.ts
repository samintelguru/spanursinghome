import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";
import bcrypt from "bcryptjs";

const prisma = new PrismaClient();

export async function GET() {
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  if (!session || !can(role, "managesStaff")) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const staff = await prisma.staff.findMany({
    orderBy: { createdAt: "desc" },
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

export async function POST(req: NextRequest) {
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  if (!session || !can(role, "managesStaff")) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const body = await req.json();
  const { fullName, email, password, role: newRole } = body;

  if (!fullName || !email || !password || !newRole) {
    return NextResponse.json(
      { error: "fullName, email, password, and role are required" },
      { status: 400 }
    );
  }

  const existing = await prisma.staff.findUnique({ where: { email } });
  if (existing) {
    return NextResponse.json(
      { error: "A staff account with this email already exists" },
      { status: 409 }
    );
  }

  const passwordHash = await bcrypt.hash(password, 10);

  const staff = await prisma.staff.create({
    data: { fullName, email, passwordHash, role: newRole },
    select: {
      id: true,
      fullName: true,
      email: true,
      role: true,
      active: true,
      createdAt: true,
    },
  });

  return NextResponse.json({ staff }, { status: 201 });
}