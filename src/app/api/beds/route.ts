import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";

const prisma = new PrismaClient() as any;

export async function GET() {
  try {
    const session = await auth();
    if (!session) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const beds = await prisma.bed.findMany({
      include: { patient: { select: { fullName: true, fileNumber: true } } },
      orderBy: [{ ward: "asc" }, { label: "asc" }],
    });

    return NextResponse.json({ beds });
  } catch (err) {
    console.error("GET /api/beds failed:", err);
    return NextResponse.json({ error: "Something went wrong loading beds" }, { status: 500 });
  }
}

export async function POST(req: NextRequest) {
  try {
    const session = await auth();
    const role = (session?.user as { role?: string })?.role;
    if (!session || !can(role, "managesBeds")) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const body = await req.json();
    const { label, ward } = body;

    if (!label || !ward) {
      return NextResponse.json(
        { error: "label and ward are required" },
        { status: 400 }
      );
    }

    const bed = await prisma.bed.create({ data: { label, ward } });
    return NextResponse.json({ bed }, { status: 201 });
  } catch (err) {
    console.error("POST /api/beds failed:", err);
    return NextResponse.json({ error: "Something went wrong creating the bed" }, { status: 500 });
  }
}