import Link from "next/link";

const NAV = [
  { href: "/about", label: "About" },
  { href: "/services", label: "Services" },
  { href: "/community", label: "Community" },
  { href: "/contact", label: "Contact" },
];

export default function SiteHeader() {
  return (
    <header className="sticky top-0 z-40 border-b border-[#E8E2D6] bg-[#F1EFE8]/90 backdrop-blur">
      <div className="mx-auto flex max-w-6xl items-center justify-between px-6 py-4">
        <Link href="/" className="font-serif text-lg font-semibold text-[#0F6E56]">
          SPA Nursing Home
        </Link>
        <nav className="hidden gap-8 text-sm text-[#2C2C2A] sm:flex">
          {NAV.map((item) => (
            <Link key={item.href} href={item.href} className="hover:text-[#0F6E56]">
              {item.label}
            </Link>
          ))}
        </nav>
        <Link
          href="/contact"
          className="rounded-full bg-[#D85A30] px-5 py-2 text-sm font-medium text-white hover:bg-[#c14f28]"
        >
          Book appointment
        </Link>
      </div>
    </header>
  );
}