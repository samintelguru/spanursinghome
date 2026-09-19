import NextAuth from "next-auth";
import { authConfig } from "@/lib/auth.config";
import { NextResponse } from "next/server";

const { auth } = NextAuth(authConfig);

export default auth((req) => {
  const isLoggedIn = !!req.auth;
  const isLoginPage = req.nextUrl.pathname === "/admin/login";

  // Build redirects from the address the visitor actually used.
  // Auth.js rewrites req.nextUrl to AUTH_URL / NEXTAUTH_URL when either is set,
  // so relying on req.nextUrl.origin would send people to that domain instead
  // (e.g. the old spanursinghome.org site).
  const host = (req.headers.get("x-forwarded-host") ?? req.headers.get("host") ?? "")
    .split(",")[0]
    .trim();
  const isLocal = host.startsWith("localhost") || host.startsWith("127.");
  const proto = req.headers.get("x-forwarded-proto") ?? (isLocal ? "http" : "https");
  const origin = host ? `${proto}://${host}` : req.nextUrl.origin;

  if (!isLoggedIn && !isLoginPage) {
    return NextResponse.redirect(new URL("/admin/login", origin));
  }

  if (isLoggedIn && isLoginPage) {
    return NextResponse.redirect(new URL("/admin", origin));
  }
});

export const config = {
  matcher: ["/admin/:path*"],
};