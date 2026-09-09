import Link from "next/link";

export default function LabServicePage() {
  return (
    <main className="bg-[#F1EFE8] text-[#2C2C2A]">
      <section className="mx-auto max-w-3xl px-6 pb-20 pt-16 sm:pt-24">
        <Link href="/services" className="text-sm text-[#0B3D63 ] hover:underline">
          ← All services
        </Link>
        <p className="mt-6 mb-4 text-sm font-medium tracking-wide text-[#0B3D63 ]">
          LAB & IMAGING
        </p>
        <h1 className="font-serif text-4xl font-semibold leading-tight">
          Answers, usually same day
        </h1>
        <p className="mt-6 text-[#5F5E5A]">
          Our on-site lab and ultrasound service means most tests don't
          require a referral elsewhere — and most results are ready before
          you head home.
        </p>

        <div className="mt-12 grid gap-4 sm:grid-cols-2">
          {[
            "Ultrasound scans",
            "Blood & urine testing",
            "Malaria & typhoid testing",
            "Pregnancy testing",
          ].map((item) => (
            <div key={item} className="rounded-xl bg-white p-4 text-sm font-medium">
              {item}
            </div>
          ))}
        </div>

        <Link
          href="/contact"
          className="mt-10 inline-block rounded-full bg-[#0982e8] px-6 py-3 text-sm font-medium text-white hover:bg-[#0982e8]"
        >
          Book a lab test
        </Link>
      </section>
    </main>
  );
}