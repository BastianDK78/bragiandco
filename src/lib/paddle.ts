import crypto from 'crypto';

/**
 * Verify a Paddle webhook signature.
 * Paddle sends: Paddle-Signature: ts=TIMESTAMP;h1=HASH
 * HMAC-SHA256 is computed over "TIMESTAMP:RAWBODY" using PADDLE_WEBHOOK_SECRET.
 * Timestamps older than 5 seconds are rejected (replay protection).
 */
export function verifyPaddleSignature(rawBody: string, signatureHeader: string): boolean {
  const secret = process.env.PADDLE_WEBHOOK_SECRET;
  if (!secret) throw new Error('Missing PADDLE_WEBHOOK_SECRET');

  const parts = Object.fromEntries(
    signatureHeader.split(';').map((p) => p.split('=') as [string, string])
  );
  const ts = parts['ts'];
  const h1 = parts['h1'];
  if (!ts || !h1) return false;

  // Replay protection: reject if > 5 seconds old
  const age = Date.now() / 1000 - parseInt(ts, 10);
  if (age > 5) return false;

  const signed = `${ts}:${rawBody}`;
  const expected = crypto
    .createHmac('sha256', secret)
    .update(signed)
    .digest('hex');

  return crypto.timingSafeEqual(Buffer.from(expected), Buffer.from(h1));
}
