import { Nav } from '@/components/layout/Nav';
import { Footer } from '@/components/layout/Footer';
import { EmailCaptureForm } from '@/components/landing/EmailCaptureForm';
import { PaddleCheckoutButton } from '@/components/landing/PaddleCheckoutButton';

export default function LandingPage() {
  const daysToEnforcement = 81; // TODO: compute dynamically from Aug 2 2026

  return (
    <div className="flex flex-col min-h-screen bg-cream">
      <Nav />

      <main className="flex-1">
        <div className="max-w-7xl mx-auto px-6 py-16 md:py-24">

          <p className="text-xs font-bold tracking-[0.1em] uppercase text-cedar mb-3">
            EU AI Act Intelligence
          </p>

          <h1 className="text-4xl md:text-5xl font-extrabold text-zinc-dark mb-4 max-w-3xl leading-tight">
            Is your enterprise AI stack in scope?
          </h1>

          <p className="text-base text-cedar mb-3 max-w-2xl">
            Enforcement date:{' '}
            <span className="font-semibold text-zinc-dark">August 2, 2026</span>.{' '}
            {daysToEnforcement} days for compliance officers, HR directors, and legal teams
            to confirm scope and close deployer obligation gaps.
          </p>

          <div className="w-12 h-0.5 bg-oak mb-10" />

          {/* Two-CTA grid */}
          <div className="grid md:grid-cols-2 gap-6 max-w-4xl">

            {/* Free offer */}
            <div className="bg-white border border-stone rounded-sm p-8">
              <p className="text-[10px] font-bold tracking-[0.12em] uppercase text-cedar mb-3">
                Free
              </p>
              <h2 className="text-xl font-extrabold text-zinc-dark mb-2">
                EU AI Act Scope Checker
              </h2>
              <p className="text-sm text-cedar mb-1">
                10 questions. Under 5 minutes. Find out whether your organisation is in scope
                and where your deployer obligation gaps are.
              </p>
              <p className="text-xs text-cedar mb-4">PDF delivered to your inbox.</p>
              <EmailCaptureForm />
            </div>

            {/* Paid offer */}
            <div className="bg-white border border-stone rounded-sm p-8">
              <p className="text-[10px] font-bold tracking-[0.12em] uppercase text-cedar mb-3">
                €149 — one-time
              </p>
              <h2 className="text-xl font-extrabold text-zinc-dark mb-2">
                Vendor Risk Heatmap
              </h2>
              <p className="text-sm text-cedar mb-4">
                20 AI features across 8 enterprise platforms assessed for Annex III §4
                employment AI and §1(c) biometric scope. Each row shows risk level, default
                state, and your deployer obligation gap.
              </p>

              <ul className="text-xs text-cedar space-y-1 mb-6">
                {[
                  'Obligation Decoder — Articles 9-15 per finding',
                  'Provider / Deployer Matrix — whose obligation is whose',
                  '90-Day Roadmap — week-by-week to August 2',
                  'Article 13 Notice Templates — ready to use',
                ].map((item) => (
                  <li key={item} className="flex gap-2">
                    <span className="text-oak font-bold">+</span>
                    {item}
                  </li>
                ))}
              </ul>

              <PaddleCheckoutButton />

              <p className="text-xs text-cedar mt-3">
                Paddle checkout · EU VAT handled · Instant access via email link
              </p>
            </div>
          </div>

          {/* Urgency strip */}
          <div className="mt-10 max-w-4xl p-4 border-l-4 border-risk-red bg-white flex gap-4 items-start">
            <span className="text-risk-red font-extrabold text-2xl leading-none">
              {daysToEnforcement}
            </span>
            <div>
              <p className="text-sm font-semibold text-zinc-dark">Days to enforcement.</p>
              <p className="text-xs text-cedar">
                Articles 9-15 of the EU AI Act apply to high-risk AI systems from August 2,
                2026. National market surveillance authorities can investigate from August 3.
                Fines: up to €15M or 3% of global annual turnover.
              </p>
            </div>
          </div>
        </div>
      </main>

      <Footer />
    </div>
  );
}
