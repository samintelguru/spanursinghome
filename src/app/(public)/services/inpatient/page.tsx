import Link from "next/link";

export default function InpatientServicePage() {
  return (
    <main className="bg-[#F1EFE8] text-[#2C2C2A]">
      <section className="bg-[#0B2420] text-[#F6F1E4]">
        <div className="mx-auto max-w-3xl px-6 pb-20 pt-16 sm:pt-24">
          <Link href="/services" className="text-sm text-[#8FBBA9] hover:underline">
            ← All services
          </Link>
          <p className="mt-6 mb-4 text-sm font-medium tracking-wide text-[#8FBBA9]">
            INPATIENT CARE
          </p>
          <h1 className="font-serif text-4xl font-semibold leading-tight">
            A room, a nurse, and a plan for getting you home
          </h1>
          <p className="mt-6 max-w-xl text-[#C9D8CE]">
            When a condition needs more than a same-day visit, our inpatient
            wards give you round-the-clock nursing, daily doctor's rounds,
            and a clear plan for recovery — with your family able to visit
            and stay close.
          </p>
          <Link
            href="/contact"
            className="mt-10 inline-block rounded-full bg-[#D85A30] px-6 py-3 text-sm font-medium text-white hover:bg-[#c14f28]"
          >
            Plan an admission
          </Link>
        </div>
      </section>

      {/* Stay timeline */}
      <section className="border-b border-[#E8E2D6] bg-white py-16">
        <div className="mx-auto max-w-3xl px-6">
          <p className="mb-10 font-serif text-2xl font-semibold">
            What a stay looks like
          </p>
          <div className="flex flex-col gap-8">
            {[
              {
                n: "1",
                title: "Admission",
                body: "You're assessed and assigned a room based on your care needs — general, semi-private, or private.",
              },
              {
                n: "2",
                title: "Nursing care",
                body: "A nurse checks on you throughout your stay, day and night, and escalates to a doctor if anything changes.",
              },
              {
                n: "3",
                title: "Doctor's rounds",
                body: "Your case is reviewed on daily rounds, with specialists brought in when your condition calls for it.",
              },
              {
                n: "4",
                title: "Family visits",
                body: "Set visiting windows so you get real rest, while your family can still reach and see you.",
              },
              {
                n: "5",
                title: "Discharge",
                body: "You leave with a clear plan — medication, care instructions, and any follow-up already booked.",
              },
            ].map((s) => (
              <div key={s.n} className="flex gap-5">
                <div className="flex h-7 w-7 shrink-0 items-center justify-center rounded-full bg-[#0F6E56] text-xs font-medium text-white">
                  {s.n}
                </div>
                <div>
                  <p className="font-medium">{s.title}</p>
                  <p className="mt-1 text-sm text-[#5F5E5A]">{s.body}</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Room options */}
      <section className="bg-[#EDE6D3]/60 py-16">
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
                  <p className="shrink-0 text-sm font-medium text-[#D85A30]">
                    {r.tag}
                  </p>
                )}
              </div>
            ))}
          </div>
          <p className="mt-6 text-xs text-[#8A8880]">
            Exact rates depend on room type and length of stay — insurance,
            M-Pesa, and cash accepted. Ask our team for current pricing.
          </p>
        </div>
      </section>

      {/* Amenities + visiting */}
      <section className="py-16">
        <div className="mx-auto max-w-3xl px-6">
          <p className="mb-10 font-serif text-2xl font-semibold">
            While you're with us
          </p>
          <div className="grid gap-4 sm:grid-cols-2">
            {[
              "Meals included with your stay",
              "Nursing staff on every shift",
              "Set visiting hours for family",
              "Pharmacy on site for prescriptions",
              "Lab and imaging without leaving the ward",
              "Discharge planning before you go home",
            ].map((item) => (
              <div
                key={item}
                className="rounded-xl bg-white p-4 text-sm font-medium"
              >
                {item}
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Family quote — placeholder, replace with a real consented quote */}
      <section className="bg-[#EDE6D3]/60 py-16">
        <div className="mx-auto max-w-2xl px-6 text-center">
          <p className="font-serif text-xl italic leading-snug text-[#3B2E22]">
            "Replace with a real quote from a patient or family member who
            has given permission to be featured — including their first
            name."
          </p>
          <p className="mt-5 text-sm font-medium text-[#8A8880]">
            — Family member, inpatient stay
          </p>
        </div>
      </section>

      <section className="mx-auto max-w-3xl px-6 py-16 text-center">
        <p className="font-serif text-2xl font-semibold">
          Ready to arrange an admission?
        </p>
        <p className="mt-2 text-[#5F5E5A]">
          Call us or walk in — our team will help you find the right room.
        </p>
        <Link
          href="/contact"
          className="mt-6 inline-block rounded-full bg-[#D85A30] px-6 py-3 text-sm font-medium text-white hover:bg-[#c14f28]"
        >
          Get directions & contact
        </Link>
      </section>
    </main>
  );
}