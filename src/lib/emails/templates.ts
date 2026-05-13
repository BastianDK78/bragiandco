// Plain HTML email templates — no react-email dependency needed.
// Resend accepts raw HTML strings directly.
// Inline styles are required because email clients strip <style> blocks.

const BASE_STYLE = `
  font-family: Inter, Arial, Helvetica, sans-serif;
  background: #F5F0E8;
  color: #1C1C1C;
`;

const OAK = '#C4985A';
const ZINC = '#1C1C1C';
const CEDAR = '#9B9B8C';
const CREAM = '#F5F0E8';

function wrap(body: string): string {
  return `<!DOCTYPE html>
<html>
<head><meta charset="utf-8"><meta name="viewport" content="width=device-width"></head>
<body style="margin:0;padding:0;${BASE_STYLE}">
  <table width="100%" cellpadding="0" cellspacing="0" border="0">
    <tr>
      <td align="center" style="padding:40px 20px;">
        <table width="600" cellpadding="0" cellspacing="0" border="0" style="max-width:600px;width:100%;">
          <tr>
            <td style="padding:0 0 24px 0;">
              <span style="font-size:11px;font-weight:800;letter-spacing:0.15em;color:${OAK};text-transform:uppercase;">BRAGI &amp; CO.</span>
            </td>
          </tr>
          ${body}
          <tr>
            <td style="padding:32px 0 0 0;border-top:1px solid #C4B8A0;">
              <p style="font-size:11px;color:${CEDAR};margin:0;">
                EU AI Act Compliance Intelligence &middot; bragiandco.com<br>
                Not legal advice. Consult your legal team.
              </p>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</body>
</html>`;
}

export function magicLinkEmail(magicUrl: string): { subject: string; html: string } {
  return {
    subject: 'Your EU AI Act Heatmap access link',
    html: wrap(`
      <tr>
        <td style="padding:0 0 16px 0;">
          <h1 style="font-size:24px;font-weight:800;color:${ZINC};margin:0;">Your access link</h1>
        </td>
      </tr>
      <tr>
        <td style="padding:0 0 24px 0;">
          <p style="font-size:15px;color:${ZINC};margin:0 0 16px 0;">
            Click the button below to open your EU AI Act Vendor Risk Heatmap.
            The link expires in 15 minutes.
          </p>
          <a href="${magicUrl}"
             style="display:inline-block;background:${OAK};color:${CREAM};font-size:14px;font-weight:700;
                    text-decoration:none;padding:12px 28px;border-radius:2px;">
            Open your heatmap &rarr;
          </a>
        </td>
      </tr>
      <tr>
        <td style="padding:0 0 16px 0;">
          <p style="font-size:12px;color:${CEDAR};margin:0;">
            If you did not request this link, you can safely ignore this email.
            This link can only be used once.
          </p>
        </td>
      </tr>
    `),
  };
}

export function scopeCheckerEmail(): { subject: string; html: string } {
  return {
    subject: 'Your EU AI Act Scope Checker',
    html: wrap(`
      <tr>
        <td style="padding:0 0 16px 0;">
          <h1 style="font-size:24px;font-weight:800;color:${ZINC};margin:0;">EU AI Act Scope Checker</h1>
        </td>
      </tr>
      <tr>
        <td style="padding:0 0 24px 0;">
          <p style="font-size:15px;color:${ZINC};margin:0 0 16px 0;">
            Your Scope Checker is attached to this email as a PDF.
          </p>
          <p style="font-size:15px;color:${ZINC};margin:0 0 16px 0;">
            The 10-question checklist tells you whether your organisation is in EU AI Act scope
            and where your compliance gaps are. Enforcement date: <strong>August 2, 2026</strong>.
          </p>
          <p style="font-size:14px;color:${CEDAR};margin:0;">
            If you find you have 3 or more gaps, the Vendor Risk Heatmap maps exactly which
            of your systems are creating exposure and what you must have in place.
          </p>
        </td>
      </tr>
    `),
  };
}

export function purchaseAlertEmail(
  buyerEmail: string,
  transactionId: string,
  amount: string
): { subject: string; html: string } {
  return {
    subject: `EAU Purchase — ${buyerEmail}`,
    html: wrap(`
      <tr>
        <td style="padding:0 0 16px 0;">
          <h1 style="font-size:20px;font-weight:800;color:${ZINC};margin:0;">New purchase</h1>
        </td>
      </tr>
      <tr>
        <td style="padding:0 0 24px 0;">
          <table cellpadding="0" cellspacing="0" border="0" width="100%">
            <tr>
              <td style="padding:8px 0;border-bottom:1px solid #C4B8A0;font-size:13px;color:${CEDAR};">Customer</td>
              <td style="padding:8px 0;border-bottom:1px solid #C4B8A0;font-size:13px;color:${ZINC};font-weight:600;">${buyerEmail}</td>
            </tr>
            <tr>
              <td style="padding:8px 0;border-bottom:1px solid #C4B8A0;font-size:13px;color:${CEDAR};">Transaction</td>
              <td style="padding:8px 0;border-bottom:1px solid #C4B8A0;font-size:13px;color:${ZINC};">${transactionId}</td>
            </tr>
            <tr>
              <td style="padding:8px 0;font-size:13px;color:${CEDAR};">Amount</td>
              <td style="padding:8px 0;font-size:13px;color:${ZINC};font-weight:600;">${amount}</td>
            </tr>
          </table>
          <p style="font-size:12px;color:${CEDAR};margin:16px 0 0 0;">
            Magic link has been sent to the buyer. Supabase user record created with purchased=true.
          </p>
        </td>
      </tr>
    `),
  };
}
