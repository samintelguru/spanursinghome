import { NextRequest, NextResponse } from "next/server";
import { PrismaClient, InquiryStatus } from "@prisma/client";
import { auth } from "@/lib/auth";
import { can } from "@/lib/permissions";

const prisma = new PrismaClient();

const STATUSES: InquiryStatus[] = ["NEW", "IN_PROGRESS", "RESOLVED"];

// PATCH /api/inquiries/[id]   body: { status?, internalNote? }
export async function PATCH(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  if (!session || !can(role, "viewsInquiries")) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
  const staffId = (session.user as { id?: string }).id ?? null;

  const { id } = await params;
  const body = await req.json().catch(() => ({}));

  const data: {
    status?: InquiryStatus;
    internalNote?: string | null;
    handledAt?: Date | null;
    handledById?: string | null;
  } = {};

  if (body.status !== undefined) {
    if (!(STATUSES as string[]).includes(body.status)) {
      return NextResponse.json({ error: "Invalid status" }, { status: 400 });
    }
    data.status = body.status;
    // Reopening clears who handled it; any other change records who did.
    data.handledAt = body.status === "NEW" ? null : new Date();
    data.handledById = body.status === "NEW" ? null : staffId;
  }

  if (body.internalNote !== undefined) {
    const note = typeof body.internalNote === "string" ? body.internalNote.trim() : "";
    if (note.length > 1000) {
      return NextResponse.json({ error: "Note is too long (max 1000 characters)" }, { status: 400 });
    }
    data.internalNote = note || null;
  }

  if (Object.keys(data).length === 0) {
    return NextResponse.json({ error: "Nothing to update" }, { status: 400 });
  }

  try {
    const inquiry = await prisma.contactMessage.update({
      where: { id },
      data,
      include: { handledBy: { select: { fullName: true } } },
    });
    return NextResponse.json({ inquiry });
  } catch {
    return NextResponse.json({ error: "Inquiry not found" }, { status: 404 });
  }
}

// DELETE /api/inquiries/[id] — administrators only (spam clean-up)
export async function DELETE(
  _req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const session = await auth();
  const role = (session?.user as { role?: string })?.role;
  if (!session || role !== "ADMIN") {
    return NextResponse.json({ error: "Only administrators can delete inquiries" }, { status: 401 });
  }

  const { id } = await params;
  try {
    await prisma.contactMessage.delete({ where: { id } });
    return NextResponse.json({ ok: true });
  } catch {
    return NextResponse.json({ error: "Inquiry not found" }, { status: 404 });
  }
}
