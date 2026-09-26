// Social icons in the footer. An icon only renders once its URL below is
// filled in, so nothing broken goes live — add the real link and it appears.
const SOCIAL_LINKS: { name: string; url: string; icon: React.ReactNode }[] = [
  {
    name: "Facebook",
    url: "https://facebook.com", // e.g. https://facebook.com/spanursinghome
    icon: (
      <svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true">
        <path d="M22 12a10 10 0 1 0-11.56 9.88v-6.99H7.9V12h2.54V9.8c0-2.5 1.49-3.89 3.78-3.89 1.1 0 2.24.2 2.24.2v2.46h-1.26c-1.24 0-1.63.77-1.63 1.56V12h2.78l-.44 2.89h-2.34v6.99A10 10 0 0 0 22 12Z" />
      </svg>
    ),
  },
  {
    name: "Instagram",
    url: "https://instagram.com", // e.g. https://instagram.com/spanursinghome
    icon: (
      <svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true">
        <path d="M12 2.2c3.2 0 3.58.01 4.85.07 1.17.05 1.8.24 2.22.4.56.22.96.48 1.38.9.42.42.68.82.9 1.38.16.42.35 1.05.4 2.22.06 1.27.07 1.65.07 4.85s-.01 3.58-.07 4.85c-.05 1.17-.24 1.8-.4 2.22-.22.56-.48.96-.9 1.38-.42.42-.82.68-1.38.9-.42.16-1.05.35-2.22.4-1.27.06-1.65.07-4.85.07s-3.58-.01-4.85-.07c-1.17-.05-1.8-.24-2.22-.4a3.72 3.72 0 0 1-1.38-.9 3.72 3.72 0 0 1-.9-1.38c-.16-.42-.35-1.05-.4-2.22C2.21 15.58 2.2 15.2 2.2 12s.01-3.58.07-4.85c.05-1.17.24-1.8.4-2.22.22-.56.48-.96.9-1.38.42-.42.82-.68 1.38-.9.42-.16 1.05-.35 2.22-.4C8.42 2.21 8.8 2.2 12 2.2Zm0-2.2C8.74 0 8.33.01 7.05.07c-1.28.06-2.15.26-2.91.56a5.9 5.9 0 0 0-2.14 1.4A5.9 5.9 0 0 0 .6 4.17c-.3.76-.5 1.63-.56 2.91C0 8.33 0 8.74 0 12s.01 3.67.07 4.95c.06 1.28.26 2.15.56 2.91.31.8.72 1.48 1.4 2.14a5.9 5.9 0 0 0 2.14 1.4c.76.3 1.63.5 2.91.56 1.28.06 1.69.07 4.95.07s3.67-.01 4.95-.07c1.28-.06 2.15-.26 2.91-.56a5.9 5.9 0 0 0 2.14-1.4 5.9 5.9 0 0 0 1.4-2.14c.3-.76.5-1.63.56-2.91.06-1.28.07-1.69.07-4.95s-.01-3.67-.07-4.95c-.06-1.28-.26-2.15-.56-2.91a5.9 5.9 0 0 0-1.4-2.14A5.9 5.9 0 0 0 19.86.63c-.76-.3-1.63-.5-2.91-.56C15.67.01 15.26 0 12 0Z" />
        <path d="M12 5.84A6.16 6.16 0 1 0 12 18.16 6.16 6.16 0 0 0 12 5.84Zm0 10.16a4 4 0 1 1 0-8 4 4 0 0 1 0 8Zm7.85-10.4a1.44 1.44 0 1 1-2.88 0 1.44 1.44 0 0 1 2.88 0Z" />
      </svg>
    ),
  },
  {
    name: "X",
    url: "https://x.com", // e.g. https://x.com/spanursinghome
    icon: (
      <svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true">
        <path d="M18.9 2H22l-7.6 8.7L23.3 22h-6.9l-5.4-6.6L4.8 22H1.6l8.1-9.3L.9 2h7.1l4.9 6.1L18.9 2Zm-1.2 18h1.9L7.4 3.9H5.3L17.7 20Z" />
      </svg>
    ),
  },
  {
    name: "TikTok",
    url: "https://tiktok.com", // e.g. https://tiktok.com/@spanursinghome
    icon: (
      <svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true">
        <path d="M16.6 5.82a4.28 4.28 0 0 1-3.77-3.79h-3.2v13.4a2.6 2.6 0 1 1-1.84-2.49V9.72a5.82 5.82 0 1 0 5.04 5.76V9.4a7.28 7.28 0 0 0 3.77 1.05V7.05a4.24 4.24 0 0 1-.79-.05v-1.18Z" />
      </svg>
    ),
  },
  {
    name: "YouTube",
    url: "https://youtube.com", // e.g. https://youtube.com/@spanursinghome
    icon: (
      <svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true">
        <path d="M23.5 6.19a3.02 3.02 0 0 0-2.12-2.14C19.5 3.5 12 3.5 12 3.5s-7.5 0-9.38.55A3.02 3.02 0 0 0 .5 6.19 31.6 31.6 0 0 0 0 12a31.6 31.6 0 0 0 .5 5.81 3.02 3.02 0 0 0 2.12 2.14C4.5 20.5 12 20.5 12 20.5s7.5 0 9.38-.55a3.02 3.02 0 0 0 2.12-2.14A31.6 31.6 0 0 0 24 12a31.6 31.6 0 0 0-.5-5.81ZM9.6 15.6V8.4l6.32 3.6-6.32 3.6Z" />
      </svg>
    ),
  },
  {
    name: "LinkedIn",
    url: "https://linkedin.com", // e.g. https://linkedin.com/company/spanursinghome
    icon: (
      <svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true">
        <path d="M20.45 20.45h-3.56v-5.57c0-1.33-.02-3.04-1.85-3.04-1.86 0-2.15 1.45-2.15 2.94v5.67H9.34V9h3.41v1.56h.05c.48-.9 1.64-1.85 3.38-1.85 3.6 0 4.27 2.37 4.27 5.46v6.28ZM5.34 7.43a2.07 2.07 0 1 1 0-4.13 2.07 2.07 0 0 1 0 4.13ZM7.12 20.45H3.56V9h3.56v11.45Z" />
      </svg>
    ),
  },
];

export default function SocialLinks() {
  const active = SOCIAL_LINKS.filter((s) => s.url);
  if (active.length === 0) return null;

  return (
    <div className="flex gap-3">
      {active.map((s) => (
        <a
          key={s.name}
          href={s.url}
          target="_blank"
          rel="noopener noreferrer"
          aria-label={s.name}
          title={s.name}
          className="flex h-8 w-8 items-center justify-center rounded-full bg-[#E8E2D6] text-[#0B3D63] transition-colors hover:bg-[#0B3D63] hover:text-white"
        >
          <span className="h-4 w-4">{s.icon}</span>
        </a>
      ))}
    </div>
  );
}
