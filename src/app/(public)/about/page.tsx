const LEADERSHIP = [
  { name: "Dr. Simon Mwangi", title: "CEO / Founder", photo: "/images/team/ceo.jpg" },
  { name: "Dr. Mwangi Antonio", title: "Manager of Operations", photo: "/images/team/anto.jpg" },
  { name: "Denis Mwangi", title: "HR Manager", photo: "/images/team/Denis_Mwangi.jpeg" },
  { name: "Teddy H.", title: "Resident Clinical Officer", photo: "/images/team/Teddy.png" },
  { name: "Lab Technician", title: "Lab Technician", photo: "/images/team/photo-to-be-added.jpg" },
  { name: "Co-Founders", title: "Co-Founders", photo: "/images/team/founders.jpg" },
  { name: "Resident Nurse", title: "Resident Nurse", photo: "/images/team/photo-to-be-added.jpg" },
  { name: "Nurse Aide", title: "Nurse Aide", photo: "/images/team/photo-to-be-added.jpg" },
];

const HISTORY = [
  "SPA Nursing Home started in Thika town in 1995 in a two-room rented premise, offering general outpatient services with two employees — the doctor-in-charge and a receptionist.",
  "In 1997, these services were relocated to Nairobi at Park Road/Ngara and expanded to incorporate a routine laboratory.",
  "Towards the close of 2003, further business realignment saw the services moved to the Central Business District at Afya Centre, where an office is maintained to this day.",
  "In 2007, an inpatient facility was built at Ruiru in Kiambu County to cater for the increasing number of patients and their diverse needs.",
];

export default function AboutPage() {
  return (
    <main className="bg-[#F1EFE8] text-[#2C2C2A]">
      {/* Hero */}
      <section className="bg-[#0B2420] text-[#F6F1E4]">
        <div className="mx-auto max-w-3xl px-6 pb-16 pt-16 sm:pt-24">
          <p className="mb-4 text-sm font-medium tracking-wide text-[#8FBBA9]">
            ABOUT US
          </p>
          <h1 className="font-serif text-4xl font-semibold leading-tight">
            A neighbourhood clinic, grown up
          </h1>
          <p className="mt-6 max-w-xl text-[#C9D8CE]">
            SPA Nursing Home is a private hospital incorporated in Kenya,
            focused on providing the care our community actually needs —
            held to a standard high enough to raise the local health status,
            not just meet it.
          </p>
        </div>
      </section>

      {/* Mission / vision */}
      <section className="mx-auto max-w-5xl px-6 py-16">
        <div className="grid gap-8 sm:grid-cols-2">
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
              To be the region's most trusted name in inpatient and
              maternity care — known for outcomes, not just proximity.
            </p>
          </div>
        </div>
      </section>

      {/* History timeline */}
      <section className="border-y border-[#E8E2D6] bg-[#EDE6D3]/60 py-16">
        <div className="mx-auto max-w-3xl px-6">
          <p className="mb-10 font-serif text-2xl font-semibold">Our story</p>
          <div className="flex flex-col gap-6">
            {HISTORY.map((paragraph, i) => (
              <div key={i} className="flex gap-5">
                <div className="flex h-7 w-7 shrink-0 items-center justify-center rounded-full bg-[#0F6E56] text-xs font-medium text-white">
                  {i + 1}
                </div>
                <p className="text-sm text-[#5F5E5A]">{paragraph}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Leadership & team */}
      <section className="mx-auto max-w-5xl px-6 py-20">
        <p className="mb-8 font-serif text-2xl font-semibold">
          Leadership & team
        </p>
        <div className="grid gap-6 sm:grid-cols-3 lg:grid-cols-4">
          {LEADERSHIP.map((person, i) => (
            <div key={i} className="rounded-2xl bg-white p-4">
              <div className="mb-3 aspect-square w-full overflow-hidden rounded-xl bg-[#E8E2D6]">
                {person.photo ? (
                  // eslint-disable-next-line @next/next/no-img-element
                  <img
                    src={person.photo}
                    alt={person.name}
                    className="block h-full w-full object-cover object-center"
                  />
                ) : (
                  <div className="flex h-full w-full items-center justify-center border-2 border-dashed border-[#c9c1ac] text-center text-xs text-[#8A8880]">
                    Photo
                  </div>
                )}
              </div>
              <p className="text-sm font-medium">{person.name}</p>
              <p className="text-xs text-[#5F5E5A]">{person.title}</p>
            </div>
          ))}
        </div>
      </section>
    </main>
  );
}