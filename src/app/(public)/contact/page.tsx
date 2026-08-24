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
      <section className="mx-auto grid max-w-5xl gap-12 px-6 pb-20 pt-16 sm:grid-cols-2 sm:pt-24">
        <div>
          <p className="mb-4 text-sm font-medium tracking-wide text-[#0F6E56]">
            CONTACT
          </p>
          <h1 className="font-serif text-4xl font-semibold leading-tight">
            Get in touch
          </h1>
          <p className="mt-6 text-[#5F5E5A]">
            For urgent concerns, walk in any time — our outpatient clinic
            never closes. For everything else, reach us below.
          </p>

          <div className="mt-8 flex flex-col gap-3 text-sm">
            <div>
              <p className="font-medium">Emergency line</p>
              <p className="text-[#5F5E5A]">0700 000 000</p>
            </div>
            <div>
              <p className="font-medium">Email</p>
              <p className="text-[#5F5E5A]">info@spanursinghome.org</p>
            </div>
            <div>
              <p className="font-medium">Location</p>
              <p className="text-[#5F5E5A]">Ruiru, Kiambu County, Kenya</p>
            </div>
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
    </main>
  );
}