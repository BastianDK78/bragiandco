'use client';

import { useState } from 'react';
import { Input } from '@/components/ui/input';

export function LoginForm({ errorParam, next }: { errorParam?: string; next?: string }) {
  const [email, setEmail] = useState('');
  const [status, setStatus] = useState<'idle' | 'loading' | 'done' | 'error'>('idle');
  const [errorMsg, setErrorMsg] = useState(
    errorParam === 'invalid' ? 'This link has expired or already been used. Request a new one.' : ''
  );

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setStatus('loading');
    setErrorMsg('');

    const res = await fetch('/api/auth/request-link', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ email }),
    });

    if (res.ok) {
      setStatus('done');
    } else {
      const data = await res.json();
      setErrorMsg(data.error ?? 'Something went wrong. Please try again.');
      setStatus('error');
    }
  }

  if (status === 'done') {
    return (
      <div className="p-6 bg-white border border-stone rounded-sm">
        <p className="font-semibold text-zinc-dark">Check your inbox.</p>
        <p className="text-sm text-cedar mt-2">
          If your email is associated with a purchase, your access link is on the way.
          The link expires in 15 minutes.
        </p>
      </div>
    );
  }

  return (
    <form onSubmit={handleSubmit} className="flex flex-col gap-4">
      <div>
        <label htmlFor="email" className="block text-sm font-medium text-zinc-dark mb-1.5">
          Work email
        </label>
        <Input
          id="email"
          type="email"
          placeholder="you@company.com"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          required
          disabled={status === 'loading'}
          className="bg-white border-stone text-zinc-dark placeholder:text-cedar"
        />
      </div>
      {errorMsg && <p className="text-sm text-risk-red">{errorMsg}</p>}
      <button
        type="submit"
        disabled={status === 'loading'}
        className="w-full py-2.5 bg-oak text-cream text-sm font-bold rounded-sm
                   hover:opacity-90 transition-opacity disabled:opacity-50"
      >
        {status === 'loading' ? 'Sending link…' : 'Send access link →'}
      </button>
      <p className="text-xs text-cedar">
        Enter the email address you used to purchase. A one-time link will be sent.
      </p>
    </form>
  );
}
