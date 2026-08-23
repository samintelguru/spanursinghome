import Link from "next/link";
import { auth, signOut } from "@/lib/auth";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

const BASE_NAV_ITEMS = [
  { href: "/admin", label: "Dashboard" },
  { href: "/admin/patients", label: "Patients" },
  { href: "/admin/pharmacy", label: "Pharmacy" },
  { href: "/admin/billing", label: "Billing" },
  { href: "/admin/blood-bank", label: "Blood bank" },
  { href: "/admin/ambulance", label: "Ambulance" },
];

export default async function AdminLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const session = await auth();

  if (!session) {
    return <>{children}</>;
  }

  const role = (session.user as { role?: string })?.role;
  const navItems =
    role === "ADMIN"
      ? [...BASE_NAV_ITEMS, { href: "/admin/staff", label: "Staff" }]
      : BASE_NAV_ITEMS;

  const [allDrugs, lowBlood] = await Promise.all([
    prisma.drug.findMany(),
    prisma.bloodStock.findMany({ where: { unitsHeld: { lte: 2 } } }),
  ]);
  const alertCount =
    allDrugs.filter((d) => d.stockQty <= d.reorderAt).length + lowBlood.length;

  return (
    <div className="min-h-screen bg-white">
      <header className="flex items-center justify-between border-b border-gray-200 px-6 py-3">
        <nav className="flex items-center gap-4 text-sm">
          {navItems.map((item) => (
            <Link
              key={item.href}
              href={item.href}
              className="text-gray-600 hover:text-black"
            >
              {item.label}
            </Link>
          ))}
          <Link
            href="/admin/alerts"
            className="flex items-center gap-1 text-gray-600 hover:text-black"
          >
            Alerts
            {alertCount > 0 && (
              <span className="rounded-full bg-red-600 px-1.5 py-0.5 text-xs font-medium text-white">
                {alertCount}
              </span>
            )}
          </Link>
        </nav>
        <form
          action={async () => {
            "use server";
            await signOut({ redirectTo: "/admin/login" });
          }}
        >
          <button
            type="submit"
            className="rounded-md border border-gray-300 px-3 py-1.5 text-sm"
          >
            Sign out
          </button>
        </form>
      </header>
      {children}
    </div>
  );
}