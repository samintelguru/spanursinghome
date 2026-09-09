import Link from "next/link";

const SERVICES = [
  {
    href: "/services/inpatient",
    title: "Inpatient care",
    body: "Round-the-clock nursing, daily doctor's rounds, and a room to recover in — general, semi-private, or private.",
  },
  {
    href: "/services/maternity",
    title: "Maternity",
    body: "Ante-natal care, normal and caesarian delivery, and postnatal support for you and your baby.",
  },
  {
    href: "/services/lab",
    title: "Lab & imaging",
    body: "Ultrasound scans and a full range of diagnostic lab testing, with same-day results for most tests.",
  },
  {
    href: "/services/outpatient",
    title: "Outpatient clinic",
    body: "General consultation, family planning, and urgent care — open 24 hours, no appointment required.",
  },
];

export default function ServicesPage() {
  return (
    <main className="bg-[#F1EFE8] text-[#2C2C2A]">
      {/* Hero */}
      <section className="bg-[#0B3D63] text-[#F6F1E4]">
        <div className="mx-auto max-w-4xl px-6 pb-16 pt-16 sm:pt-24">
          <p className="mb-4 text-sm font-medium tracking-wide text-[#8FB8D9]">
            SERVICES
          </p>
          <h1 className="font-serif text-4xl font-semibold leading-tight">
            Care for every stage
          </h1>
          <p className="mt-6 max-w-xl text-[#C9D8E8]">
            From a full inpatient stay to a same-day lab test, our team provides the essential healthcare most 
            families need — close to home and available when it matters.
          </p>
        </div>
      </section>

      <section className="mx-auto max-w-4xl px-6 py-16">
        <div className="flex flex-col gap-4">
          {SERVICES.map((s) => (
            <Link
              key={s.href}
              href={s.href}
              className="flex items-center justify-between rounded-2xl bg-white p-6 transition hover:bg-[#faf8f3]"
            >
              <div>
                <p className="font-serif text-xl font-semibold">{s.title}</p>
                <p className="mt-1 text-sm text-[#5F5E5A]">{s.body}</p>
              </div>
              <span className="ml-6 shrink-0 text-sm font-medium text-[#0B3D63]">
                Learn more →
              </span>
            </Link>
          ))}
        </div>
      </section>
    </main>
  );
}