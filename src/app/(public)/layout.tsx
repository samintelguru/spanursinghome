import { Fraunces, Work_Sans } from "next/font/google";
import SiteHeader from "@/components/site-header";
import SiteFooter from "@/components/site-footer";

const fraunces = Fraunces({
  subsets: ["latin"],
  variable: "--font-display",
  weight: ["500", "600"],
});

const workSans = Work_Sans({
  subsets: ["latin"],
  variable: "--font-body",
  weight: ["400", "500", "600"],
});

export default function PublicLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className={`${fraunces.variable} ${workSans.variable} font-sans`}>
      <style>{`
        .font-serif { font-family: var(--font-display), Georgia, serif; }
        .font-sans { font-family: var(--font-body), Arial, sans-serif; }
      `}</style>
      <SiteHeader />
      {children}
      <SiteFooter />
    </div>
  );
}