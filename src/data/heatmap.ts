// This file is the canonical source of truth for the seed data.
// It is NOT imported in UI code — findings are fetched from Supabase at runtime.
// To re-seed: copy the contents of supabase/003_seed.sql into Supabase SQL Editor.
//
// Kept here as a human-readable reference alongside the SQL seed file.

export const SEED_METADATA = {
  version: '1.0',
  lastVerified: '2026-05-12',
  vendorCount: 8,
  findingCount: 20,
};
