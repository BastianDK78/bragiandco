import { Resend } from 'resend';

let _resend: Resend | null = null;

export function getResend(): Resend {
  if (!_resend) {
    const key = process.env.RESEND_API_KEY;
    if (!key) throw new Error('Missing RESEND_API_KEY');
    _resend = new Resend(key);
  }
  return _resend;
}

export const FROM_ADDRESS =
  process.env.RESEND_FROM_ADDRESS ?? 'noreply@bragiandco.com';
