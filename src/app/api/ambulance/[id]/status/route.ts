import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";

const prisma = new PrismaClient();

export async function PATCH(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const session = await auth();
  if (!session) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { id } = await params;
  const body = await req.json();
  const { status } = body;

  if (!status) {
    return NextResponse.json({ error: "status is required" }, { status: 400 });
  }

  const isFinal = status === "COMPLETED" || status === "CANCELLED";

  const trip = await prisma.ambulanceTrip.update({
    where: { id },
    data: {
      status,
      completedAt: isFinal ? new Date() : undefined,
    },
  });

  return NextResponse.json({ trip });
}