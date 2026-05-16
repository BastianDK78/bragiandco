'use client';

import { useState, useMemo, useCallback } from 'react';
import type { FindingRow } from '@/data/heatmap.types';

// ── Stack toggle button ──────────────────────────────────────────────────────

function StackToggle({ vendorId, vendorName, isInStack, onToggle }: {
  vendorId: string; vendorName: string; isInStack: boolean; onToggle: (id: string) => void;
}) {
  return (
    <button
      onClick={() => onToggle(vendorId)}
      title={isInStack ? `Remove ${vendorName} from My Stack` : `Add ${vendorName} to My Stack`}
      className="inline-flex items-center justify-center w-5 h-5 rounded transition-colors shrink-0"
      style={{
        background: isInStack ? 'var(--oak)' : 'transparent',
        color: isInStack ? 'var(--paper)' : 'var(--slate)',
        border: isInStack ? 'none' : '1px solid rgba(17,19,21,0.16)',
        fontSize: '0.75rem', fontWeight: 600, cursor: 'pointer',
      }}
    >
      {isInStack ? '✓' : '+'}
    </button>
  );
}

// ── Risk indicator ───────────────────────────────────────────────────────────

function RiskIndicator({ level }: { level: FindingRow['risk_level'] }) {
  const config = {
    red:        { bg: 'rgba(17, 19, 21, 0.90)', text: '#F7F4EF', label: 'High' },
    yellow:     { bg: 'rgba(138, 107, 74, 0.18)', text: '#111315', label: 'Medium' },
    unverified: { bg: 'rgba(110, 116, 120, 0.12)', text: '#6E7478', label: 'Unverified' },
  };
  const { bg, text, label } = config[level];
  return (
    <span className="inline-flex items-center text-[0.68rem] font-medium tracking-[0.03em] px-[0.7em] py-[0.25em] whitespace-nowrap"
      style={{ background: bg, color: text, borderRadius: '4px' }}>
      {label}
    </span>
  );
}

// ── State cell ───────────────────────────────────────────────────────────────

function StateCell({ state, note }: { state: string; note?: string }) {
  const isHigh = state === 'On by default' || state === 'On when feature licensed';
  return (
    <span className="text-[0.78rem] leading-snug" style={{ color: isHigh ? 'var(--oak)' : 'var(--slate)' }}>
      {state}
      {note && <span className="block mt-0.5 text-[0.7rem]" style={{ color: 'var(--slate)' }}>{note}</span>}
    </span>
  );
}

// ── Filter select ────────────────────────────────────────────────────────────

function FilterSelect({ label, value, onChange, options }: {
  label: string; value: string; onChange: (v: string) => void;
  options: { value: string; label: string }[];
}) {
  return (
    <div className="flex items-center gap-2">
      <label className="eyebrow" style={{ color: 'var(--slate)', textTransform: 'uppercase' }}>{label}</label>
      <select
        value={value}
        onChange={(e) => onChange(e.target.value)}
        className="text-[0.78rem] font-medium px-2.5 py-1.5 pr-7 appearance-none cursor-pointer"
        style={{ fontFamily: 'var(--font-sans)', color: 'var(--coal)', background: '#fff', border: 'var(--border-rule)', borderRadius: '4px' }}
      >
        {options.map((o) => <option key={o.value} value={o.value}>{o.label}</option>)}
      </select>
    </div>
  );
}

// ── Main component ───────────────────────────────────────────────────────────

type GroupBy = 'none' | 'vendor' | 'category' | 'annex';

interface Props {
  rows: FindingRow[];
  initialStack?: string[];
}

export function HeatmapTable({ rows, initialStack = [] }: Props) {
  const [filterVendor, setFilterVendor] = useState<string>('all');
  const [filterRisk, setFilterRisk] = useState<string>('all');
  const [filterCategory, setFilterCategory] = useState<string>('all');
  const [filterAnnex, setFilterAnnex] = useState<string>('all');
  const [groupBy, setGroupBy] = useState<GroupBy>('vendor');
  const [stack, setStack] = useState<Set<string>>(new Set(initialStack));

  // Derived lists
  const vendors = useMemo(() => [...new Set(rows.map((r) => r.vendor_name))].sort(), [rows]);
  const categories = useMemo(() => [...new Set(rows.map((r) => r.annex_iii_category))].sort(), [rows]);
  const annexRefs = useMemo(() => [...new Set(rows.map((r) => r.annex_iii_ref))].sort(), [rows]);

  const vendorIdMap = useMemo(() => {
    const m = new Map<string, string>();
    rows.forEach((r) => m.set(r.vendor_name, r.vendor_id));
    return m;
  }, [rows]);

  // Filter
  const filtered = useMemo(() => rows.filter((r) => {
    if (filterVendor !== 'all' && r.vendor_name !== filterVendor) return false;
    if (filterRisk !== 'all' && r.risk_level !== filterRisk) return false;
    if (filterCategory !== 'all' && r.annex_iii_category !== filterCategory) return false;
    if (filterAnnex !== 'all' && r.annex_iii_ref !== filterAnnex) return false;
    return true;
  }), [rows, filterVendor, filterRisk, filterCategory, filterAnnex]);

  // Group
  const grouped = useMemo(() => {
    if (groupBy === 'none') return [{ key: '', rows: filtered }];
    const map = new Map<string, FindingRow[]>();
    filtered.forEach((r) => {
      const key = groupBy === 'vendor' ? r.vendor_name
        : groupBy === 'category' ? r.annex_iii_category
        : r.annex_iii_ref;
      if (!map.has(key)) map.set(key, []);
      map.get(key)!.push(r);
    });
    return [...map.entries()]
      .sort(([, a], [, b]) => {
        // Sort groups by red count descending
        const aRed = a.filter((r) => r.risk_level === 'red').length;
        const bRed = b.filter((r) => r.risk_level === 'red').length;
        return bRed - aRed;
      })
      .map(([key, rows]) => ({ key, rows }));
  }, [filtered, groupBy]);

  const redCount = filtered.filter((r) => r.risk_level === 'red').length;
  const yellowCount = filtered.filter((r) => r.risk_level === 'yellow').length;

  // Stack toggle
  const handleStackToggle = useCallback(async (vendorId: string) => {
    const isRemoving = stack.has(vendorId);
    setStack((prev) => {
      const next = new Set(prev);
      if (isRemoving) next.delete(vendorId); else next.add(vendorId);
      return next;
    });
    try {
      await fetch('/api/portfolio', {
        method: isRemoving ? 'DELETE' : 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ vendor_id: vendorId }),
      });
    } catch {
      setStack((prev) => {
        const next = new Set(prev);
        if (isRemoving) next.add(vendorId); else next.delete(vendorId);
        return next;
      });
    }
  }, [stack]);

  return (
    <div>
      {/* ── Summary ────────────────────────────────────────────── */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-8">
        {[
          { value: redCount, label: 'High-risk findings', sub: 'Deployer action required before August 2' },
          { value: yellowCount, label: 'Medium-risk findings', sub: 'Configuration audit recommended' },
          { value: 78, label: 'Days to enforcement', sub: 'EU AI Act Articles 9-15 take effect' },
        ].map(({ value, label, sub }) => (
          <article key={label} style={{ background: 'var(--mist)', borderRadius: '8px', padding: '1.5rem 1.75rem' }}>
            <div className="text-[clamp(2.25rem,4vw,3rem)] font-medium leading-none tracking-tight tabular-nums mb-2" style={{ fontFamily: 'var(--font-mono)', color: 'var(--coal)' }}>{value}</div>
            <div className="eyebrow" style={{ color: 'var(--slate)', textTransform: 'uppercase', marginBottom: '0.25rem' }}>{label}</div>
            <div className="text-[0.8rem]" style={{ color: 'var(--slate)', lineHeight: 1.4 }}>{sub}</div>
          </article>
        ))}
      </div>

      {/* ── Filters ────────────────────────────────────────────── */}
      <div className="flex items-center gap-4 flex-wrap pb-4 mb-0" style={{ borderBottom: 'var(--border-rule)' }}>
        <FilterSelect label="Vendor" value={filterVendor} onChange={setFilterVendor}
          options={[{ value: 'all', label: `All (${rows.length})` }, ...vendors.map((v) => ({ value: v, label: v }))]} />
        <FilterSelect label="Risk" value={filterRisk} onChange={setFilterRisk}
          options={[{ value: 'all', label: 'All' }, { value: 'red', label: 'High' }, { value: 'yellow', label: 'Medium' }]} />
        <FilterSelect label="Annex III" value={filterAnnex} onChange={setFilterAnnex}
          options={[{ value: 'all', label: 'All categories' }, ...annexRefs.map((a) => ({ value: a, label: a }))]} />
        <FilterSelect label="Domain" value={filterCategory} onChange={setFilterCategory}
          options={[{ value: 'all', label: 'All domains' }, ...categories.map((c) => ({ value: c, label: c }))]} />
        <FilterSelect label="Group by" value={groupBy} onChange={(v) => setGroupBy(v as GroupBy)}
          options={[{ value: 'vendor', label: 'Vendor' }, { value: 'annex', label: 'Annex III ref' }, { value: 'category', label: 'Category' }, { value: 'none', label: 'None (flat)' }]} />

        <span className="ml-auto flex items-center gap-4 text-[0.75rem]" style={{ color: 'var(--slate)', fontFamily: 'var(--font-mono)' }}>
          {stack.size > 0 && <span style={{ color: 'var(--oak)' }}>My Stack: {stack.size}</span>}
          <span>{filtered.length} findings</span>
        </span>
      </div>

      {/* ── Table ──────────────────────────────────────────────── */}
      <div className="mt-0 overflow-x-auto" style={{ borderRadius: '8px', border: 'var(--border-rule)' }}>
        <table className="w-full border-collapse text-[0.8rem]" style={{ minWidth: '1080px' }}>
          <thead>
            <tr style={{ background: 'var(--coal)' }}>
              {[
                ['', '3%'],
                ['Vendor', '13%'],
                ['Feature', '22%'],
                ['Risk', '7%'],
                ['Default state', '12%'],
                ['Annex III', '16%'],
                ['Deployer obligation gap', '27%'],
              ].map(([label, width]) => (
                <th key={label || 'stack'} style={{ width, color: 'var(--paper)' }}
                  className="font-medium text-[0.68rem] uppercase tracking-[0.05em] text-left px-3 py-3 align-middle">
                  {label}
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {grouped.map(({ key, rows: groupRows }) => (
              <>
                {/* Group header */}
                {groupBy !== 'none' && (
                  <tr key={`group-${key}`}>
                    <td colSpan={7} className="px-4 py-2.5" style={{ background: 'rgba(138,107,74,0.08)', borderBottom: 'var(--border-hairline)' }}>
                      <span className="font-medium text-[0.82rem]" style={{ color: 'var(--coal)' }}>{key}</span>
                      <span className="ml-2 text-[0.72rem]" style={{ color: 'var(--slate)', fontFamily: 'var(--font-mono)' }}>
                        {groupRows.length} findings · {groupRows.filter((r) => r.risk_level === 'red').length} high-risk
                      </span>
                    </td>
                  </tr>
                )}
                {groupRows.map((row, i) => (
                  <tr key={row.id} style={{
                    background: i % 2 === 0 ? '#fff' : 'var(--mist)',
                    borderBottom: 'var(--border-hairline)',
                    ...(row.risk_level === 'red' ? { boxShadow: 'inset 3px 0 0 0 var(--coal)' } : {}),
                  }}>
                    <td className="px-3 py-3 align-top text-center">
                      <StackToggle vendorId={row.vendor_id} vendorName={row.vendor_name}
                        isInStack={stack.has(row.vendor_id)} onToggle={handleStackToggle} />
                    </td>
                    <td className="px-3 py-3 align-top">
                      <span className="font-medium text-[0.82rem]" style={{ color: 'var(--coal)' }}>{row.vendor_name}</span>
                    </td>
                    <td className="px-3 py-3 align-top">
                      <span className="font-medium" style={{ color: 'var(--coal)' }}>{row.feature_name}</span>
                      {row.feature_desc && <span className="block mt-0.5 text-[0.74rem]" style={{ color: 'var(--slate)' }}>{row.feature_desc}</span>}
                    </td>
                    <td className="px-3 py-3 align-top"><RiskIndicator level={row.risk_level} /></td>
                    <td className="px-3 py-3 align-top"><StateCell state={row.default_state} note={row.default_state_note ?? undefined} /></td>
                    <td className="px-3 py-3 align-top">
                      <span className="meta" style={{ color: 'var(--coal)' }}>{row.annex_iii_ref}</span>
                      <span className="block text-[0.72rem] mt-0.5" style={{ color: 'var(--slate)' }}>{row.annex_iii_category}</span>
                    </td>
                    <td className="px-3 py-3 align-top">
                      <span className="text-[0.78rem] leading-relaxed" style={{ color: 'var(--coal)' }}>{row.deployer_obligation_gap}</span>
                    </td>
                  </tr>
                ))}
              </>
            ))}
          </tbody>
        </table>

        {filtered.length === 0 && (
          <div className="py-10 text-center" style={{ color: 'var(--slate)' }}>No findings match your filters.</div>
        )}
      </div>
    </div>
  );
}
