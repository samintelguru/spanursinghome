import Link from "next/link";

// Fixed WhatsApp button shown on every public page. Update the number here if
// it ever changes — it's the only place it's hard-coded for this button.
const WHATSAPP_NUMBER = "254718837372"; // 0718 837 372, in international format
const DEFAULT_MESSAGE = "Hello SPA Nursing Home, I'd like to ask about...";

export default function WhatsAppButton() {
  const href = `https://wa.me/${WHATSAPP_NUMBER}?text=${encodeURIComponent(DEFAULT_MESSAGE)}`;

  return (
    <Link
      href={href}
      target="_blank"
      rel="noopener noreferrer"
      aria-label="Chat with us on WhatsApp"
      title="Chat with us on WhatsApp"
      className="fixed bottom-5 right-5 z-50 flex h-14 w-14 items-center justify-center rounded-full bg-[#25D366] text-white shadow-lg transition-transform hover:scale-105 hover:shadow-xl focus:outline-none focus:ring-2 focus:ring-[#25D366] focus:ring-offset-2"
    >
      <svg viewBox="0 0 32 32" className="h-7 w-7" fill="currentColor" aria-hidden="true">
        <path d="M16.004 3C9.377 3 4 8.373 4 15c0 2.29.638 4.43 1.744 6.257L4 29l7.938-1.706A11.94 11.94 0 0 0 16.004 27C22.63 27 28 21.627 28 15S22.63 3 16.004 3Zm0 21.818c-1.91 0-3.7-.53-5.226-1.454l-.375-.222-4.71 1.012 1.03-4.59-.246-.394A9.77 9.77 0 0 1 5.182 15c0-5.965 4.857-10.818 10.822-10.818 5.965 0 10.818 4.853 10.818 10.818 0 5.966-4.853 10.818-10.818 10.818Zm5.93-8.105c-.324-.163-1.92-.947-2.218-1.056-.298-.108-.515-.163-.732.163-.216.325-.84 1.056-1.03 1.273-.19.217-.379.244-.703.081-.324-.163-1.368-.504-2.606-1.607-.963-.859-1.614-1.92-1.803-2.245-.19-.325-.02-.5.143-.663.146-.146.325-.38.487-.57.163-.19.217-.325.325-.542.108-.217.054-.407-.027-.57-.081-.163-.732-1.766-1.003-2.42-.264-.634-.532-.548-.732-.558l-.623-.011a1.2 1.2 0 0 0-.868.407c-.298.325-1.138 1.112-1.138 2.712 0 1.6 1.165 3.146 1.327 3.363.163.217 2.293 3.502 5.556 4.912.777.335 1.383.535 1.856.685.78.248 1.49.213 2.052.13.626-.094 1.92-.784 2.19-1.542.271-.759.271-1.409.19-1.543-.081-.135-.298-.216-.622-.38Z" />
      </svg>
    </Link>
  );
}
