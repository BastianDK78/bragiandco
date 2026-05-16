import { NextRequest, NextResponse } from 'next/server';

// Gated routes — lightweight cookie check only.
// Full Supabase session validation happens inside each page Server Component.
// This keeps middleware on the edge runtime (fast) and avoids edge/Node compat issues.
// TODO: restore /heatmap before launch
const GATED_PATHS = [
  // '/heatmap',
  '/obligation-decoder',
  '/matrix',
  '/calendar',
  '/templates',
  '/roadmap',
  '/portfolio',
];

export function proxy(req: NextRequest) {
  const { pathname } = req.nextUrl;
  const isGated = GATED_PATHS.some((p) => pathname === p || pathname.startsWith(`${p}/`));

  if (isGated) {
    const sessionCookie = req.cookies.get('eau_session');
    if (!sessionCookie?.value) {
      const loginUrl = new URL('/login', req.url);
      loginUrl.searchParams.set('next', pathname);
      return NextResponse.redirect(loginUrl);
    }
  }

  return NextResponse.next();
}

export const config = {
  matcher: [
    '/heatmap/:path*',
    '/obligation-decoder/:path*',
    '/matrix/:path*',
    '/calendar/:path*',
    '/templates/:path*',
    '/roadmap/:path*',
  ],
};
