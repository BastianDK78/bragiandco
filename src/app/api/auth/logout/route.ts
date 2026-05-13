import { NextRequest, NextResponse } from 'next/server';
import { cookies } from 'next/headers';
import { createSupabaseClient } from '@/lib/supabase';
import { buildClearCookieHeader } from '@/lib/auth';

export async function POST(req: NextRequest) {
  const cookieStore = await cookies();
  const token = cookieStore.get('eau_session')?.value;

  if (token) {
    const supabase = createSupabaseClient();
    await supabase
      .from('users')
      .update({ session_token: null, session_expires_at: null })
      .eq('session_token', token);
  }

  const res = NextResponse.redirect(new URL('/login', req.url));
  res.headers.set('Set-Cookie', buildClearCookieHeader());
  return res;
}
