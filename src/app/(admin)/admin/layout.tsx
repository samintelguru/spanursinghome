import AdminNav from "@/components/admin-nav";
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

  async function signOutAction() {
    "use server";
    // redirect: false + a relative redirect keeps people on the address
    // they signed in on (AUTH_URL can otherwise point elsewhere).
    await signOut({ redirect: false });
    redirect("/admin/login");
  }

  const navWithBadges = navItems.map((item) => ({
    ...item,
    badge: item.href === "/admin/inquiries" ? newInquiries : undefined,
  }));

  return (
    <div className="min-h-screen bg-[#F1EFE8]">
      <AdminNav navItems={navWithBadges} alertCount={alertCount} signOutAction={signOutAction} />
      {children}
    </div>
  );
}