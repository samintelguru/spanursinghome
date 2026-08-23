export default function CommunityPage() {
  return (
    <main className="bg-[#F1EFE8] text-[#2C2C2A]">
      <section className="mx-auto max-w-3xl px-6 pb-20 pt-16 sm:pt-24">
        <p className="mb-4 text-sm font-medium tracking-wide text-[#0F6E56]">
          COMMUNITY
        </p>
        <h1 className="font-serif text-4xl font-semibold leading-tight">
          Beyond the clinic walls
        </h1>
        <p className="mt-6 text-[#5F5E5A]">
          We host regular health talks, free screening days, and outreach
          events for the Ruiru community. Check back here for what's coming
          up next.
        </p>

        <div className="mt-12 rounded-2xl border-2 border-dashed border-[#c9c1ac] bg-white p-10 text-center text-sm text-[#8A8880]">
          No upcoming events listed yet — this section updates as events are
          scheduled.
        </div>
      </section>
    </main>
  );
}