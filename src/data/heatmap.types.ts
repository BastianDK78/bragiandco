// Matches the heatmap_findings JOIN vendors query result from Supabase.

export type RiskLevel  = 'red' | 'yellow' | 'unverified';
export type SourceType = 'tier1' | 'tier2' | 'tier3';
export type Confidence = 'verified' | 'likely' | 'unverified';

export interface FindingRow {
  id: string;                        // UUID
  vendor_id: string;                 // slug ("workday")
  vendor_name: string;               // display name ("Workday") — joined from vendors
  feature_name: string;
  feature_desc?: string | null;
  risk_level: RiskLevel;
  default_state: string;
  default_state_note?: string | null;
  annex_iii_ref: string;
  annex_iii_category: string;
  deployer_obligation_gap: string;
  source_url?: string | null;
  source_type?: SourceType | null;
  last_verified_date?: string | null;
  confidence: Confidence;
  published: boolean;
  display_order: number;
  version: string;
}

export interface Vendor {
  id: string;
  name: string;
  hq_country?: string | null;
  website?: string | null;
  product_category: string;
}
