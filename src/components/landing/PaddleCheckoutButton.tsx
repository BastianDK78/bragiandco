'use client';

import { useEffect } from 'react';

declare global {
  interface Window {
    Paddle?: {
      Initialize: (opts: { token: string }) => void;
      Checkout: { open: (opts: { items: { priceId: string }[] }) => void };
    };
  }
}

export function PaddleCheckoutButton() {
  useEffect(() => {
    const script = document.createElement('script');
    script.src = 'https://cdn.paddle.com/paddle/v2/paddle.js';
    script.async = true;
    script.onload = () => {
      const token = process.env.NEXT_PUBLIC_PADDLE_CLIENT_TOKEN;
      if (token && window.Paddle) {
        window.Paddle.Initialize({ token });
      }
    };
    document.head.appendChild(script);
    return () => {
      document.head.removeChild(script);
    };
  }, []);

  function handleCheckout() {
    const priceId = process.env.NEXT_PUBLIC_PADDLE_PRICE_ID;
    if (!priceId || !window.Paddle) {
      alert('Checkout is not configured yet. Check back soon.');
      return;
    }
    window.Paddle.Checkout.open({ items: [{ priceId }] });
  }

  return (
    <button
      onClick={handleCheckout}
      className="w-full py-3 bg-oak text-cream text-sm font-bold rounded-sm
                 hover:opacity-90 transition-opacity"
    >
      Get Access — €149 →
    </button>
  );
}
