import crypto from 'crypto';
import { createSupabaseClient } from './supabase';

const RATE_LIMIT_MINUTES = 5;
const EXPIRY_MINUTES = 15;

export async function generateMagicLink(email: string): Promise<string> {
  const supabase = createSupabaseClient();

  // Rate limit: one link per 5 minutes per email
  const cutoff = new Date(Date.now() - RATE_LIMIT_MINUTES * 60 * 1000).toISOString();
  const { data: recent } = await supabase
    .from('magic_links')
    .select('id')
    .eq('email', email)
    .gte('created_at', cutoff)
    .limit(1);

  if (recent && recent.length > 0) {
    throw new Error('RATE_LIMITED');
  }

  const token = crypto.randomBytes(32).toString('hex');
  const expiresAt = new Date(Date.now() + EXPIRY_MINUTES * 60 * 1000).toISOString();

  await supabase.from('magic_links').insert({
    email,
    token,
    expires_at: expiresAt,
    used: false,
  });

  const appUrl = process.env.NEXT_PUBLIC_APP_URL ?? 'http://localhost:3000';
  return `${appUrl}/api/auth/verify?token=${token}`;
}
