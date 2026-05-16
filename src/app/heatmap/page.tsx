import { Nav } from '@/components/layout/Nav';
import { Footer } from '@/components/layout/Footer';
import { HeatmapTable } from '@/components/heatmap/HeatmapTable';
import { getPublishedFindings } from '@/lib/findings';

export const dynamic = 'force-dynamic';

export default async function HeatmapPage() {
  // TODO: restore auth gate before launch
  // const user = await getSession();
  // if (!user) redirect('/login?next=/heatmap');

  const rows = await getPublishedFindings();

  return (
    <div className="min-h-screen flex flex-col" style={{ background: 'var(--paper)', fontFamily: 'var(--font-sans)' }}>
      <Nav activePage="/heatmap" />

      <main className="flex-1">

        {/* ── Page header ────────────────────────────────────────── */}
        <section className="mx-auto px-6 md:px-10 pt-14 pb-8" style={{ maxWidth: 'var(--content-width)' }}>
          <p className="eyebrow" style={{ color: 'var(--slate)', marginBottom: '1rem', textTransform: 'uppercase' }}>
            EU AI Act Intelligence
          </p>
          <h1 style={{ fontSize: 'clamp(2.25rem, 4.5vw, 3.5rem)', color: 'var(--coal)', marginBottom: '0.75rem' }}>
            Vendor Risk Heatmap
          </h1>
          <p style={{ fontSize: 'clamp(1rem, 1.3vw, 1.125rem)', color: 'var(--slate)', maxWidth: '62ch', lineHeight: 1.55 }}>
            {rows.length} AI features across 76 enterprise platforms, assessed for EU AI Act Annex III high-risk categories. Updated quarterly.
          </p>
          <hr style={{ width: '3rem', height: '2px', background: 'var(--oak)', border: 'none', margin: '1.25rem 0' }} />
          <div className="meta" style={{ display: 'flex', alignItems: 'center', gap: '0.85rem', flexWrap: 'wrap', color: 'var(--slate)', marginTop: '1rem' }}>
            <span>Version <strong style={{ color: 'var(--coal)' }}>1.4</strong> · May 2026</span>
            <span style={{ width: '3px', height: '3px', background: 'var(--slate)', borderRadius: '50%', display: 'inline-block', opacity: 0.5 }} />
            <span>Enforcement: <strong style={{ color: 'var(--coal)' }}>August 2, 2026</strong></span>
            <span style={{ width: '3px', height: '3px', background: 'var(--slate)', borderRadius: '50%', display: 'inline-block', opacity: 0.5 }} />
            <span>Last verified: <strong style={{ color: 'var(--coal)' }}>May 16, 2026</strong></span>
          </div>
        </section>

        {/* ── Heatmap ───────────────────────────────────────────── */}
        <section className="mx-auto px-6 md:px-10 pb-10" style={{ maxWidth: 'var(--max-width)' }}>
          <HeatmapTable rows={rows} />
        </section>

        {/* ── Obligation callout ──────────────────────────────────── */}
        <section className="mx-auto px-6 md:px-10 pb-12" style={{ maxWidth: 'var(--content-width)' }}>
          <aside style={{ borderLeft: '3px solid var(--oak)', background: 'var(--mist)', padding: '2rem 2.25rem', borderRadius: '0 4px 4px 0' }}>
            <p className="eyebrow" style={{ color: 'var(--oak)', marginBottom: '1rem', textTransform: 'uppercase' }}>
              Deployer obligations
            </p>
            <p style={{ fontSize: '0.95rem', lineHeight: 1.6, color: 'var(--coal)', maxWidth: '72ch', marginBottom: '1.25rem' }}>
              Each finding creates obligations under Articles 9-15 of the EU AI Act. These sit with you as the deployer. Your vendor&apos;s registration does not discharge them.
            </p>
            <ol style={{ listStyle: 'none', display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(220px, 1fr))', gap: '0.75rem 1.5rem', marginBottom: '1.5rem', padding: 0 }}>
              {[
                ['AI register entry', 'Art. 9'],
                ['Log retention confirmed', 'Art. 12'],
                ['Disclosure notice issued', 'Art. 13'],
                ['Human oversight documented', 'Art. 14'],
                ['Accuracy documentation obtained', 'Art. 15'],
              ].map(([text, ref], i) => (
                <li key={ref} style={{ position: 'relative', paddingLeft: '1.75rem', fontSize: '0.85rem', color: 'var(--coal)', lineHeight: 1.4 }}>
                  <span className="meta" style={{ position: 'absolute', left: 0, top: '1px', fontWeight: 600, color: 'var(--oak)' }}>
                    {String(i + 1).padStart(2, '0')}
                  </span>
                  {text} <span style={{ color: 'var(--slate)' }}>({ref})</span>
                </li>
              ))}
            </ol>
          </aside>
        </section>

        {/* ── Assessment CTA ─────────────────────────────────────── */}
        <section style={{ background: 'var(--coal)', position: 'relative', overflow: 'hidden' }}>
          <div className="mx-auto px-6 md:px-10 py-16 md:py-20 relative z-10" style={{ maxWidth: 'var(--content-width)' }}>
            <p className="eyebrow" style={{ color: 'var(--oak)', marginBottom: '1.25rem', textTransform: 'uppercase' }}>
              Bragi &amp; Co.
            </p>
            <h2 style={{ fontSize: 'clamp(2rem, 4vw, 3rem)', color: 'var(--paper)', maxWidth: '24ch', marginBottom: '1.25rem' }}>
              Need help interpreting your exposure?
            </h2>
            <p style={{ fontSize: '1rem', color: 'var(--slate)', lineHeight: 1.6, maxWidth: '60ch', marginBottom: '2rem' }}>
              A BRAGI Assessment scopes your deployer obligations, maps gaps per vendor, and produces a prioritised 90-day remediation plan.
            </p>
            <a
              href="mailto:info@bragiandco.com?subject=Assessment enquiry"
              style={{
                display: 'inline-block',
                background: 'var(--oak)',
                color: 'var(--paper)',
                fontWeight: 500,
                fontSize: '0.92rem',
                padding: '0.875rem 1.5rem',
                borderRadius: '999px',
                textDecoration: 'none',
              }}
            >
              Request Assessment
            </a>
          </div>
          <span
            aria-hidden="true"
            style={{
              position: 'absolute',
              right: '-2rem',
              bottom: '-3rem',
              fontFamily: 'var(--font-sans)',
              fontWeight: 500,
              fontSize: '28rem',
              lineHeight: 0.8,
              color: 'var(--paper)',
              opacity: 0.03,
              pointerEvents: 'none',
              userSelect: 'none',
              letterSpacing: '-0.05em',
              zIndex: 0,
            }}
          >
            B
          </span>
        </section>
      </main>

      <Footer />
    </div>
  );
}
