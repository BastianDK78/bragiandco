const BLOCKED_DOMAINS = new Set([
  'gmail.com', 'googlemail.com',
  'hotmail.com', 'hotmail.co.uk', 'hotmail.fr', 'hotmail.de',
  'outlook.com', 'outlook.co.uk',
  'yahoo.com', 'yahoo.co.uk', 'yahoo.fr', 'yahoo.de',
  'icloud.com', 'me.com', 'mac.com',
  'live.com', 'msn.com',
  'aol.com',
  'protonmail.com', 'pm.me',
  'tutanota.com',
]);

export function isWorkEmail(email: string): boolean {
  const lower = email.toLowerCase().trim();
  const atIndex = lower.lastIndexOf('@');
  if (atIndex === -1) return false;
  const domain = lower.slice(atIndex + 1);
  return !BLOCKED_DOMAINS.has(domain);
}
