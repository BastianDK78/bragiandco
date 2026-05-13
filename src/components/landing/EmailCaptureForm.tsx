'use client';

import { useState } from 'react';
import { Input } from '@/components/ui/input';

export function EmailCaptureForm() {
  const [email, setEmail] = useState('');
  const [status, setStatus] = useState<'idle' | 'loading' | 'done' | 'error'>('idle');
  const [errorMsg, setErrorMsg] = useState('');

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setStatus('loading');
    setErrorMsg('');

    const res = await fetch('/api/email-capture', {
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
      <div className="mt-4 p-4 border border-oak bg-white rounded-sm">
        <p className="text-sm font-semibold text-zinc-dark">PDF sent.</p>
        <p className="text-sm text-cedar mt-1">
          Check your inbox — the Scope Checker is on its way.
        </p>
      </div>
    );
  }

  return (
    <form onSubmit={handleSubmit} className="mt-4 flex flex-col gap-3">
      <div className="flex gap-2">
        <Input
          type="email"
          placeholder="you@company.com"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          required
          disabled={status === 'loading'}
          className="flex-1 bg-white border-stone text-zinc-dark placeholder:text-cedar"
        />
        <button
          type="submit"
          disabled={status === 'loading'}
          className="px-5 py-2 bg-oak text-cream text-sm font-bold rounded-sm
                     hover:opacity-90 transition-opacity disabled:opacity-50 whitespace-nowrap"
        >
          {status === 'loading' ? 'Sending…' : 'Send PDF →'}
        </button>
      </div>
      {status === 'error' && (
        <p className="text-sm text-risk-red">{errorMsg}</p>
      )}
      <p className="text-xs text-cedar">Work email required. No spam.</p>
    </form>
  );
}
