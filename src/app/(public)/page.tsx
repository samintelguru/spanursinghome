export default function HomePage() {
  return (
    <main className="min-h-screen bg-[#F1EFE8] text-[#2C2C2A]">
      <section className="mx-auto max-w-5xl px-6 py-24 text-center">
        <p className="mb-3 text-sm font-medium tracking-wide text-[#0F6E56]">
          SPA NURSING HOME
        </p>
        <h1 className="text-4xl font-medium leading-tight">
          Compassionate care, close to home
        </h1>
        <p className="mx-auto mt-4 max-w-xl text-[#5F5E5A]">
          Outpatient, maternity, and diagnostic services in Ruiru, Kiambu
          County — trusted by our community since 1995.
        </p>
        <a
          href="/contact"
          className="mt-8 inline-block rounded-lg bg-[#D85A30] px-6 py-3 text-sm font-medium text-white"
        >
          Book an appointment
        </a>
      </section>
    </main>
  );
}
