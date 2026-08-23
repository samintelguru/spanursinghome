import Link from "next/link";

export default function HomePage() {
  return (
    <main className="bg-[#F1EFE8] text-[#2C2C2A]">
      <section className="mx-auto max-w-6xl px-6 pb-20 pt-16 sm:pt-24">
        <div className="grid gap-12 sm:grid-cols-2 sm:items-center">
          <div>
            <p className="mb-4 text-sm font-medium tracking-wide text-[#0F6E56]">
              RUIRU, KIAMBU COUNTY
            </p>
            <h1 className="font-serif text-4xl font-semibold leading-tight sm:text-5xl">
              Care that knows your name
            </h1>
            <p className="mt-5 max-w-md text-[#5F5E5A]">
              Outpatient, maternity, and diagnostic services from a team our
              community has trusted for years. Walk in any time — our
              outpatient clinic never closes.
            </p>
            <div className="mt-8 flex flex-wrap gap-3">
              <Link
                href="/contact"
                className="rounded-full bg-[#D85A30] px-6 py-3 text-sm font-medium text-white hover:bg-[#c14f28]"
              >
                Book an appointment
              </Link>
              <Link
                href="/services"
                className="rounded-full border border-[#0F6E56] px-6 py-3 text-sm font-medium text-[#0F6E56] hover:bg-[#0F6E56]/5"
              >
                See our services
              </Link>
            </div>
          </div>
          <div className="aspect-[4/3] rounded-2xl bg-[#E8E2D6] p-6">
            <div className="flex h-full w-full items-center justify-center rounded-xl border-2 border-dashed border-[#c9c1ac] text-center text-sm text-[#8A8880]">
              Photo of the facility exterior or reception —
              <br />
              replace with real photography
            </div>
          </div>
        </div>
      </section>

      <section className="border-y border-[#E8E2D6] bg-white py-16">
        <div className="mx-auto max-w-6xl px-6">
          <p className="mb-10 text-center font-serif text-2xl font-semibold">
            What a visit looks like
          </p>
          <div className="grid gap-8 sm:grid-cols-3">
            {[
              {
                step: "01",
                title: "Walk in, any hour",
                body: "Our outpatient clinic runs 24 hours. No appointment needed for urgent concerns.",
              },
              {
                step: "02",
                title: "See a doctor or nurse",
                body: "A clinician assesses you, orders any lab work or imaging needed, right on site.",
              },
              {
                step: "03",
                title: "Leave with what you need",
                body: "Prescriptions filled at our pharmacy before you leave — no separate trip required.",
              },
            ].map((item) => (
              <div key={item.step}>
                <p className="font-serif text-3xl font-semibold text-[#D85A30]">
                  {item.step}
                </p>
                <p className="mt-2 font-medium">{item.title}</p>
                <p className="mt-1 text-sm text-[#5F5E5A]">{item.body}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      <section className="mx-auto max-w-6xl px-6 py-20">
        <p className="mb-10 font-serif text-2xl font-semibold">Our services</p>
        <div className="grid gap-6 sm:grid-cols-3">
          {[
            {
              href: "/services/maternity",
              title: "Maternity",
              body: "Ante-natal care through normal and caesarian delivery.",
              icon: (
                <path d="M12 21s-7-4.5-7-10a5 5 0 0110-1 5 5 0 0110 1c0 5.5-7 10-7 10z" />
              ),
            },
            {
              href: "/services/lab",
              title: "Lab & imaging",
              body: "Ultrasound and diagnostic testing, results same day.",
              icon: (
                <>
                  <path d="M9 3h6M10 3v6l-5 9a2 2 0 001.8 3h10.4a2 2 0 001.8-3l-5-9V3" />
                </>
              ),
            },
            {
              href: "/services/outpatient",
              title: "Outpatient clinic",
              body: "General consultation, family planning, 24-hour access.",
              icon: (
                <>
                  <circle cx="12" cy="12" r="9" />
                  <path d="M12 7v5l3 3" />
                </>
              ),
            },
          ].map((s) => (
            <Link
              key={s.href}
              href={s.href}
              className="group rounded-2xl bg-[#E8E2D6] p-6 transition duration-200 hover:-translate-y-1 hover:bg-[#dfd7c4] hover:shadow-md"
            >
              <div className="mb-4 flex h-10 w-10 items-center justify-center rounded-full bg-white text-[#0F6E56]">
                <svg
                  width="20"
                  height="20"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="1.6"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                >
                  {s.icon}
                </svg>
              </div>
              <p className="font-serif text-lg font-semibold">{s.title}</p>
              <p className="mt-2 text-sm text-[#5F5E5A]">{s.body}</p>
              <p className="mt-4 text-sm font-medium text-[#0F6E56]">
                Learn more{" "}
                <span className="inline-block transition group-hover:translate-x-0.5">
                  →
                </span>
              </p>
            </Link>
          ))}
        </div>
      </section>

      {/* Trust strip — facts we can actually stand behind */}
      <section className="border-y border-[#E8E2D6] bg-[#E8E2D6]/60">
        <div className="mx-auto grid max-w-6xl gap-8 px-6 py-12 sm:grid-cols-3">
          {[
            {
              title: "24-hour outpatient care",
              body: "Our clinic doesn't close — walk in any hour of the day or night.",
            },
            {
              title: "Everything under one roof",
              body: "Consultation, lab, ultrasound, and pharmacy on the same visit.",
            },
            {
              title: "A team that knows you",
              body: "Qualified doctors, nurses, and midwives who treat you like family.",
            },
          ].map((item) => (
            <div key={item.title}>
              <p className="font-serif text-lg font-semibold text-[#0F6E56]">
                {item.title}
              </p>
              <p className="mt-1 text-sm text-[#5F5E5A]">{item.body}</p>
            </div>
          ))}
        </div>
      </section>

      {/* Testimonials — placeholders only; replace with real, consented patient quotes */}
      <section className="mx-auto max-w-6xl px-6 py-20">
        <p className="mb-10 font-serif text-2xl font-semibold">
          What our patients say
        </p>
        <div className="grid gap-6 sm:grid-cols-3">
          {[1, 2, 3].map((i) => (
            <div
              key={i}
              className="rounded-2xl border-2 border-dashed border-[#c9c1ac] bg-white p-6"
            >
              <p className="text-sm italic text-[#8A8880]">
                "Replace with a real quote from a patient who has given
                permission to be featured — including their first name."
              </p>
              <p className="mt-4 text-xs font-medium text-[#8A8880]">
                — Patient name, service used
              </p>
            </div>
          ))}
        </div>
      </section>

      <section className="bg-[#0F6E56] py-16 text-center text-white">
        <p className="font-serif text-2xl font-semibold">
          Need to see someone today?
        </p>
        <p className="mt-2 text-white/80">
          Call us or walk in — our outpatient clinic is open around the clock.
        </p>
        <Link
          href="/contact"
          className="mt-6 inline-block rounded-full bg-[#D85A30] px-6 py-3 text-sm font-medium text-white hover:bg-[#c14f28]"
        >
          Get in touch
        </Link>
      </section>
    </main>
  );
}