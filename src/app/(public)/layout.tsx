import { Fraunces, Work_Sans } from "next/font/google";
import Script from "next/script";
import SiteHeader from "@/components/site-header";
import SiteFooter from "@/components/site-footer";
import WhatsAppButton from "@/components/whatsapp-button";

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
      <WhatsAppButton />
      {/*
        Umami analytics — public site only (never loaded under /admin).
        Cookie-free: it counts visits without tracking individuals, so it
        needs no cookie-consent banner. No-ops if the env var isn't set,
        so local dev and preview deploys work without signing up.
        Set NEXT_PUBLIC_UMAMI_WEBSITE_ID in Vercel to turn it on.
      */}
      {process.env.NEXT_PUBLIC_UMAMI_WEBSITE_ID && (
        <Script
          src="https://cloud.umami.is/script.js"
          data-website-id={process.env.NEXT_PUBLIC_UMAMI_WEBSITE_ID}
          strategy="afterInteractive"
        />
      )}
    </div>
  );
}