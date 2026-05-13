import { NextRequest, NextResponse } from 'next/server';
import { isWorkEmail } from '@/lib/email-validation';
import { createSupabaseClient } from '@/lib/supabase';
import { generateMagicLink } from '@/lib/magic-link';
import { getResend, FROM_ADDRESS } from '@/lib/resend';
import { magicLinkEmail } from '@/lib/emails/templates';

export async function POST(req: NextRequest) {
  const { email } = await req.json();

  if (!email || !isWorkEmail(email)) {
    return NextResponse.json(
      { error: 'Please use your work email address.' },
      { status: 400 }
    );
  }

  // Check the user has purchased — don't reveal whether account exists
  const supabase = createSupabaseClient();
  const { data: user } = await supabase
    .from('users')
    .select('purchased')
    .eq('email', email)
    .single();

  if (!user?.purchased) {
    // Silent: same response whether account doesn't exist or not purchased
    return NextResponse.json({ ok: true });
  }

  let magicUrl: string;
  try {
    magicUrl = await generateMagicLink(email);
  } catch (err) {
    if (err instanceof Error && err.message === 'RATE_LIMITED') {
      return NextResponse.json(
        { error: 'A link was already sent recently. Please check your inbox.' },
        { status: 429 }
      );
    }
    throw err;
  }

  const { subject, html } = magicLinkEmail(magicUrl);
  const resend = getResend();
  await resend.emails.send({ from: FROM_ADDRESS, to: email, subject, html });

  return NextResponse.json({ ok: true });
}
