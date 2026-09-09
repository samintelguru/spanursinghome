import Link from "next/link";
import PhotoCarousel from "@/components/photo-carousel";

export default function HomePage() {
  return (
    <main className="bg-[#F1EFE8] text-[#2C2C2A]">
      {/* Hero — text + carousel side by side, same position/size as before */}
      <section className="bg-[#0B2420] text-[#F6F1E4]">
        <div className="mx-auto max-w-6xl px-6 pb-12 pt-16 sm:pt-24">
          <div className="grid gap-12 sm:grid-cols-2 sm:items-center">
            <div>
              <p className="mb-4 text-sm font-medium tracking-wide text-[#8FBBA9]">
                INPATIENT CARE · RUIRU, KIAMBU COUNTY
              </p>
              <h1 className="font-serif text-4xl font-semibold leading-tight sm:text-5xl">
                Someone is always here for you
              </h1>
              <p className="mt-5 max-w-md text-[#C9D8CE]">
                Admission through discharge, a nurse is at your bedside and a
                doctor is a call away — day shift, night shift, every shift.
              </p>
              <div className="mt-8 flex flex-wrap gap-3">
                <Link
                  href="/contact"
                  className="rounded-full bg-[#0982e8] px-6 py-3 text-sm font-medium text-white hover:bg-[#0982e8]"
                >
                  Plan an admission
                </Link>
                <Link
                  href="/services/inpatient"
                  className="rounded-full border border-[#3F5A52] px-6 py-3 text-sm font-medium text-[#F6F1E4] hover:bg-white/5"
                >
                  See ward options
                </Link>
              </div>
            </div>

            <PhotoCarousel
              slides={[
                { src: "/images/carousel/photo1.jpeg", alt: "SPA Nursing Home reception" },
                { src: "/images/carousel/photo2.jpeg", alt: "SPA Nursing Home facility" },
                { src: "/images/carousel/photo3.jpeg", alt: "SPA Nursing Home ward" },
                { src: "/images/carousel/photo4.jpeg", alt: "SPA Nursing Home facility" },
                { src: "/images/carousel/photo5.jpeg", alt: "SPA Nursing Home facility" },
                { src: "/images/carousel/photo6.jpeg", alt: "SPA Nursing Home facility" },
                { src: "/images/carousel/photo7.jpeg", alt: "SPA Nursing Home facility" },
                { src: "/images/carousel/photo8.jpeg", alt: "SPA Nursing Home facility" },
                { src: "/images/carousel/photo9.jpg", alt: "SPA Nursing Home facility" },
                { src: "/images/carousel/photo10.jpg", alt: "SPA Nursing Home facility" },
                { src: "/images/carousel/photo11.jpeg", alt: "SPA Nursing Home facility" },
                { src: "/images/carousel/photo12.jpeg", alt: "SPA Nursing Home facility" },
                { src: "/images/carousel/photo13.jpeg", alt: "SPA Nursing Home facility" },
              ]}
            />
          </div>

          {/* Nursing coverage stat bar — kept small, doesn't compete with the carousel */}
          <div className="mt-14 flex flex-col gap-4 border-t border-[#244339] pt-6 sm:flex-row sm:items-center sm:justify-between">
            <div>
              <span className="font-serif text-2xl font-semibold">24 / 7</span>
              <span className="ml-3 text-sm text-[#C9D8CE]">
                nursing coverage — every hour of your stay is a staffed hour.
              </span>
            </div>
            <div className="flex gap-1.5 sm:w-48">
              {Array.from({ length: 8 }).map((_, i) => (
                <div key={i} className="h-1 flex-1 rounded-full bg-[#E8A33D]" />
              ))}
            </div>
          </div>
        </div>
      </section>

      {/* What a stay looks like — genuine sequence, not a generic card grid */}
      <section className="border-b border-[#E8E2D6] bg-white py-16">
        <div className="mx-auto max-w-6xl px-6">
          <p className="mb-10 font-serif text-2xl font-semibold">
            What a stay looks like
          </p>
          <div className="relative grid gap-8 sm:grid-cols-4">
            <div className="pointer-events-none absolute top-[11px] left-0 right-0 hidden h-px bg-[#E8E2D6] sm:block" />
            {[
              {
                n: "1",
                title: "Admission",
                body: "Room assigned by need — general, semi-private, or private.",
              },
              {
                n: "2",
                title: "Doctor's rounds",
                body: "Daily rounds, plus specialists brought in as your case needs.",
              },
              {
                n: "3",
                title: "Family visits",
                body: "Set visiting windows so you can rest, and your people can still reach you.",
              },
              {
                n: "4",
                title: "Discharge",
                body: "A clear plan home, with any follow-up booked before you leave.",
              },
            ].map((s) => (
              <div key={s.n} className="relative">
                <div className="relative z-10 flex h-6 w-6 items-center justify-center rounded-full bg-[#0F6E56] text-xs font-medium text-white">
                  {s.n}
                </div>
                <p className="mt-4 font-medium">{s.title}</p>
                <p className="mt-1 text-sm text-[#5F5E5A]">{s.body}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Room options — plain list, not icon cards */}
      <section className="border-y border-[#E8E2D6] bg-[#EDE6D3]/60 py-20">
        <div className="mx-auto max-w-3xl px-6">
          <p className="mb-10 font-serif text-2xl font-semibold">
            Room options
          </p>
          <div className="flex flex-col">
            {[
              {
                name: "General ward",
                body: "Shared, closely monitored, most affordable.",
                tag: "Most common",
              },
              {
                name: "Semi-private",
                body: "Two beds, more quiet, a bit more space.",
                tag: "",
              },
              {
                name: "Private room",
                body: "Own room, space for family to stay close.",
                tag: "",
              },
            ].map((r, i) => (
              <div
                key={r.name}
                className={`flex items-baseline justify-between gap-6 py-5 ${
                  i === 0 ? "border-t" : ""
                } border-b border-[#c9c1ac]`}
              >
                <div>
                  <p className="font-medium">{r.name}</p>
                  <p className="mt-1 text-sm text-[#5F5E5A]">{r.body}</p>
                </div>
                {r.tag && (
                  <p className="shrink-0 text-sm font-medium text-[#0982e8]">
                    {r.tag}
                  </p>
                )}
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Other services — inpatient leads, rest follow */}
      <section className="mx-auto max-w-6xl px-6 py-20">
        <p className="mb-10 font-serif text-2xl font-semibold">Our services</p>
        <div className="grid gap-6 sm:grid-cols-4">
          {[
            {
              href: "/services/inpatient",
              title: "Inpatient care",
              body: "Round-the-clock nursing, doctor's rounds, and a room to recover in.",
              icon: (
                <>
                  <rect x="4" y="10" width="16" height="8" rx="1.5" />
                  <path d="M4 14h16M8 10V7a2 2 0 012-2h4a2 2 0 012 2v3" />
                </>
              ),
            },
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

      {/* Family quote — placeholder, replace with a real consented quote */}
      <section className="bg-[#EDE6D3]/60 py-20">
        <div className="mx-auto max-w-2xl px-6 text-center">
          <p className="font-serif text-2xl italic leading-snug text-[#3B2E22] sm:text-[26px]">
            "The nurses checked on my mother throughout the night. We felt she was truly cared for.” — Grace, daughter of a patient."
          </p>
          <p className="mt-5 text-sm font-medium text-[#8A8880]">
            — Family member, service used
          </p>
        </div>
      </section>

      {/* Find us — small map, links through to full contact page */}
      <section className="border-t border-[#E8E2D6] bg-white py-16">
        <div className="mx-auto max-w-6xl px-6">
          <div className="grid gap-8 sm:grid-cols-2 sm:items-center">
            <div>
              <p className="mb-3 font-serif text-2xl font-semibold">Find us</p>
              <p className="text-sm text-[#5F5E5A]">
                Off Kimbo-Matangi Road, Ruiru — 800m off the Thika
                superhighway, behind Kenyatta University's Ruiru campus.
              </p>
              <Link
                href="/contact"
                className="mt-4 inline-block text-sm font-medium text-[#0F6E56] hover:underline"
              >
                Get directions →
              </Link>
            </div>
            <div className="overflow-hidden rounded-2xl border border-[#E8E2D6]">
              <iframe
                title="SPA Nursing Home location"
                src="https://www.google.com/maps?q=-1.142362959690373, 36.98232017190173&z=15&output=embed"
                width="100%"
                height="220"
                style={{ border: 0 }}
                loading="lazy"
                referrerPolicy="no-referrer-when-downgrade"
              />
            </div>
          </div>
        </div>
      </section>

      <section className="bg-[#0F6E56] py-16 text-center text-white">
        <p className="font-serif text-2xl font-semibold">
          Need to arrange an admission?
        </p>
        <p className="mt-2 text-white/80">
          Call us or walk in — our team will help you find the right room.
        </p>
        <Link
          href="/contact"
          className="mt-6 inline-block rounded-full bg-[#0982e8] px-6 py-3 text-sm font-medium text-white hover:bg-[#0982e8]"
        >
          Get in touch
        </Link>
      </section>
    </main>
  );
}