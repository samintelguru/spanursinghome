"use client";

import { useState } from "react";
import Link from "next/link";

type NavItem = { href: string; label: string; badge?: number };

// Header nav for the admin side. Desktop shows the full link row; on a phone
// it collapses to a hamburger menu so links never get squeezed or clipped.
export default function AdminNav({
  navItems,
  alertCount,
  signOutAction,
}: {
  navItems: NavItem[];
  alertCount: number;
  signOutAction: () => Promise<void>;
}) {
  const [open, setOpen] = useState(false);

  const allItems: NavItem[] = [
    ...navItems,
    { href: "/admin/alerts", label: "Alerts", badge: alertCount || undefined },
  ];
  const hasAnyBadge = allItems.some((i) => !!i.badge);

  return (
    <header className="bg-[#0B3D63]">
      <div className="flex items-center justify-between px-4 py-3 sm:px-6">
        <span className="font-serif text-sm font-semibold text-white">SPA Nursing Home</span>

        {/* Desktop nav — full row of links, unchanged from before */}
        <nav className="hidden items-center gap-4 text-sm lg:flex">
          {allItems.map((item) => (
            <Link
              key={item.href}
              href={item.href}
              className="flex items-center gap-1 text-[#8FB8D9] hover:text-white"
            >
              {item.label}
              {!!item.badge && (
                <span className="rounded-full bg-[#D85A30] px-1.5 py-0.5 text-xs font-medium text-white">
                  {item.badge}
                </span>
              )}
            </Link>
          ))}
        </nav>

        <div className="flex items-center gap-2">
          <form action={signOutAction} className="hidden lg:block">
            <button
              type="submit"
              className="rounded-md border border-[#3B5A78] px-3 py-1.5 text-sm text-[#8FB8D9] hover:bg-white/5 hover:text-white"
            >
              Sign out
            </button>
          </form>

          {/* Mobile menu toggle */}
          <button
            type="button"
            onClick={() => setOpen((o) => !o)}
            aria-expanded={open}
            aria-label={open ? "Close menu" : "Open menu"}
            className="relative flex h-10 w-10 items-center justify-center rounded-md text-white hover:bg-white/10 lg:hidden"
          >
            {open ? (
              <svg viewBox="0 0 24 24" className="h-6 w-6" fill="none" stroke="currentColor" strokeWidth="2">
                <path strokeLinecap="round" d="M6 6l12 12M18 6L6 18" />
              </svg>
            ) : (
              <>
                <svg viewBox="0 0 24 24" className="h-6 w-6" fill="none" stroke="currentColor" strokeWidth="2">
                  <path strokeLinecap="round" d="M4 7h16M4 12h16M4 17h16" />
                </svg>
                {hasAnyBadge && (
                  <span className="absolute right-1.5 top-1.5 h-2 w-2 rounded-full bg-[#D85A30]" />
                )}
              </>
            )}
          </button>
        </div>
      </div>

      {/* Mobile menu panel */}
      {open && (
        <nav className="flex flex-col gap-0.5 border-t border-[#1B4F79] px-2 pb-3 pt-2 lg:hidden">
          {allItems.map((item) => (
            <Link
              key={item.href}
              href={item.href}
              onClick={() => setOpen(false)}
              className="flex items-center justify-between rounded-md px-3 py-2.5 text-sm text-[#8FB8D9] hover:bg-white/5 hover:text-white"
            >
              <span>{item.label}</span>
              {!!item.badge && (
                <span className="rounded-full bg-[#D85A30] px-1.5 py-0.5 text-xs font-medium text-white">
                  {item.badge}
                </span>
              )}
            </Link>
          ))}
          <form action={signOutAction} className="mt-1 border-t border-[#1B4F79] pt-2">
            <button
              type="submit"
              className="w-full rounded-md px-3 py-2.5 text-left text-sm text-[#8FB8D9] hover:bg-white/5 hover:text-white"
            >
              Sign out
            </button>
          </form>
        </nav>
      )}
    </header>
  );
}
