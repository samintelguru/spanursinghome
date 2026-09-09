"use client";

import { useState } from "react";

export default function ContactPage() {
  const [submitted, setSubmitted] = useState(false);
  const [error, setError] = useState("");
  const [sending, setSending] = useState(false);
  const [form, setForm] = useState({ fullName: "", phone: "", message: "" });

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");
    setSending(true);

    const res = await fetch("/api/contact", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(form),
    });

    setSending(false);

    if (!res.ok) {
      setError("Something went wrong. Please try calling us directly instead.");
      return;
    }

    setSubmitted(true);
  };

  return (
    <main className="bg-[#F1EFE8] text-[#2C2C2A]">
      {/* Hero */}
      <section className="bg-[#0B2420] text-[#F6F1E4]">
        <div className="mx-auto max-w-5xl px-6 pb-16 pt-16 sm:pt-24">
          <p className="mb-4 text-sm font-medium tracking-wide text-[#8FBBA9]">
            CONTACT
          </p>
          <h1 className="font-serif text-4xl font-semibold leading-tight">
            Get in touch
          </h1>
          <p className="mt-6 max-w-xl text-[#C9D8CE]">
            For urgent concerns, walk in any time — our outpatient clinic
            never closes. For everything else, reach us below.
          </p>
        </div>
      </section>

      <section className="mx-auto grid max-w-5xl gap-12 px-6 py-16 sm:grid-cols-2">
        <div>
          <div className="flex flex-col gap-3">
            {[
              { label: "Emergency line", value: "0706 155 600" },
              { label: "Email", value: "info@spanursinghome.org" },
              {
                label: "Location",
                value:
                  "Off Kimbo-Matangi Road, Ruiru, Kiambu County — 800m off the Thika superhighway, behind Kenyatta University's Ruiru campus.",
              },
            ].map((item) => (
              <div key={item.label} className="rounded-xl bg-white p-4">
                <p className="text-sm font-medium">{item.label}</p>
                <p className="mt-1 text-sm text-[#5F5E5A]">{item.value}</p>
              </div>
            ))}
          </div>
        </div>

        <div className="rounded-2xl bg-white p-6">
          {submitted ? (
            <div className="flex h-full flex-col items-center justify-center text-center">
              <p className="font-serif text-xl font-semibold text-[#0F6E56]">
                Message sent
              </p>
              <p className="mt-2 text-sm text-[#5F5E5A]">
                We'll get back to you shortly. For urgent needs, please call
                our emergency line directly.
              </p>
            </div>
          ) : (
            <form onSubmit={handleSubmit} className="flex flex-col gap-3">
              <input
                placeholder="Full name"
                required
                value={form.fullName}
                onChange={(e) => setForm({ ...form, fullName: e.target.value })}
                className="rounded-md border border-[#E8E2D6] px-3 py-2 text-sm"
              />
              <input
                type="tel"
                placeholder="Phone number"
                required
                value={form.phone}
                onChange={(e) => setForm({ ...form, phone: e.target.value })}
                className="rounded-md border border-[#E8E2D6] px-3 py-2 text-sm"
              />
              <textarea
                placeholder="What can we help you with?"
                required
                rows={4}
                value={form.message}
                onChange={(e) => setForm({ ...form, message: e.target.value })}
                className="rounded-md border border-[#E8E2D6] px-3 py-2 text-sm"
              />
              {error && <p className="text-sm text-red-600">{error}</p>}
              <button
                type="submit"
                disabled={sending}
                className="mt-2 rounded-full bg-[#D85A30] px-6 py-3 text-sm font-medium text-white hover:bg-[#c14f28] disabled:opacity-60"
              >
                {sending ? "Sending..." : "Send message"}
              </button>
            </form>
          )}
        </div>
      </section>

      {/* Map */}
      <section className="border-t border-[#E8E2D6] bg-white py-16">
        <div className="mx-auto max-w-5xl px-6">
          <p className="mb-6 font-serif text-2xl font-semibold">Find us</p>
          <div className="overflow-hidden rounded-2xl border border-[#E8E2D6]">
            <iframe
              title="SPA Nursing Home location"
              src="https://www.google.com/maps?q=-1.142362959690373, 36.98232017190173&z=16&output=embed"
              width="100%"
              height="400"
              style={{ border: 0 }}
              loading="lazy"
              referrerPolicy="no-referrer-when-downgrade"
            />
          </div>
          <p className="mt-4 text-sm text-[#5F5E5A]">
            Off Kimbo-Matangi Road — 800m off the Thika superhighway, behind
            Kenyatta University's Ruiru campus.
          </p>
        </div>
      </section>
    </main>
  );
}