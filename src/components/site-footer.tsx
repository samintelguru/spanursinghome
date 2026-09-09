import Link from "next/link";

export default function SiteFooter() {
  return (
    <footer className="border-t border-[#E8E2D6] bg-[#F1EFE8]">
      <div className="mx-auto grid max-w-6xl gap-8 px-6 py-12 sm:grid-cols-3">
        <div>
          <p className="font-serif text-lg font-semibold text-[#0F6E56]">
            SPA Nursing Home
          </p>
          <p className="mt-2 text-sm text-[#5F5E5A]">
            Ruiru, Kiambu County, Kenya
          </p>
        </div>
        <div>
          <p className="mb-2 text-sm font-medium text-[#2C2C2A]">Reach us</p>
          <p className="text-sm text-[#5F5E5A]">Phone : 0706 155 600 | 0719 863 747 | 0772 711 869</p>
          <p className="text-sm text-[#5F5E5A]">Email : spahospitalruiruke@gmail.com</p>
          <p className="mt-1 text-sm text-[#5F5E5A]">Outpatient clinic: 24 hours</p>
        </div>
        <div>
          <p className="mb-2 text-sm font-medium text-[#2C2C2A]">Explore</p>
          <div className="flex flex-col gap-1 text-sm text-[#5F5E5A]">
            <Link href="/services" className="hover:text-[#0F6E56]">Services</Link>
            <Link href="/about" className="hover:text-[#0F6E56]">About us</Link>
            <Link href="/community" className="hover:text-[#0F6E56]">Community</Link>
          </div>
        </div>
      </div>
      <div className="border-t border-[#E8E2D6] px-6 py-4 text-center text-xs text-[#8A8880]">
        © {new Date().getFullYear()} SPA Nursing Home. All rights reserved.
      </div>
    </footer>
  );
}