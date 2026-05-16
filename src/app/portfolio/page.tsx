import { redirect } from 'next/navigation';
import { Nav } from '@/components/layout/Nav';
import { Footer } from '@/components/layout/Footer';
import { getSession } from '@/lib/auth';
import { createSupabaseClient } from '@/lib/supabase';
import { PortfolioView } from '@/components/portfolio/PortfolioView';

export const dynamic = 'force-dynamic';

export default async function PortfolioPage() {
  const user = await getSession();
  if (!user) redirect('/login?next=/portfolio');

  const supabase = createSupabaseClient();

  // Get user's portfolio with summary
  const { data: portfolio } = await supabase
    .from('user_portfolio_summary')
    .select('*')
    .eq('user_id', user.id)
    .order('red_count', { ascending: false });

  // Get all findings for user's vendors
  const vendorIds = (portfolio ?? []).map((p: { vendor_id: string }) => p.vendor_id);

  let findings: any[] = [];
  if (vendorIds.length > 0) {
    const { data } = await supabase
      .from('heatmap_findings')
      .select(`id, vendor_id, vendors ( name ), feature_name, feature_desc, risk_level,
               default_state, default_state_note, annex_iii_ref, annex_iii_category,
               deployer_obligation_gap, confidence, published, display_order`)
      .in('vendor_id', vendorIds)
      .eq('published', true)
      .order('display_order', { ascending: true });
    findings = (data ?? []).map((row: any) => ({
      ...row,
      vendor_name: row.vendors?.name ?? row.vendor_id,
      vendors: undefined,
    }));
  }

  const totalFindings = findings.length;
  const redFindings = findings.filter((f: any) => f.risk_level === 'red').length;
  const yellowFindings = findings.filter((f: any) => f.risk_level === 'yellow').length;

  return (
    <div className="min-h-screen flex flex-col" style={{ background: 'var(--paper)', fontFamily: 'var(--font-sans)' }}>
      <Nav activePage="/portfolio" />

      <main className="flex-1">
        <section className="mx-auto px-6 md:px-10 pt-14 pb-8" style={{ maxWidth: 'var(--content-width)' }}>
          <p className="eyebrow" style={{ color: 'var(--slate)', marginBottom: '1rem', textTransform: 'uppercase' }}>
            My Stack
          </p>
          <h1 style={{ fontSize: 'clamp(2rem, 4vw, 3rem)', color: 'var(--coal)', marginBottom: '0.75rem' }}>
            Your AI Exposure Portfolio
          </h1>
          <p style={{ fontSize: '1rem', color: 'var(--slate)', maxWidth: '62ch', lineHeight: 1.55 }}>
            {vendorIds.length === 0
              ? 'Add vendors from the heatmap to build your exposure portfolio.'
              : `${vendorIds.length} vendors in your stack with ${totalFindings} findings requiring attention.`
            }
          </p>
          <hr style={{ width: '3rem', height: '2px', background: 'var(--oak)', border: 'none', margin: '1.25rem 0' }} />
        </section>

        {vendorIds.length > 0 && (
          <>
            {/* Summary cards */}
            <section className="mx-auto px-6 md:px-10 pb-8" style={{ maxWidth: 'var(--content-width)' }}>
              <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
                <article style={{ background: 'var(--mist)', borderRadius: '8px', padding: '1.25rem 1.5rem' }}>
                  <div className="text-2xl font-medium tabular-nums" style={{ fontFamily: 'var(--font-mono)', color: 'var(--coal)' }}>{vendorIds.length}</div>
                  <div className="eyebrow mt-1" style={{ color: 'var(--slate)', textTransform: 'uppercase' }}>Vendors monitored</div>
                </article>
                <article style={{ background: 'var(--mist)', borderRadius: '8px', padding: '1.25rem 1.5rem' }}>
                  <div className="text-2xl font-medium tabular-nums" style={{ fontFamily: 'var(--font-mono)', color: 'var(--coal)' }}>{totalFindings}</div>
                  <div className="eyebrow mt-1" style={{ color: 'var(--slate)', textTransform: 'uppercase' }}>Total findings</div>
                </article>
                <article style={{ background: 'var(--mist)', borderRadius: '8px', padding: '1.25rem 1.5rem' }}>
                  <div className="text-2xl font-medium tabular-nums" style={{ fontFamily: 'var(--font-mono)', color: 'var(--coal)' }}>{redFindings}</div>
                  <div className="eyebrow mt-1" style={{ color: 'var(--slate)', textTransform: 'uppercase' }}>High-risk</div>
                </article>
                <article style={{ background: 'var(--mist)', borderRadius: '8px', padding: '1.25rem 1.5rem' }}>
                  <div className="text-2xl font-medium tabular-nums" style={{ fontFamily: 'var(--font-mono)', color: 'var(--coal)' }}>{redFindings * 5}</div>
                  <div className="eyebrow mt-1" style={{ color: 'var(--slate)', textTransform: 'uppercase' }}>Obligations to address</div>
                </article>
              </div>
            </section>

            {/* Personalized CTA */}
            {redFindings >= 3 && (
              <section className="mx-auto px-6 md:px-10 pb-8" style={{ maxWidth: 'var(--content-width)' }}>
                <aside style={{ background: 'var(--coal)', borderRadius: '8px', padding: '2rem 2.25rem' }}>
                  <p className="eyebrow" style={{ color: 'var(--oak)', marginBottom: '0.75rem', textTransform: 'uppercase' }}>Recommended</p>
                  <p style={{ fontSize: '1.1rem', color: 'var(--paper)', lineHeight: 1.5, maxWidth: '60ch', marginBottom: '1.25rem' }}>
                    Your stack has {redFindings} high-risk findings across {vendorIds.length} vendors. A BRAGI Assessment maps your specific obligations and produces a prioritised remediation plan.
                  </p>
                  <a
                    href="mailto:info@bragiandco.com?subject=Assessment enquiry — My Stack"
                    style={{ display: 'inline-block', background: 'var(--oak)', color: 'var(--paper)', fontWeight: 500, fontSize: '0.88rem', padding: '0.75rem 1.25rem', borderRadius: '999px', textDecoration: 'none' }}
                  >
                    Request Assessment for my stack
                  </a>
                </aside>
              </section>
            )}

            {/* Portfolio findings table */}
            <section className="mx-auto px-6 md:px-10 pb-12" style={{ maxWidth: 'var(--max-width)' }}>
              <PortfolioView findings={findings} portfolio={portfolio ?? []} />
            </section>
          </>
        )}

        {vendorIds.length === 0 && (
          <section className="mx-auto px-6 md:px-10 pb-12" style={{ maxWidth: 'var(--content-width)' }}>
            <div style={{ background: 'var(--mist)', borderRadius: '8px', padding: '3rem', textAlign: 'center' }}>
              <p style={{ color: 'var(--coal)', fontSize: '1.1rem', marginBottom: '1rem' }}>No vendors in your stack yet.</p>
              <p style={{ color: 'var(--slate)', fontSize: '0.9rem', marginBottom: '1.5rem' }}>
                Go to the Heatmap and click the + button next to vendors in your environment.
              </p>
              <a href="/heatmap" style={{ display: 'inline-block', background: 'var(--coal)', color: 'var(--paper)', fontWeight: 500, fontSize: '0.88rem', padding: '0.75rem 1.25rem', borderRadius: '999px', textDecoration: 'none' }}>
                Browse Heatmap
              </a>
            </div>
          </section>
        )}
      </main>

      <Footer />
    </div>
  );
}
