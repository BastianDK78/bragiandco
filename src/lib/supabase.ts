import { createClient } from '@supabase/supabase-js';

// Instantiate inside request handlers — never as a module-level singleton.
// This prevents connection exhaustion on Vercel serverless.
export function createSupabaseClient() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const key = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!url || !key) throw new Error('Missing Supabase environment variables');
  return createClient(url, key, {
    auth: { persistSession: false },
  });
}

export type User = {
  id: string;
  email: string;
  purchased: boolean;
  purchased_at: string | null;
  created_at: string;
  last_accessed: string | null;
  session_token: string | null;
  session_expires_at: string | null;
};
