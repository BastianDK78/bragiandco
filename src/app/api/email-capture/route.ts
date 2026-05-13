import { NextRequest, NextResponse } from 'next/server';
import fs from 'fs';
import path from 'path';
import { isWorkEmail } from '@/lib/email-validation';
import { getResend, FROM_ADDRESS } from '@/lib/resend';
import { createSupabaseClient } from '@/lib/supabase';
import { scopeCheckerEmail } from '@/lib/emails/templates';

export async function POST(req: NextRequest) {
  const { email } = await req.json();

  if (!email || !isWorkEmail(email)) {
    return NextResponse.json(
      { error: 'Please use your work email address.' },
      { status: 400 }
    );
  }

  // Record email capture
  const supabase = createSupabaseClient();
  await supabase
    .from('email_captures')
    .upsert({ email, source: 'free_checklist' }, { onConflict: 'email' });

  // Read and attach the PDF
  const pdfPath = path.join(process.cwd(), 'public', 'scope-checker.pdf');
  const pdfBuffer = fs.readFileSync(pdfPath);
  const pdfBase64 = pdfBuffer.toString('base64');

  const { subject, html } = scopeCheckerEmail();

  const resend = getResend();
  await resend.emails.send({
    from: FROM_ADDRESS,
    to: email,
    subject,
    html,
    attachments: [
      {
        filename: 'EU-AI-Act-Scope-Checker.pdf',
        content: pdfBase64,
      },
    ],
  });

  return NextResponse.json({ ok: true });
}
