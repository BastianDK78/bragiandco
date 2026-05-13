'use client';

import { useState, useMemo } from 'react';
import type { FindingRow } from '@/data/heatmap.types';

// ── Risk badge ─────────────────────────────────────────────────────────────

function RiskPill({ level }: { level: FindingRow['risk_level'] }) {
  const styles = {
    red:        'bg-[#C0392B] text-white',
    yellow:     'bg-[#C4985A] text-[#1C1C1C]',
    unverified: 'bg-[#C4B8A0] text-[#1C1C1C]',
  };
  const labels = { red: 'Red', yellow: 'Yellow', unverified: 'Unverified' };
  return (
    <span className={`inline-flex items-center text-[0.62rem] font-bold tracking-[0.07em] uppercase
                      rounded-full px-[0.7em] py-[0.22em] whitespace-nowrap ${styles[level]}`}>
      {labels[level]}
    </span>
  );
}

// ── Default state cell ──────────────────────────────────────────────────────

function StateCell({ state, note }: { state: string; note?: string }) {
  const isOn = state === 'On by default' || state === 'On when feature licensed';
  const isOptIn = state === 'Opt-in';

  return (
    <span className={`text-[0.78rem] leading-snug ${
      isOn     ? 'text-[#B0864A] font-bold' :
      isOptIn  ? 'text-[#9B9B8C]' :
                 'text-[#9B9B8C] italic'
    }`}>
      {state}
      {note && (
        <span className="block mt-0.5 font-normal not-italic text-[0.7rem] text-[#9B9B8C]">
          {note}
        </span>
      )}
    </span>
  );
}

// ── Main component ──────────────────────────────────────────────────────────

interface Props {
  rows: FindingRow[];
}

export function HeatmapTable({ rows }: Props) {
  const [filterVendor, setFilterVendor] = useState<string>('all');
  const [filterRisk, setFilterRisk] = useState<string>('all');

  // Derive vendor list from live data — stays in sync as DB grows
  const vendors = useMemo(
    () => [...new Set(rows.map((r) => r.vendor_name))],
    [rows]
  );

  const filtered = useMemo(() => rows.filter((r) => {
    if (filterVendor !== 'all' && r.vendor_name !== filterVendor) return false;
    if (filterRisk   !== 'all' && r.risk_level  !== filterRisk)   return false;
    return true;
  }), [rows, filterVendor, filterRisk]);

  const redCount    = filtered.filter((r) => r.risk_level === 'red').length;
  const yellowCount = filtered.filter((r) => r.risk_level === 'yellow').length;

  return (
    <div>
      {/* ── Summary strip ──────────────────────────────────────────── */}
      <div className="grid grid-cols-3 gap-4 mb-6">
        {([
          { value: redCount,    label: 'Red findings',         sub: 'Immediate deployer action required',          numClass: 'text-[#B0864A]' },
          { value: yellowCount, label: 'Yellow findings',      sub: 'Confirm feature configuration in admin',      numClass: 'text-[#1C1C1C]' },
          { value: 81,          label: 'Days to enforcement',  sub: 'August 2, 2026 — Articles 9-15 in force',     numClass: 'text-[#B0864A]' },
        ] as const).map(({ value, label, sub, numClass }) => (
          <article
            key={label}
            className="bg-white border-t-[3px] border-[#C4985A] rounded-[2px] px-6 py-5"
          >
            <div className={`text-[clamp(2.5rem,4.5vw,3.4rem)] font-extrabold leading-none tracking-tight tabular-nums mb-3 ${numClass}`}>
              {value}
            </div>
            <div className="text-[0.7rem] font-bold uppercase tracking-[0.1em] text-[#9B9B8C] mb-1">
              {label}
            </div>
            <div className="text-[0.82rem] text-[#9B9B8C] leading-snug">{sub}</div>
          </article>
        ))}
      </div>

      {/* ── Filter bar ─────────────────────────────────────────────── */}
      <div className="flex items-center gap-6 flex-wrap pb-4 mb-0 border-b border-[#C4B8A0]">
        {/* Vendor pills */}
        <div className="flex flex-wrap gap-1.5 flex-1 min-w-0">
          {(['all', ...vendors]).map((v) => (
            <button
              key={v}
              onClick={() => setFilterVendor(v)}
              className={`text-[0.72rem] font-medium px-[0.85rem] py-[0.35rem] rounded-full
                          border border-[#C4985A] transition-colors whitespace-nowrap
                          ${filterVendor === v
                            ? 'bg-[#C4985A] text-[#F5F0E8] font-bold'
                            : 'bg-transparent text-[#1C1C1C] hover:bg-[#C4985A]/10'}`}
            >
              {v === 'all' ? 'All vendors' : v}
            </button>
          ))}
        </div>

        {/* Risk dropdown */}
        <div className="flex items-center gap-2 shrink-0">
          <label className="text-[0.68rem] font-bold uppercase tracking-[0.08em] text-[#9B9B8C]">
            Risk
          </label>
          <select
            value={filterRisk}
            onChange={(e) => setFilterRisk(e.target.value)}
            className="font-[Inter,sans-serif] text-[0.78rem] font-medium text-[#1C1C1C]
                       bg-white border border-[#C4985A] rounded-[2px] px-3 py-1.5 pr-8
                       appearance-none cursor-pointer
                       bg-[url('data:image/svg+xml;utf8,<svg xmlns=%22http://www.w3.org/2000/svg%22 width=%2210%22 height=%226%22 viewBox=%220 0 10 6%22><path d=%22M1 1l4 4 4-4%22 stroke=%22%23C4985A%22 stroke-width=%221.5%22 fill=%22none%22 stroke-linecap=%22square%22/></svg>')]
                       bg-no-repeat bg-[right_0.7rem_center]"
          >
            <option value="all">All</option>
            <option value="red">Red</option>
            <option value="yellow">Yellow</option>
            <option value="unverified">Unverified</option>
          </select>
        </div>
      </div>

      {/* ── Table ──────────────────────────────────────────────────── */}
      <div className="mt-0 overflow-x-auto border border-[#C4B8A0] rounded-[2px] bg-white">
        <table className="w-full border-collapse text-[0.82rem]" style={{ minWidth: '1120px' }}>
          <thead>
            <tr>
              {[
                ['Vendor',                  '13%'],
                ['Feature / AI Capability', '25%'],
                ['Risk',                    '9%'],
                ['Default state',           '12%'],
                ['Annex III category',      '16%'],
                ['Deployer obligation gap', '25%'],
              ].map(([label, width]) => (
                <th
                  key={label}
                  style={{ width }}
                  className="bg-[#1C1C1C] text-[#F5F0E8] font-bold text-[0.66rem] uppercase
                             tracking-[0.08em] text-left px-4 py-[0.85rem] align-middle
                             first:pl-5 last:pr-5"
                >
                  {label}
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {filtered.map((row, i) => (
              <tr
                key={row.id}
                className={`border-b border-[rgba(196,184,160,0.2)] transition-colors
                            hover:bg-[#EFE9DE]
                            ${row.risk_level === 'red'
                              ? 'shadow-[inset_2px_0_0_0_#C0392B] hover:bg-[rgba(192,57,43,0.04)]'
                              : ''}
                            ${i % 2 === 1 ? 'bg-[rgba(196,184,160,0.2)]' : 'bg-white'}`}
              >
                {/* Vendor */}
                <td className="px-4 py-4 align-top first:pl-5">
                  <span className="font-bold text-[#1C1C1C] text-[0.85rem]">{row.vendor_name}</span>
                </td>

                {/* Feature */}
                <td className="px-4 py-4 align-top">
                  <span className="font-medium text-[#1C1C1C]">{row.feature_name}</span>
                  {row.feature_desc && (
                    <span className="block mt-0.5 text-[#9B9B8C] text-[0.78rem]">
                      {row.feature_desc}
                    </span>
                  )}
                </td>

                {/* Risk */}
                <td className="px-4 py-4 align-top">
                  <RiskPill level={row.risk_level} />
                </td>

                {/* Default state */}
                <td className="px-4 py-4 align-top">
                  <StateCell state={row.default_state} note={row.default_state_note ?? undefined} />
                </td>

                {/* Annex III */}
                <td className="px-4 py-4 align-top">
                  <span className="font-medium text-[#1C1C1C] text-[0.78rem]">
                    {row.annex_iii_ref}
                    <span className="block text-[#9B9B8C] font-normal text-[0.74rem] mt-0.5">
                      {row.annex_iii_category}
                    </span>
                  </span>
                </td>

                {/* Obligation gap */}
                <td className="px-4 py-4 align-top last:pr-5">
                  <span className="text-[#1C1C1C] leading-relaxed">{row.deployer_obligation_gap}</span>
                </td>
              </tr>
            ))}
          </tbody>
        </table>

        {filtered.length === 0 && (
          <div className="py-10 text-center text-[#9B9B8C] text-[0.9rem]">
            <strong className="text-[#1C1C1C] font-bold">No findings match your filters.</strong>
            <br />
            Try selecting <em>All vendors</em> or resetting the risk level to <em>All</em>.
          </div>
        )}
      </div>
    </div>
  );
}
