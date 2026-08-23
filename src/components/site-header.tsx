"use client";

import { useState } from "react";
import Link from "next/link";

const NAV = [
  { href: "/about", label: "About" },
  { href: "/services", label: "Services" },
  { href: "/community", label: "Community" },
  { href: "/contact", label: "Contact" },
];

export default function SiteHeader() {
  const [open, setOpen] = useState(false);

  return (
    <header className="sticky top-0 z-40 border-b border-[#E8E2D6] bg-[#F1EFE8]/90 backdrop-blur">
      <div className="mx-auto flex max-w-6xl items-center justify-between px-6 py-4">
        <Link
          href="/"
          className="font-serif text-lg font-semibold text-[#0F6E56]"
          onClick={() => setOpen(false)}
        >
          SPA Nursing Home
        </Link>

        <nav className="hidden gap-8 text-sm text-[#2C2C2A] sm:flex">
          {NAV.map((item) => (
            <Link
              key={item.href}
              href={item.href}
              className="rounded-sm hover:text-[#0F6E56] focus-visible:outline-2 focus-visible:outline-offset-4 focus-visible:outline-[#0F6E56]"
            >
              {item.label}
            </Link>
          ))}
        </nav>

        <div className="flex items-center gap-3">
          <Link
            href="/contact"
            className="hidden rounded-full bg-[#D85A30] px-5 py-2 text-sm font-medium text-white hover:bg-[#c14f28] sm:inline-block"
          >
            Book appointment
          </Link>

          <button
            aria-label={open ? "Close menu" : "Open menu"}
            aria-expanded={open}
            onClick={() => setOpen(!open)}
            className="flex h-9 w-9 items-center justify-center rounded-md text-[#2C2C2A] sm:hidden"
          >
            {open ? (
              <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                <path d="M4 4l12 12M16 4L4 16" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round" />
              </svg>
            ) : (
              <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                <path d="M3 5h14M3 10h14M3 15h14" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round" />
              </svg>
            )}
          </button>
        </div>
      </div>

      {open && (
        <nav className="flex flex-col gap-1 border-t border-[#E8E2D6] bg-[#F1EFE8] px-6 py-4 sm:hidden">
          {NAV.map((item) => (
            <Link
              key={item.href}
              href={item.href}
              onClick={() => setOpen(false)}
              className="rounded-md px-2 py-2.5 text-sm text-[#2C2C2A] hover:bg-white"
            >
              {item.label}
            </Link>
          ))}
          <Link
            href="/contact"
            onClick={() => setOpen(false)}
            className="mt-2 rounded-full bg-[#D85A30] px-5 py-2.5 text-center text-sm font-medium text-white"
          >
            Book appointment
          </Link>
        </nav>
      )}
    </header>
  );
}