import { createSupabaseClient } from './supabase';
import type { FindingRow, Vendor } from '@/data/heatmap.types';

/**
 * Fetch all published findings, joined with vendor names, ordered by display_order.
 * Called server-side only (uses service role key).
 */
export async function getPublishedFindings(): Promise<FindingRow[]> {
  const supabase = createSupabaseClient();

  const { data, error } = await supabase
    .from('heatmap_findings')
    .select(`
      id,
      vendor_id,
      vendors ( name ),
      feature_name,
      feature_desc,
      risk_level,
      default_state,
      default_state_note,
      annex_iii_ref,
      annex_iii_category,
      deployer_obligation_gap,
      source_url,
      source_type,
      last_verified_date,
      confidence,
      published,
      display_order,
      version
    `)
    .eq('published', true)
    .order('display_order', { ascending: true });

  if (error) throw new Error(`getPublishedFindings: ${error.message}`);

  // Supabase returns the joined vendor as a nested object — flatten it.
  return (data ?? []).map((row) => ({
    ...row,
    vendor_name: (row.vendors as unknown as { name: string } | null)?.name ?? row.vendor_id,
    vendors: undefined,
  })) as FindingRow[];
}

/**
 * Fetch all vendors ordered alphabetically.
 * Used to populate filter pills server-side so they're never stale.
 */
export async function getVendors(): Promise<Vendor[]> {
  const supabase = createSupabaseClient();
  const { data, error } = await supabase
    .from('vendors')
    .select('id, name, hq_country, website, product_category')
    .order('name', { ascending: true });

  if (error) throw new Error(`getVendors: ${error.message}`);
  return (data ?? []) as Vendor[];
}
