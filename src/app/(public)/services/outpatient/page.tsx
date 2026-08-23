import Link from "next/link";

export default function OutpatientServicePage() {
  return (
    <main className="bg-[#F1EFE8] text-[#2C2C2A]">
      <section className="mx-auto max-w-3xl px-6 pb-20 pt-16 sm:pt-24">
        <Link href="/services" className="text-sm text-[#0F6E56] hover:underline">
          ← All services
        </Link>
        <p className="mt-6 mb-4 text-sm font-medium tracking-wide text-[#0F6E56]">
          OUTPATIENT CLINIC
        </p>
        <h1 className="font-serif text-4xl font-semibold leading-tight">
          Open when you need us
        </h1>
        <p className="mt-6 text-[#5F5E5A]">
          Our outpatient clinic runs around the clock. Walk in for a general
          consultation, family planning advice, or an urgent concern — no
          appointment required.
        </p>

        <div className="mt-12 grid gap-4 sm:grid-cols-2">
          {[
            "General consultation",
            "Family planning",
            "Minor injury & wound care",
            "24-hour urgent care",
          ].map((item) => (
            <div key={item} className="rounded-xl bg-white p-4 text-sm font-medium">
              {item}
            </div>
          ))}
        </div>

        <Link
          href="/contact"
          className="mt-10 inline-block rounded-full bg-[#D85A30] px-6 py-3 text-sm font-medium text-white hover:bg-[#c14f28]"
        >
          Get directions & contact
        </Link>
      </section>
    </main>
  );
}