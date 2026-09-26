import Link from "next/link";
import { redirect } from "next/navigation";
import { auth, signOut } from "@/lib/auth";
import { can } from "@/lib/permissions";
import { startOfDayEAT } from "@/lib/billing";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

const BASE_NAV_ITEMS = [
  { href: "/admin", label: "Dashboard" },
  { href: "/admin/patients", label: "Patients" },
  { href: "/admin/pharmacy", label: "Pharmacy" },
  { href: "/admin/billing", label: "Billing" },
  { href: "/admin/blood-bank", label: "Blood bank" },
  { href: "/admin/ambulance", label: "Ambulance" },
  { href: "/admin/inquiries", label: "Inquiries" },
  { href: "/admin/reports", label: "Reports" },
  { href: "/admin/beds", label: "Beds" },
  { href: "/admin/equipment", label: "Equipment" },
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
  // Only roles allowed to read inquiries see the link (and its "new" count).
  const canSeeInquiries = can(role, "viewsInquiries");
  const baseItems = BASE_NAV_ITEMS.filter(
    (i) => i.href !== "/admin/inquiries" || canSeeInquiries
  );
  const navItems =
    role === "ADMIN"
      ? [...baseItems, { href: "/admin/staff", label: "Staff" }]
      : baseItems;

  const [allDrugs, lowBlood, equipmentAlerts, newInquiries] = await Promise.all([
    prisma.drug.findMany(),
    prisma.bloodStock.findMany({ where: { unitsHeld: { lte: 2 } } }),
    // Equipment that is broken, being repaired, or past its service date.
    prisma.equipment.count({
      where: {
        status: { not: "DISPOSED" },
        OR: [
          { status: { in: ["UNDER_REPAIR", "OUT_OF_SERVICE"] } },
          { nextServiceDue: { lt: startOfDayEAT() } },
        ],
      },
    }),
    canSeeInquiries
      ? prisma.contactMessage.count({ where: { status: "NEW" } })
      : Promise.resolve(0),
  ]);
  const alertCount =
    allDrugs.filter((d) => d.stockQty <= d.reorderAt).length + lowBlood.length + equipmentAlerts;

  return (
    <div className="min-h-screen bg-[#F1EFE8]">
      <header className="bg-[#0B3D63]">
        <div className="flex items-center justify-between px-6 py-3">
          <nav className="flex items-center gap-4 text-sm">
            <span className="mr-2 font-serif text-sm font-semibold text-white">
              SPA Nursing Home
            </span>
            {navItems.map((item) => (
              <Link
                key={item.href}
                href={item.href}
                className="flex items-center gap-1 text-[#8FB8D9] hover:text-white"
              >
                {item.label}
                {item.href === "/admin/inquiries" && newInquiries > 0 && (
                  <span className="rounded-full bg-[#D85A30] px-1.5 py-0.5 text-xs font-medium text-white">
                    {newInquiries}
                  </span>
                )}
              </Link>
            ))}
            <Link
              href="/admin/alerts"
              className="flex items-center gap-1 text-[#8FB8D9] hover:text-white"
            >
              Alerts
              {alertCount > 0 && (
                <span className="rounded-full bg-[#D85A30] px-1.5 py-0.5 text-xs font-medium text-white">
                  {alertCount}
                </span>
              )}
            </Link>
          </nav>
          <form
            action={async () => {
              "use server";
              // redirect: false + a relative redirect keeps people on the address
              // they signed in on (AUTH_URL can otherwise point elsewhere).
              await signOut({ redirect: false });
              redirect("/admin/login");
            }}
          >
            <button
              type="submit"
              className="rounded-md border border-[#3B5A78] px-3 py-1.5 text-sm text-[#8FB8D9] hover:bg-white/5 hover:text-white"
            >
              Sign out
            </button>
          </form>
        </div>
      </header>
      {children}
    </div>
  );
}