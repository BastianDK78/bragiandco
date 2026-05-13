import { NextRequest, NextResponse } from 'next/server';
import crypto from 'crypto';
import { createSupabaseClient } from '@/lib/supabase';
import { buildSessionCookieHeader } from '@/lib/auth';

export async function GET(req: NextRequest) {
  const token = req.nextUrl.searchParams.get('token');
  if (!token) return NextResponse.redirect(new URL('/login?error=invalid', req.url));

  const supabase = createSupabaseClient();

  // Find valid, unused magic link
  const { data: link } = await supabase
    .from('magic_links')
    .select('*')
    .eq('token', token)
    .eq('used', false)
    .gt('expires_at', new Date().toISOString())
    .single();

  if (!link) return NextResponse.redirect(new URL('/login?error=invalid', req.url));

  // Mark link used immediately (atomic before cookie set)
  await supabase.from('magic_links').update({ used: true }).eq('id', link.id);

  // Create or update session
  const sessionToken = crypto.randomUUID();
  const sessionExpiresAt = new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString();

  await supabase
    .from('users')
    .update({
      session_token: sessionToken,
      session_expires_at: sessionExpiresAt,
      last_accessed: new Date().toISOString(),
    })
    .eq('email', link.email);

  const res = NextResponse.redirect(new URL('/heatmap', req.url));
  res.headers.set('Set-Cookie', buildSessionCookieHeader(sessionToken));
  return res;
}
