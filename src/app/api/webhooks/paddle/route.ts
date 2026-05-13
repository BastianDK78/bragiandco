import { NextRequest, NextResponse } from 'next/server';
import { verifyPaddleSignature } from '@/lib/paddle';
import { createSupabaseClient } from '@/lib/supabase';
import { generateMagicLink } from '@/lib/magic-link';
import { getResend, FROM_ADDRESS } from '@/lib/resend';
import { magicLinkEmail, purchaseAlertEmail } from '@/lib/emails/templates';

export const dynamic = 'force-dynamic';

export async function POST(req: NextRequest) {
  // rawBody must be read before any parsing
  const rawBody = await req.text();
  const signatureHeader = req.headers.get('Paddle-Signature') ?? '';

  if (!verifyPaddleSignature(rawBody, signatureHeader)) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
  }

  const event = JSON.parse(rawBody);
  if (event.event_type !== 'transaction.completed') {
    return NextResponse.json({ received: true });
  }

  const email: string = event.data?.customer?.email;
  const transactionId: string = event.data?.id ?? 'unknown';
  const amount: string = event.data?.details?.totals?.grand_total ?? '149.00';
  const currency: string = event.data?.currency_code ?? 'EUR';

  if (!email) {
    return NextResponse.json({ error: 'No customer email' }, { status: 400 });
  }

  const supabase = createSupabaseClient();

  // Upsert user record with purchased=true
  await supabase.from('users').upsert(
    { email, purchased: true, purchased_at: new Date().toISOString() },
    { onConflict: 'email' }
  );

  // Record email capture source
  await supabase
    .from('email_captures')
    .upsert({ email, source: 'purchase' }, { onConflict: 'email' });

  // Generate and send magic link to buyer
  let magicUrl: string;
  try {
    magicUrl = await generateMagicLink(email);
  } catch {
    // Rate limited — buyer will need to request link manually via /login
    magicUrl = `${process.env.NEXT_PUBLIC_APP_URL ?? ''}/login`;
  }

  const resend = getResend();
  const { subject, html } = magicLinkEmail(magicUrl);
  await resend.emails.send({ from: FROM_ADDRESS, to: email, subject, html });

  // Notify Bastian
  const notificationEmail = process.env.NOTIFICATION_EMAIL;
  if (notificationEmail) {
    const alert = purchaseAlertEmail(email, transactionId, `${amount} ${currency}`);
    await resend.emails.send({
      from: FROM_ADDRESS,
      to: notificationEmail,
      subject: alert.subject,
      html: alert.html,
    });
  }

  return NextResponse.json({ received: true });
}
