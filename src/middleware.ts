import { auth } from "@/lib/auth";
import { NextResponse } from "next/server";

// Protects everything under /admin except /admin/login itself.
// Redirects unauthenticated visitors to the login page.
export default auth((req) => {
  const isLoggedIn = !!req.auth;
  const isLoginPage = req.nextUrl.pathname === "/admin/login";

  if (!isLoggedIn && !isLoginPage) {
    const loginUrl = new URL("/admin/login", req.nextUrl.origin);
    return NextResponse.redirect(loginUrl);
  }

  if (isLoggedIn && isLoginPage) {
    const adminHome = new URL("/admin/patients", req.nextUrl.origin);
    return NextResponse.redirect(adminHome);
  }
});

export const config = {
  matcher: ["/admin/:path*"],
};
