import type { RiskLevel } from '@/data/heatmap.types';

const CONFIG: Record<RiskLevel, { label: string; bg: string; text: string }> = {
  red: { label: 'RED', bg: '#C0392B', text: '#FFFFFF' },
  yellow: { label: 'YELLOW', bg: '#C4985A', text: '#1C1C1C' },
  unverified: { label: 'UNVERIFIED', bg: '#C4B8A0', text: '#1C1C1C' },
};

export function RiskBadge({ level }: { level: RiskLevel }) {
  const { label, bg, text } = CONFIG[level];
  return (
    <span
      style={{ backgroundColor: bg, color: text }}
      className="inline-block text-[10px] font-bold uppercase tracking-wider
                 px-2.5 py-0.5 rounded-full whitespace-nowrap"
    >
      {label}
    </span>
  );
}
