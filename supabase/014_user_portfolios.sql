-- ============================================================
-- Migration 014: User portfolios ("My Stack")
-- Allows users to save vendors to their profile for monitoring
-- ============================================================

CREATE TABLE IF NOT EXISTS user_portfolios (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id    UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  vendor_id  TEXT NOT NULL REFERENCES vendors(id) ON DELETE CASCADE,
  added_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(user_id, vendor_id)
);

CREATE INDEX IF NOT EXISTS idx_portfolios_user   ON user_portfolios(user_id);
CREATE INDEX IF NOT EXISTS idx_portfolios_vendor ON user_portfolios(vendor_id);

ALTER TABLE user_portfolios ENABLE ROW LEVEL SECURITY;

-- View: portfolio with rolled-up finding counts per user
CREATE OR REPLACE VIEW user_portfolio_summary AS
SELECT
  up.user_id,
  up.vendor_id,
  v.name AS vendor_name,
  v.product_category,
  count(f.id) AS finding_count,
  count(f.id) FILTER (WHERE f.risk_level = 'red') AS red_count,
  count(f.id) FILTER (WHERE f.risk_level = 'yellow') AS yellow_count,
  up.added_at
FROM user_portfolios up
JOIN vendors v ON v.id = up.vendor_id
LEFT JOIN heatmap_findings f ON f.vendor_id = up.vendor_id AND f.published = true
GROUP BY up.user_id, up.vendor_id, v.name, v.product_category, up.added_at;
