import { cookies } from 'next/headers';
import { createSupabaseClient, type User } from './supabase';

const COOKIE_NAME = 'eau_session';
const SESSION_MAX_AGE = 60 * 60 * 24 * 30; // 30 days

export async function getSession(): Promise<User | null> {
  const cookieStore = await cookies();
  const token = cookieStore.get(COOKIE_NAME)?.value;
  if (!token) return null;

  const supabase = createSupabaseClient();
  const { data } = await supabase
    .from('users')
    .select('*')
    .eq('session_token', token)
    .gt('session_expires_at', new Date().toISOString())
    .single();

  return (data as User) ?? null;
}

export function buildSessionCookieHeader(token: string): string {
  const expires = new Date(Date.now() + SESSION_MAX_AGE * 1000).toUTCString();
  return `${COOKIE_NAME}=${token}; Path=/; HttpOnly; SameSite=Lax; Secure; Max-Age=${SESSION_MAX_AGE}; Expires=${expires}`;
}

export function buildClearCookieHeader(): string {
  return `${COOKIE_NAME}=; Path=/; HttpOnly; SameSite=Lax; Secure; Max-Age=0`;
}
