import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { auth } from "@/lib/auth";

const prisma = new PrismaClient();

export async function GET() {
  const session = await auth();
  if (!session) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const trips = await prisma.ambulanceTrip.findMany({
    orderBy: { dispatchedAt: "desc" },
    include: { patient: true },
  });

  return NextResponse.json({ trips });
}

export async function POST(req: NextRequest) {
  const session = await auth();
  if (!session) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
  const staffId = (session.user as { id?: string })?.id;

  const body = await req.json();
  const { patientId, pickupLocation, destination } = body;

  if (!pickupLocation || !destination || !staffId) {
    return NextResponse.json(
      { error: "pickupLocation and destination are required" },
      { status: 400 }
    );
  }

  const trip = await prisma.ambulanceTrip.create({
    data: {
      patientId: patientId || null,
      pickupLocation,
      destination,
      staffId,
    },
  });

  return NextResponse.json({ trip }, { status: 201 });
}