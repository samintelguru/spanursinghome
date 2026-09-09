"use client";

import { useEffect, useState } from "react";

type Slide = {
  src?: string;
  alt: string;
};

const DEFAULT_SLIDES: Slide[] = Array.from({ length: 10 }, (_, i) => ({
  alt: `Facility photo ${i + 1}`,
}));

export default function PhotoCarousel({
  slides = DEFAULT_SLIDES,
  intervalMs = 4000,
}: {
  slides?: Slide[];
  intervalMs?: number;
}) {
  const [index, setIndex] = useState(0);

  useEffect(() => {
    const timer = setInterval(() => {
      setIndex((i) => (i + 1) % slides.length);
    }, intervalMs);
    return () => clearInterval(timer);
  }, [slides.length, intervalMs]);

  const goTo = (i: number) => setIndex(i);
  const prev = () => setIndex((i) => (i - 1 + slides.length) % slides.length);
  const next = () => setIndex((i) => (i + 1) % slides.length);

  return (
    <div className="relative aspect-[4/3] overflow-hidden rounded-2xl bg-[#E8E2D6]">
      {slides.map((slide, i) => (
        <div
          key={i}
          className="absolute inset-0 transition-opacity duration-700"
          style={{ opacity: i === index ? 1 : 0 }}
        >
          {slide.src ? (
            // eslint-disable-next-line @next/next/no-img-element
            <img
              src={slide.src}
              alt={slide.alt}
              className="h-full w-full object-cover"
            />
          ) : (
            <div className="flex h-full w-full items-center justify-center border-2 border-dashed border-[#c9c1ac] p-6 text-center text-sm text-[#8A8880]">
              {slide.alt} — replace with real photography
            </div>
          )}
        </div>
      ))}

      <button
        onClick={prev}
        aria-label="Previous photo"
        className="absolute left-3 top-1/2 flex h-8 w-8 -translate-y-1/2 items-center justify-center rounded-full bg-white/80 text-[#2C2C2A] hover:bg-white"
      >
        ‹
      </button>
      <button
        onClick={next}
        aria-label="Next photo"
        className="absolute right-3 top-1/2 flex h-8 w-8 -translate-y-1/2 items-center justify-center rounded-full bg-white/80 text-[#2C2C2A] hover:bg-white"
      >
        ›
      </button>

      <div className="absolute bottom-3 left-1/2 flex -translate-x-1/2 gap-1.5">
        {slides.map((_, i) => (
          <button
            key={i}
            onClick={() => goTo(i)}
            aria-label={`Go to photo ${i + 1}`}
            className={`h-1.5 rounded-full transition-all ${
              i === index ? "w-4 bg-[#0B3D63 ]" : "w-1.5 bg-white/70"
            }`}
          />
        ))}
      </div>
    </div>
  );
}