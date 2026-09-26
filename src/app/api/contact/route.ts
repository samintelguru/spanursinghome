import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

// Public endpoint behind the Contact page form — no login, so it defends itself:
//  - "website" is a hidden honeypot field; real visitors never fill it, bots do
//  - the same phone can send at most 3 messages an hour
//  - the whole form accepts at most 60 messages an hour (flood guard)
//  - an identical repeat (double-click / refresh) is quietly accepted, not saved twice
const HOUR = 60 * 60 * 1000;

const clean = (v: unknown, max: number) =>
  typeof v === "string"
    ? v.replace(/[\u0000-\u0008\u000B\u000C\u000E-\u001F]/g, "").trim().slice(0, max)
    : "";

export async function POST(req: NextRequest) {
  try {
    const body = await req.json().catch(() => null);
    if (!body || typeof body !== "object") {
      return NextResponse.json({ error: "Invalid request" }, { status: 400 });
    }

    // Bots fill the hidden field. Pretend it worked and drop it.
    if (clean(body.website, 200)) return NextResponse.json({ ok: true });

    const fullName = clean(body.fullName, 100);
    const phone = clean(body.phone, 20);
    const message = clean(body.message, 2000);

    if (fullName.length < 2) {
      return NextResponse.json({ error: "Please enter your name" }, { status: 400 });
    }
    const digits = phone.replace(/\D/g, "");
    if (!/^[0-9+()\s-]+$/.test(phone) || digits.length < 7 || digits.length > 15) {
      return NextResponse.json({ error: "Please enter a valid phone number" }, { status: 400 });
    }
    if (message.length < 5) {
      return NextResponse.json({ error: "Please write a short message" }, { status: 400 });
    }

    const since = new Date(Date.now() - HOUR);
    const [fromThisPhone, fromEveryone, repeat] = await Promise.all([
      prisma.contactMessage.count({ where: { phone, createdAt: { gte: since } } }),
      prisma.contactMessage.count({ where: { createdAt: { gte: since } } }),
      prisma.contactMessage.findFirst({
        where: { phone, message, createdAt: { gte: new Date(Date.now() - 24 * HOUR) } },
        select: { id: true },
      }),
    ]);

    if (repeat) return NextResponse.json({ ok: true });
    if (fromThisPhone >= 3 || fromEveryone >= 60) {
      return NextResponse.json(
        { error: "Too many messages just now. Please call us on 0706 155 600 instead." },
        { status: 429 }
      );
    }

    await prisma.contactMessage.create({ data: { fullName, phone, message } });
    return NextResponse.json({ ok: true }, { status: 201 });
  } catch (err) {
    console.error("POST /api/contact failed:", err);
    return NextResponse.json({ error: "Something went wrong" }, { status: 500 });
  }
}
