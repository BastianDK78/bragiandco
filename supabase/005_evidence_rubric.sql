-- ============================================================
-- Migration 005: Evidence chain + quality rubric
-- Run after 004_seed_cx_procurement.sql
-- ============================================================

-- ── Verification method enum ──────────────────────────────
CREATE TYPE verification_method AS ENUM (
  'hands_on_testing',     -- direct admin console / feature walkthrough
  'vendor_documentation', -- official release notes, whitepapers, help docs
  'vendor_confirmation',  -- direct reply from vendor rep
  'community_report',     -- trusted community source, analyst blog, conference talk
  'regulatory_filing',    -- EU AI Office registration, conformity assessment
  'analyst_inference'     -- inferred from feature description, not directly confirmed
);

-- ── Source tier rubric (reference, not enforced in code) ───
-- tier1: primary source — hands-on testing, vendor documentation,
--        vendor confirmation, regulatory filing
-- tier2: corroborating source — community report from named analyst
--        or reputable publication, cross-referenced with tier1
-- tier3: indicative only — analyst inference, anonymous report,
--        marketing material without technical detail

-- ── Finding sources table ─────────────────────────────────
CREATE TABLE IF NOT EXISTS finding_sources (
  id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  finding_id          UUID NOT NULL REFERENCES heatmap_findings(id) ON DELETE CASCADE,
  source_type         source_type NOT NULL,
  verification_method verification_method NOT NULL,
  url                 TEXT,                       -- source URL (NULL for hands-on testing)
  title               TEXT,                       -- human-readable label ("Workday 2026R1 Release Notes")
  access_date         DATE NOT NULL,              -- when the source was accessed/tested
  verified_by         TEXT NOT NULL,              -- analyst identifier
  excerpt             TEXT,                       -- relevant quote or observation
  notes               TEXT,                       -- internal context
  created_at          TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_sources_finding_id ON finding_sources(finding_id);
CREATE INDEX IF NOT EXISTS idx_sources_type       ON finding_sources(source_type);

-- ── Add verified_by + verification_status to findings ─────
-- These summarise the best evidence available per finding.
ALTER TABLE heatmap_findings
  ADD COLUMN IF NOT EXISTS verified_by          TEXT,
  ADD COLUMN IF NOT EXISTS verification_method  verification_method;

-- ── RLS ───────────────────────────────────────────────────
ALTER TABLE finding_sources ENABLE ROW LEVEL SECURITY;

-- ── View: findings with source count + best source tier ───
CREATE OR REPLACE VIEW findings_evidence_summary AS
SELECT
  f.id AS finding_id,
  f.vendor_id,
  f.feature_name,
  f.risk_level,
  f.confidence,
  f.verified_by AS finding_verified_by,
  count(fs.id) AS source_count,
  min(fs.source_type::text) AS best_source_tier,  -- tier1 < tier2 < tier3 alphabetically
  max(fs.access_date) AS latest_source_date
FROM heatmap_findings f
LEFT JOIN finding_sources fs ON fs.finding_id = f.id
GROUP BY f.id, f.vendor_id, f.feature_name, f.risk_level, f.confidence, f.verified_by;