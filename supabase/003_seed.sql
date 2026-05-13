-- ============================================================
-- Seed: 8 vendors + 20 findings (Version 1.0, May 2026)
-- Run after 002_findings.sql
-- ============================================================

-- ── Vendors ────────────────────────────────────────────────

INSERT INTO vendors (id, name, hq_country, website, product_category) VALUES
  ('workday',              'Workday',             'US', 'https://workday.com',             'hris'),
  ('sap-successfactors',   'SAP SuccessFactors',  'DE', 'https://successfactors.com',      'hris'),
  ('oracle-hcm',           'Oracle HCM',          'US', 'https://oracle.com/human-capital', 'hris'),
  ('hirevue',              'HireVue',             'US', 'https://hirevue.com',             'ats'),
  ('greenhouse',           'Greenhouse',          'US', 'https://greenhouse.com',          'ats'),
  ('lattice',              'Lattice',             'US', 'https://lattice.com',             'performance'),
  ('microsoft-viva',       'Microsoft Viva',      'US', 'https://microsoft.com/viva',      'hris'),
  ('nice-cxone',           'NICE CXone',          'IL', 'https://nice.com/cxone',          'cx')
ON CONFLICT (id) DO NOTHING;

-- ── Findings ───────────────────────────────────────────────

INSERT INTO heatmap_findings
  (vendor_id, feature_name, feature_desc, risk_level, default_state, default_state_note,
   annex_iii_ref, annex_iii_category, deployer_obligation_gap,
   confidence, published, display_order, version)
VALUES

-- Workday
('workday', 'Recruiting Agent', 'CV screening and candidate ranking',
  'red', 'On by default', NULL,
  '§4(a)', 'Recruitment',
  'Art. 9 risk register · Art. 13 applicant notice · Art. 14 override process documented',
  'verified', true, 10, '1.0'),

('workday', 'Talent Mobility Agent', 'Internal mobility recommendations',
  'yellow', 'Opt-in', NULL,
  '§4(b)', 'Employment management',
  'Confirm feature active · Art. 13 employee notice if active',
  'verified', true, 20, '1.0'),

-- SAP SuccessFactors
('sap-successfactors', 'Joule', 'AI performance review summaries',
  'yellow', 'On by default', '(Joule enabled tenants)',
  '§4(b)', 'Employment management',
  'Art. 13 employee notice · Art. 14 oversight for performance decisions',
  'verified', true, 30, '1.0'),

('sap-successfactors', 'Candidate Matching', 'CV-to-role fit scoring',
  'yellow', 'Opt-in', NULL,
  '§4(a)', 'Recruitment',
  'Confirm configuration · Art. 13 applicant notice if active',
  'verified', true, 40, '1.0'),

('sap-successfactors', 'Sentiment Analysis', '360-degree review feedback',
  'yellow', 'Opt-in', NULL,
  '§4(b)', 'Employment management',
  'Confirm configuration · Art. 13 employee notice if active',
  'verified', true, 50, '1.0'),

-- Oracle HCM
('oracle-hcm', 'Job Applicant Score', 'Application fit scoring',
  'yellow', 'Opt-in', NULL,
  '§4(a)', 'Recruitment',
  'Confirm configuration · Art. 13 applicant notice if active',
  'verified', true, 60, '1.0'),

('oracle-hcm', 'Dynamic Skills Graph', 'Workforce skills inference',
  'yellow', 'On by default', NULL,
  '§4(b)', 'Employment management',
  'Art. 9 entry · Art. 13 employee notice',
  'verified', true, 70, '1.0'),

-- HireVue
('hirevue', 'AI-Scored Video Interviews', 'Competency assessment',
  'yellow', 'On when feature licensed', NULL,
  '§4(a)', 'Recruitment',
  'Art. 13 applicant notice · Art. 14 interviewer override process',
  'verified', true, 80, '1.0'),

('hirevue', 'Game-Based Assessments', 'Cognitive trait scoring',
  'yellow', 'On when feature licensed', NULL,
  '§4(a)', 'Recruitment',
  'Art. 13 applicant notice · confirm vendor bias audit documentation',
  'verified', true, 90, '1.0'),

-- Greenhouse
('greenhouse', 'Talent Rediscovery', 'Past applicant relevance ranking',
  'yellow', 'Opt-in', NULL,
  '§4(a)', 'Recruitment',
  'Confirm configuration · Art. 13 applicant notice if active',
  'verified', true, 100, '1.0'),

('greenhouse', 'Resume Review', 'AI-assisted CV screening',
  'yellow', 'Opt-in', NULL,
  '§4(a)', 'Recruitment',
  'Confirm configuration · Art. 13 applicant notice if active',
  'verified', true, 110, '1.0'),

-- Lattice
('lattice', 'AI Performance Review Summaries', NULL,
  'yellow', 'On by default', NULL,
  '§4(b)', 'Employment management',
  'Art. 13 employee notice · Art. 14 manager override documented',
  'verified', true, 120, '1.0'),

('lattice', 'Team Health AI Signals', 'Engagement risk scoring',
  'yellow', 'On by default', NULL,
  '§4(b)', 'Employment management',
  'Art. 13 employee notice · confirm individual vs. aggregated scope',
  'verified', true, 130, '1.0'),

-- Microsoft Viva
('microsoft-viva', 'Insights — Manager Effectiveness', 'Manager effectiveness scoring',
  'yellow', 'On by default', '(M365 E3/E5)',
  '§4(b)', 'Employment management',
  'Art. 13 manager notice · confirm EU employee data in scope',
  'verified', true, 140, '1.0'),

('microsoft-viva', 'Insights — Work Pattern Analysis', 'Employee-level work patterns',
  'yellow', 'On by default', '(M365 E3/E5)',
  '§4(b)', 'Employment management',
  'Art. 13 employee notice · confirm individual vs. team aggregation setting',
  'verified', true, 150, '1.0'),

('microsoft-viva', 'Insights — Performance Insights', 'Manager-facing performance signals',
  'yellow', 'On by default', '(M365 E3/E5)',
  '§4(b)', 'Employment management',
  'Art. 13 employee notice · Art. 14 manager review process',
  'verified', true, 160, '1.0'),

-- NICE CXone
('nice-cxone', 'Real-Time Voice Emotion Detection', 'Customer calls',
  'red', 'On when feature licensed', NULL,
  '§1(c)', 'Biometric categorisation',
  'Art. 13 customer call disclosure · update call recording notice before Aug 2',
  'verified', true, 170, '1.0'),

('nice-cxone', 'Facial Expression Analysis', 'Customer video',
  'red', 'On when feature licensed', NULL,
  '§1(c)', 'Biometric categorisation',
  'Art. 13 customer video consent screen · explicit AI analysis disclosure',
  'verified', true, 180, '1.0'),

('nice-cxone', 'Agent Soft-Skill Behaviour Analysis', 'CSAT add-on',
  'yellow', 'On when feature licensed', NULL,
  '§4(b)', 'Employment management',
  'Art. 13 employee notice · Art. 14 QA supervisor override documented',
  'verified', true, 190, '1.0'),

('nice-cxone', 'Agent Emotion Monitoring', 'Employee-side',
  'unverified', 'Unknown', NULL,
  'Art. 5(1)(f)', 'Candidate — under review',
  'Tier 1 source not yet confirmed · do not deploy pending legal review',
  'unverified', true, 200, '1.0')

ON CONFLICT DO NOTHING;
