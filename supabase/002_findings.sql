-- ============================================================
-- Migration 002: Vendor + findings tables
-- Run after 001_auth.sql
-- ============================================================

-- ── Vendors ────────────────────────────────────────────────
-- slug primary key ("workday", "sap-successfactors") keeps
-- JOINs human-readable and enables /heatmap/:vendor routes.

CREATE TYPE product_category AS ENUM
  ('hris', 'ats', 'performance', 'cx', 'erp', 'crm', 'other');

CREATE TABLE IF NOT EXISTS vendors (
  id               TEXT PRIMARY KEY,             -- slug
  name             TEXT NOT NULL,
  hq_country       TEXT,
  website          TEXT,
  product_category product_category NOT NULL,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ── Heatmap findings ───────────────────────────────────────

CREATE TYPE risk_level  AS ENUM ('red', 'yellow', 'unverified');
CREATE TYPE source_type AS ENUM ('tier1', 'tier2', 'tier3');
CREATE TYPE confidence  AS ENUM ('verified', 'likely', 'unverified');

CREATE TABLE IF NOT EXISTS heatmap_findings (
  id                      UUID    PRIMARY KEY DEFAULT gen_random_uuid(),
  vendor_id               TEXT    NOT NULL REFERENCES vendors(id) ON DELETE CASCADE,
  feature_name            TEXT    NOT NULL,
  feature_desc            TEXT,                           -- optional sub-description
  risk_level              risk_level  NOT NULL,
  default_state           TEXT    NOT NULL,
  default_state_note      TEXT,                           -- parenthetical qualifier
  annex_iii_ref           TEXT    NOT NULL,               -- "§4(a)", "§1(c)", etc.
  annex_iii_category      TEXT    NOT NULL,               -- "Recruitment", etc.
  deployer_obligation_gap TEXT    NOT NULL,
  source_url              TEXT,
  source_type             source_type,
  last_verified_date      DATE,
  confidence              confidence NOT NULL DEFAULT 'verified',
  published               BOOLEAN NOT NULL DEFAULT false, -- controls product visibility
  version                 TEXT    NOT NULL DEFAULT '1.0',
  display_order           INTEGER NOT NULL DEFAULT 0,     -- row sort order
  notes                   TEXT,                           -- internal analyst notes
  created_at              TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at              TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_findings_vendor_id     ON heatmap_findings(vendor_id);
CREATE INDEX IF NOT EXISTS idx_findings_risk_level    ON heatmap_findings(risk_level);
CREATE INDEX IF NOT EXISTS idx_findings_published     ON heatmap_findings(published);
CREATE INDEX IF NOT EXISTS idx_findings_display_order ON heatmap_findings(display_order);

-- Auto-update updated_at on row change
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;

CREATE TRIGGER findings_updated_at
  BEFORE UPDATE ON heatmap_findings
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

ALTER TABLE vendors          ENABLE ROW LEVEL SECURITY;
ALTER TABLE heatmap_findings ENABLE ROW LEVEL SECURITY;
-- Service role key bypasses RLS — no public policies needed.
