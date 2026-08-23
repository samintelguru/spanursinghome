export default function AboutPage() {
  return (
    <main className="bg-[#F1EFE8] text-[#2C2C2A]">
      <section className="mx-auto max-w-3xl px-6 pb-20 pt-16 sm:pt-24">
        <p className="mb-4 text-sm font-medium tracking-wide text-[#0F6E56]">
          ABOUT US
        </p>
        <h1 className="font-serif text-4xl font-semibold leading-tight">
          A neighbourhood clinic, grown up
        </h1>
        <p className="mt-6 text-[#5F5E5A]">
          SPA Nursing Home started as a small outpatient practice in Ruiru
          and has grown into a full-service facility offering maternity,
          diagnostic, and general outpatient care — without losing the
          personal attention that got us here.
        </p>

        <div className="mt-12 grid gap-8 sm:grid-cols-2">
          <div className="rounded-2xl bg-white p-6">
            <p className="font-serif text-lg font-semibold text-[#0F6E56]">
              Our mission
            </p>
            <p className="mt-2 text-sm text-[#5F5E5A]">
              To provide accessible, quality healthcare to our community,
              treating every patient with the dignity and attention we'd
              want for our own families.
            </p>
          </div>
          <div className="rounded-2xl bg-white p-6">
            <p className="font-serif text-lg font-semibold text-[#0F6E56]">
              Our vision
            </p>
            <p className="mt-2 text-sm text-[#5F5E5A]">
              To be the region's most trusted name in outpatient and
              maternity care — known for outcomes, not just proximity.
            </p>
          </div>
        </div>

        <div className="mt-16">
          <p className="mb-6 font-serif text-2xl font-semibold">Our team</p>
          <div className="aspect-[16/6] rounded-2xl border-2 border-dashed border-[#c9c1ac] bg-[#E8E2D6] p-6 text-center text-sm text-[#8A8880] flex items-center justify-center">
            Team photo or individual staff portraits go here
          </div>
        </div>
      </section>
    </main>
  );
}