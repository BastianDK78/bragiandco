import { redirect } from 'next/navigation';
import { Nav } from '@/components/layout/Nav';
import { Footer } from '@/components/layout/Footer';
import { HeatmapTable } from '@/components/heatmap/HeatmapTable';
import { getSession } from '@/lib/auth';
import { getPublishedFindings } from '@/lib/findings';

const MAX = '1400px';

export default async function HeatmapPage() {
  const user = await getSession();
  if (!user) redirect('/login?next=/heatmap');

  const rows = await getPublishedFindings();

  return (
    <div style={{ fontFamily: 'Inter, Arial, Helvetica, sans-serif', background: '#F5F0E8', minHeight: '100vh', display: 'flex', flexDirection: 'column' }}>
      <Nav activePage="/heatmap" />

      <main style={{ flex: 1 }}>

        {/* ── Page header ────────────────────────────────────────── */}
        <section style={{ maxWidth: MAX, margin: '0 auto', padding: '3.5rem 2rem 2rem' }}>
          <p style={{ fontSize: '0.68rem', fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.1em', color: '#9B9B8C', marginBottom: '1rem' }}>
            EU AI Act Intelligence
          </p>
          <h1 style={{ fontSize: 'clamp(2.25rem, 4.5vw, 3.5rem)', fontWeight: 800, lineHeight: 1.05, letterSpacing: '-0.02em', color: '#1C1C1C', marginBottom: '1rem' }}>
            Vendor Risk Heatmap
          </h1>
          <p style={{ fontSize: 'clamp(1rem, 1.4vw, 1.15rem)', fontWeight: 400, color: '#9B9B8C', maxWidth: '62ch', lineHeight: 1.5 }}>
            20 AI features across 8 enterprise platforms, assessed for Annex III §4 employment AI and §1(c) biometric scope. Updated quarterly.
          </p>
          <hr style={{ width: '3rem', height: '2px', background: '#C4985A', border: 'none', margin: '1rem 0' }} />
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.85rem', flexWrap: 'wrap', fontSize: '0.78rem', fontWeight: 500, color: '#9B9B8C', marginTop: '1.5rem' }}>
            <span>Version <strong style={{ color: '#1C1C1C', fontWeight: 700 }}>1.0</strong> · May 2026</span>
            <span style={{ width: '4px', height: '4px', background: '#9B9B8C', borderRadius: '50%', display: 'inline-block', opacity: 0.6 }} />
            <span>Enforcement date: <strong style={{ color: '#1C1C1C', fontWeight: 700 }}>August 2, 2026</strong> — 81 days</span>
            <span style={{ width: '4px', height: '4px', background: '#9B9B8C', borderRadius: '50%', display: 'inline-block', opacity: 0.6 }} />
            <span>Last verified: <strong style={{ color: '#1C1C1C', fontWeight: 700 }}>May 12, 2026</strong></span>
          </div>
        </section>

        {/* ── Heatmap (summary + filters + table) ────────────────── */}
        <section style={{ maxWidth: MAX, margin: '0 auto', padding: '2.25rem 2rem 2.5rem' }}>
          <HeatmapTable rows={rows} />
        </section>

        {/* ── Obligation callout ──────────────────────────────────── */}
        <section style={{ maxWidth: MAX, margin: '0 auto', padding: '0 2rem 3rem' }}>
          <aside style={{ borderLeft: '4px solid #C4985A', background: 'rgba(196,184,160,0.3)', padding: '2rem 2.25rem', borderRadius: '0 2px 2px 0' }}>
            <p style={{ fontSize: '0.7rem', fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.1em', color: '#B0864A', marginBottom: '1rem' }}>
              Deployer obligations — August 2, 2026
            </p>
            <p style={{ fontSize: '0.95rem', lineHeight: 1.55, color: '#1C1C1C', maxWidth: '72ch', marginBottom: '1.25rem' }}>
              Each Red or Yellow finding above creates five obligations under Articles 9-15 of the EU AI Act. These obligations sit with you as the operator. Your vendor&apos;s EU AI Office registration does not discharge them.
            </p>
            <ol style={{ listStyle: 'none', display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(220px, 1fr))', gap: '0.85rem 1.5rem', marginBottom: '1.5rem', counterReset: 'oblig', padding: 0 }}>
              {[
                ['AI register entry', 'Art. 9'],
                ['Log retention confirmed in admin', 'Art. 12'],
                ['Disclosure notice issued to employees/applicants', 'Art. 13'],
                ['Human oversight process documented', 'Art. 14'],
                ['Vendor accuracy documentation obtained', 'Art. 15'],
              ].map(([text, ref], i) => (
                <li key={ref} style={{ position: 'relative', paddingLeft: '2rem', fontSize: '0.85rem', color: '#1C1C1C', lineHeight: 1.4 }}>
                  <span style={{ position: 'absolute', left: 0, top: 0, fontWeight: 800, color: '#B0864A', fontSize: '0.88rem' }}>
                    {String(i + 1).padStart(2, '0')}
                  </span>
                  {text} <em style={{ fontStyle: 'normal', color: '#9B9B8C' }}>({ref})</em>
                </li>
              ))}
            </ol>
            <a href="/obligation-decoder" style={{ fontSize: '0.88rem', fontWeight: 700, color: '#B0864A', display: 'inline-flex', alignItems: 'center', gap: '0.4rem' }}>
              → Open the Obligation Decoder
            </a>
          </aside>
        </section>

        {/* ── Asset nav ──────────────────────────────────────────── */}
        <section style={{ maxWidth: MAX, margin: '0 auto', padding: '0 2rem 3rem' }}>
          <p style={{ fontSize: '0.68rem', fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.1em', color: '#9B9B8C', marginBottom: '1rem' }}>
            Included in your subscription
          </p>
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: '1rem' }}>
            {[
              {
                icon: <path d="M6 3h9l5 5v13H6z"/>,
                icon2: <><path d="M15 3v5h5"/><path d="M9 13h7M9 17h7M9 9h3"/></>,
                title: 'Obligation Decoder',
                body: 'Articles 9-15 mapped to each finding. What you must have in place.',
                href: '/obligation-decoder',
              },
              {
                icon: <><path d="M3 5h18v14H3z"/><path d="M3 10h18M9 5v14M15 5v14"/></>,
                title: 'Provider / Deployer Matrix',
                body: "Whose obligation is it? Per-vendor responsibility table.",
                href: '/matrix',
              },
              {
                icon: <><rect x="3" y="5" width="18" height="16" rx="1"/><path d="M3 9h18M8 3v4M16 3v4"/><path d="M7 13h2M11 13h2M15 13h2M7 17h2M11 17h2"/></>,
                title: '90-Day Roadmap',
                body: 'Week-by-week action plan to August 2, 2026.',
                href: '/roadmap',
              },
              {
                icon: <><path d="M4 4h13l3 3v13H4z"/><path d="M8 10h8M8 14h8M8 18h5"/></>,
                title: 'Article 13 Notice Templates',
                body: 'Ready-to-use disclosure notices for employees and applicants.',
                href: '/templates',
              },
            ].map(({ icon, icon2, title, body, href }) => (
              <a
                key={title}
                href={href}
                style={{
                  background: '#FFFFFF',
                  border: '1px solid #C4B8A0',
                  borderRadius: '2px',
                  padding: '1.5rem 1.25rem 1.35rem',
                  display: 'flex',
                  flexDirection: 'column',
                  gap: '0.65rem',
                  textDecoration: 'none',
                  transition: 'border-color 0.15s, transform 0.15s',
                }}
                onMouseEnter={(e) => {
                  (e.currentTarget as HTMLElement).style.borderColor = '#C4985A';
                  (e.currentTarget as HTMLElement).style.transform = 'translateY(-2px)';
                }}
                onMouseLeave={(e) => {
                  (e.currentTarget as HTMLElement).style.borderColor = '#C4B8A0';
                  (e.currentTarget as HTMLElement).style.transform = 'none';
                }}
              >
                <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#B0864A" strokeWidth="1.5" aria-hidden="true">
                  {icon}
                  {icon2}
                </svg>
                <span style={{ fontSize: '0.92rem', fontWeight: 700, color: '#1C1C1C', letterSpacing: '-0.01em' }}>{title}</span>
                <span style={{ fontSize: '0.8rem', color: '#9B9B8C', lineHeight: 1.45, flex: 1 }}>{body}</span>
                <span style={{ fontSize: '0.78rem', fontWeight: 700, color: '#B0864A' }}>Open →</span>
              </a>
            ))}
          </div>
        </section>

        {/* ── Assessment CTA ─────────────────────────────────────── */}
        <section style={{ background: '#1C1C1C', color: '#F5F0E8', position: 'relative', overflow: 'hidden' }}>
          <div style={{ maxWidth: MAX, margin: '0 auto', padding: '4rem 2rem 4.5rem', position: 'relative', zIndex: 1 }}>
            <p style={{ fontSize: '0.68rem', fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.15em', color: '#C4985A', marginBottom: '1.25rem' }}>
              Bragi &amp; Co.
            </p>
            <h2 style={{ fontSize: 'clamp(2rem, 4vw, 3rem)', fontWeight: 800, lineHeight: 1.05, letterSpacing: '-0.02em', color: '#F5F0E8', maxWidth: '22ch', marginBottom: '1.25rem' }}>
              3 or more Red findings?
            </h2>
            <p style={{ fontSize: '1rem', color: '#9B9B8C', lineHeight: 1.55, maxWidth: '62ch', marginBottom: '2rem' }}>
              A Bragi &amp; Co. Assessment scopes your exact deployer obligations, maps your gaps per vendor, and produces a prioritised remediation plan. Assessments typically deliver within 2-3 weeks. Enforcement date: August 2, 2026.
            </p>
            <a
              href="mailto:bastian@bragiandco.com?subject=Assessment enquiry"
              style={{
                display: 'inline-block',
                background: '#C4985A',
                color: '#F5F0E8',
                fontWeight: 700,
                fontSize: '0.92rem',
                letterSpacing: '0.02em',
                padding: '0.85rem 2rem',
                borderRadius: '2px',
                textDecoration: 'none',
              }}
            >
              Book an Assessment
            </a>
            <a
              href="https://bragiandco.com"
              style={{
                display: 'block',
                marginTop: '1.25rem',
                fontSize: '0.78rem',
                color: '#9B9B8C',
                textDecoration: 'underline',
                textUnderlineOffset: '3px',
              }}
            >
              bragiandco.com
            </a>
          </div>
          {/* Rune watermark */}
          <span
            aria-hidden="true"
            style={{
              position: 'absolute',
              right: '-3rem',
              bottom: '-4rem',
              fontFamily: 'Inter, Arial, sans-serif',
              fontWeight: 800,
              fontSize: '32rem',
              lineHeight: 0.8,
              color: '#F5F0E8',
              opacity: 0.05,
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
