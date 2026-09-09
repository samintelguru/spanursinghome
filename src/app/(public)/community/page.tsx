export default function CommunityPage() {
  return (
    <main className="bg-[#F1EFE8] text-[#2C2C2A]">
      {/* Hero */}
      <section className="bg-[#0B2420] text-[#F6F1E4]">
        <div className="mx-auto max-w-3xl px-6 pb-16 pt-16 sm:pt-24">
          <p className="mb-4 text-sm font-medium tracking-wide text-[#8FBBA9]">
            COMMUNITY
          </p>
          <h1 className="font-serif text-4xl font-semibold leading-tight">
            Beyond the clinic walls
          </h1>
          <p className="mt-6 max-w-xl text-[#C9D8CE]">
            We host regular health talks, free screening days, and outreach
            events for the Ruiru community. Check back here for what's
            coming up next.
          </p>
        </div>
      </section>

      {/* What we do in the community */}
      <section className="border-b border-[#E8E2D6] bg-white py-16">
        <div className="mx-auto max-w-3xl px-6">
          <p className="mb-10 font-serif text-2xl font-semibold">
            How we show up
          </p>
          <div className="grid gap-4 sm:grid-cols-2">
            {[
              "Free health screening days",
              "Maternal health talks",
              "Immunization drives",
              "Family planning outreach",
            ].map((item) => (
              <div
                key={item}
                className="rounded-xl bg-[#F1EFE8] p-4 text-sm font-medium"
              >
                {item}
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Upcoming events */}
      <section className="bg-[#EDE6D3]/60 py-16">
        <div className="mx-auto max-w-3xl px-6">
          <p className="mb-6 font-serif text-2xl font-semibold">
            Upcoming events
          </p>
          <div className="rounded-2xl border-2 border-dashed border-[#c9c1ac] bg-white p-10 text-center text-sm text-[#8A8880]">
            No upcoming events listed yet — this section updates as events
            are scheduled.
          </div>
        </div>
      </section>
    </main>
  );
}