'use client';

interface Finding {
  id: string;
  vendor_id: string;
  vendor_name: string;
  feature_name: string;
  feature_desc?: string | null;
  risk_level: 'red' | 'yellow' | 'unverified';
  default_state: string;
  annex_iii_ref: string;
  annex_iii_category: string;
  deployer_obligation_gap: string;
}

interface PortfolioEntry {
  vendor_id: string;
  vendor_name: string;
  product_category: string;
  finding_count: number;
  red_count: number;
  yellow_count: number;
}

interface Props {
  findings: Finding[];
  portfolio: PortfolioEntry[];
}

export function PortfolioView({ findings, portfolio }: Props) {
  // Group findings by vendor, sorted by red count desc
  const sortedVendors = [...portfolio].sort((a, b) => b.red_count - a.red_count);

  return (
    <div className="space-y-6">
      <h2 className="eyebrow" style={{ color: 'var(--slate)', textTransform: 'uppercase', marginBottom: '0.5rem' }}>
        Priority actions by vendor
      </h2>

      {sortedVendors.map((vendor) => {
        const vendorFindings = findings
          .filter((f) => f.vendor_id === vendor.vendor_id)
          .sort((a, b) => (a.risk_level === 'red' ? -1 : 1) - (b.risk_level === 'red' ? -1 : 1));

        return (
          <div key={vendor.vendor_id} style={{ borderRadius: '8px', border: 'var(--border-rule)', overflow: 'hidden' }}>
            {/* Vendor header */}
            <div className="flex items-center justify-between px-5 py-3" style={{ background: vendor.red_count > 0 ? 'var(--coal)' : 'var(--mist)' }}>
              <div className="flex items-center gap-3">
                <span className="font-medium text-[0.9rem]" style={{ color: vendor.red_count > 0 ? 'var(--paper)' : 'var(--coal)' }}>
                  {vendor.vendor_name}
                </span>
                <span className="meta" style={{ color: vendor.red_count > 0 ? 'var(--slate)' : 'var(--slate)' }}>
                  {vendor.product_category}
                </span>
              </div>
              <div className="flex items-center gap-3">
                {vendor.red_count > 0 && (
                  <span className="text-[0.7rem] font-medium px-2 py-0.5 rounded" style={{ background: 'rgba(247,244,239,0.15)', color: 'var(--paper)' }}>
                    {vendor.red_count} high-risk
                  </span>
                )}
                <span className="meta" style={{ color: vendor.red_count > 0 ? 'var(--slate)' : 'var(--slate)' }}>
                  {vendor.finding_count} findings
                </span>
              </div>
            </div>

            {/* Findings list */}
            <div>
              {vendorFindings.map((finding, i) => (
                <div
                  key={finding.id}
                  className="flex items-start gap-4 px-5 py-3"
                  style={{
                    background: i % 2 === 0 ? '#fff' : 'var(--mist)',
                    borderTop: 'var(--border-hairline)',
                    ...(finding.risk_level === 'red' ? { boxShadow: 'inset 3px 0 0 0 var(--coal)' } : {}),
                  }}
                >
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center gap-2 mb-0.5">
                      <span className="font-medium text-[0.82rem]" style={{ color: 'var(--coal)' }}>
                        {finding.feature_name}
                      </span>
                      <span
                        className="text-[0.65rem] font-medium px-1.5 py-0.5 rounded"
                        style={{
                          background: finding.risk_level === 'red' ? 'rgba(17,19,21,0.90)' : 'rgba(138,107,74,0.18)',
                          color: finding.risk_level === 'red' ? '#F7F4EF' : '#111315',
                        }}
                      >
                        {finding.risk_level === 'red' ? 'High' : 'Medium'}
                      </span>
                    </div>
                    <p className="text-[0.78rem] leading-relaxed" style={{ color: 'var(--slate)' }}>
                      {finding.deployer_obligation_gap}
                    </p>
                  </div>
                  <div className="shrink-0 text-right">
                    <span className="meta" style={{ color: 'var(--coal)' }}>{finding.annex_iii_ref}</span>
                    <span className="block text-[0.68rem]" style={{ color: 'var(--slate)' }}>{finding.default_state}</span>
                  </div>
                </div>
              ))}
            </div>
          </div>
        );
      })}
    </div>
  );
}
