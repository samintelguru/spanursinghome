import Link from "next/link";

export default function MaternityServicePage() {
  return (
    <main className="bg-[#F1EFE8] text-[#2C2C2A]">
      <section className="bg-[#0B3D63] text-[#F6F1E4]">
        <div className="mx-auto max-w-3xl px-6 pb-16 pt-16 sm:pt-24">
          <Link href="/services" className="text-sm text-[#8FB8D9] hover:underline">
            ← All services
          </Link>
          <p className="mt-6 mb-4 text-sm font-medium tracking-wide text-[#8FB8D9]">
            MATERNITY
          </p>
          <h1 className="font-serif text-4xl font-semibold leading-tight">
            Support from bump to baby
          </h1>
          <p className="mt-6 max-w-xl text-[#C9D8E8]">
            Our maternity team walks with you through every stage of pregnancy
            — ante-natal check-ups, delivery, and the weeks after — so you're
            never navigating it alone.
          </p>
        </div>
      </section>

      <section className="mx-auto max-w-3xl px-6 py-16">
        <div className="grid gap-4 sm:grid-cols-2">
          {[
            "Ante-natal care & monitoring",
            "Normal delivery",
            "Caesarian section",
            "Postnatal care & newborn checks",
          ].map((item) => (
            <div key={item} className="rounded-xl bg-white p-4 text-sm font-medium">
              {item}
            </div>
          ))}
        </div>

        <Link
          href="/contact"
          className="mt-10 inline-block rounded-full bg-[#0982e8] px-6 py-3 text-sm font-medium text-white hover:bg-[#0a70c4]"
        >
          Book a maternity consultation
        </Link>
      </section>
    </main>
  );
}