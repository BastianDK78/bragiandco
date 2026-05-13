-- ============================================================
-- Seed: CX + ERP/Procurement vendors and findings (v1.1)
-- Run after 003_seed.sql
-- ============================================================

-- ── Extend product_category enum ──────────────────────────
ALTER TYPE product_category ADD VALUE IF NOT EXISTS 'procurement';

-- ── CX Vendors ────────────────────────────────────────────

INSERT INTO vendors (id, name, hq_country, website, product_category) VALUES
  ('salesforce-service',   'Salesforce Service Cloud',  'US', 'https://salesforce.com/service-cloud',   'cx'),
  ('zendesk',              'Zendesk',                   'US', 'https://zendesk.com',                    'cx'),
  ('genesys',              'Genesys Cloud CX',          'US', 'https://genesys.com/cloud',              'cx'),
  ('freshworks',           'Freshworks',                'IN', 'https://freshworks.com',                 'cx')
ON CONFLICT (id) DO NOTHING;

-- ── ERP / Procurement Vendors ─────────────────────────────

INSERT INTO vendors (id, name, hq_country, website, product_category) VALUES
  ('sap-ariba',            'SAP Ariba',                 'DE', 'https://ariba.com',                      'procurement'),
  ('coupa',                'Coupa',                     'US', 'https://coupa.com',                      'procurement'),
  ('oracle-procurement',   'Oracle Procurement Cloud',  'US', 'https://oracle.com/procurement',         'erp'),
  ('ivalua',               'Ivalua',                    'FR', 'https://ivalua.com',                     'procurement')
ON CONFLICT (id) DO NOTHING;

-- ── CX Findings ───────────────────────────────────────────

INSERT INTO heatmap_findings
  (vendor_id, feature_name, feature_desc, risk_level, default_state, default_state_note,
   annex_iii_ref, annex_iii_category, deployer_obligation_gap,
   confidence, published, display_order, version)
VALUES

-- Salesforce Service Cloud
('salesforce-service', 'Einstein Sentiment Analysis', 'Real-time customer sentiment scoring on cases and chat',
  'red', 'On by default', '(Service Cloud Einstein enabled orgs)',
  '§1(c)', 'Biometric categorisation',
  'Art. 13 customer disclosure in chat/email footer · Art. 9 risk register entry',
  'verified', true, 210, '1.1'),

('salesforce-service', 'Einstein Case Classification', 'Auto-routes and prioritises support cases',
  'yellow', 'On by default', '(Einstein enabled orgs)',
  '§4(b)', 'Employment management',
  'Art. 13 agent notice if classification drives performance metrics · confirm routing logic documented',
  'likely', true, 220, '1.1'),

('salesforce-service', 'Einstein Conversation Mining', 'Analyses transcripts for intent and emotion patterns',
  'red', 'Opt-in', NULL,
  '§1(c)', 'Biometric categorisation',
  'Art. 13 disclosure to both customer and agent · Art. 14 supervisor review of flagged transcripts',
  'likely', true, 230, '1.1'),

-- Zendesk
('zendesk', 'Intelligent Triage', 'Auto-classifies intent, language, and sentiment on tickets',
  'yellow', 'On by default', '(Suite Professional+)',
  '§1(c)', 'Biometric categorisation',
  'Art. 13 customer notice in ticket acknowledgement · confirm sentiment data retention policy',
  'verified', true, 240, '1.1'),

('zendesk', 'AI Agent (Answer Bot)', 'Autonomous resolution of customer queries',
  'yellow', 'On when feature licensed', NULL,
  '§4(b)', 'Employment management',
  'Art. 13 customer transparency notice (AI-generated response) · confirm escalation path documented',
  'verified', true, 250, '1.1'),

('zendesk', 'Agent Assist — Tone Shift', 'Suggests tone adjustments based on customer emotion',
  'yellow', 'On by default', '(AI add-on)',
  '§1(c)', 'Biometric categorisation',
  'Art. 13 agent notice on emotion inference · confirm no individual agent scoring from tone data',
  'likely', true, 260, '1.1'),

-- Genesys Cloud CX
('genesys', 'Speech & Text Analytics — Emotion Detection', 'Real-time emotion scoring on voice and chat',
  'red', 'On when feature licensed', NULL,
  '§1(c)', 'Biometric categorisation',
  'Art. 13 customer IVR disclosure before call · Art. 13 agent notice · Art. 9 risk register',
  'verified', true, 270, '1.1'),

('genesys', 'Agent Empathy Scoring', 'Scores agent empathy from voice and text cues',
  'red', 'On when feature licensed', NULL,
  '§1(c) + §4(b)', 'Biometric categorisation + Employment management',
  'Art. 13 agent notice · Art. 14 QA override process · dual scope: biometric + employment',
  'verified', true, 280, '1.1'),

('genesys', 'Predictive Engagement', 'Predicts customer outcome and routes to best agent',
  'yellow', 'Opt-in', NULL,
  '§4(b)', 'Employment management',
  'Art. 13 agent notice if routing affects performance metrics · confirm scoring transparency',
  'likely', true, 290, '1.1'),

('genesys', 'Workforce Forecasting AI', 'AI-driven staffing and schedule optimisation',
  'yellow', 'On by default', NULL,
  '§4(b)', 'Employment management',
  'Art. 13 employee notice · confirm no individual penalisation from forecast deviation',
  'likely', true, 300, '1.1'),

-- Freshworks
('freshworks', 'Freddy AI — Sentiment Analysis', 'Customer sentiment on tickets and chat',
  'yellow', 'On by default', '(Pro+ plans)',
  '§1(c)', 'Biometric categorisation',
  'Art. 13 customer disclosure · confirm sentiment not linked to agent performance scoring',
  'likely', true, 310, '1.1'),

('freshworks', 'Freddy AI — Auto Triage', 'AI ticket classification and priority scoring',
  'yellow', 'On by default', '(Pro+ plans)',
  '§4(b)', 'Employment management',
  'Confirm triage output not used in agent KPIs · Art. 13 agent notice if it is',
  'likely', true, 320, '1.1'),

('freshworks', 'Freddy AI — Canned Response Suggestions', 'AI-suggested replies based on ticket content',
  'yellow', 'On by default', '(Pro+ plans)',
  '§4(b)', 'Employment management',
  'Confirm suggestion acceptance rate not tracked per agent · lower risk if truly optional',
  'unverified', true, 330, '1.1'),

-- ── ERP / Procurement Findings ────────────────────────────

-- SAP Ariba
('sap-ariba', 'Supplier Risk Score', 'AI-generated composite risk rating per supplier',
  'red', 'On by default', NULL,
  '§5(b)', 'Access to essential services',
  'Art. 9 risk register · Art. 13 supplier notice of AI scoring · Art. 14 procurement review before exclusion',
  'verified', true, 340, '1.1'),

('sap-ariba', 'Guided Buying — AI Recommendations', 'Steers requisitioners to preferred suppliers',
  'yellow', 'On by default', NULL,
  '§5(b)', 'Access to essential services',
  'Confirm recommendation logic documented · Art. 13 notice if supplier ranking affects contract eligibility',
  'likely', true, 350, '1.1'),

('sap-ariba', 'Invoice Anomaly Detection', 'ML-flagged invoice exceptions',
  'yellow', 'On by default', NULL,
  '§5(b)', 'Access to essential services',
  'Confirm flagging thresholds documented · Art. 14 AP reviewer override before payment block',
  'likely', true, 360, '1.1'),

-- Coupa
('coupa', 'Risk Aware — Supplier Risk Scoring', 'Community-sourced and AI-scored supplier risk',
  'red', 'On by default', NULL,
  '§5(b)', 'Access to essential services',
  'Art. 9 risk register · Art. 13 supplier notice · Art. 14 procurement override before de-listing',
  'verified', true, 370, '1.1'),

('coupa', 'AI Spend Classification', 'Auto-categorises and enriches spend data',
  'yellow', 'On by default', NULL,
  '§5(b)', 'Access to essential services',
  'Lower direct risk, but confirm classification does not drive automated supplier payments/blocks',
  'likely', true, 380, '1.1'),

('coupa', 'Coupa AI — Contract Risk Analysis', 'AI-flagged risk clauses in supplier contracts',
  'yellow', 'Opt-in', NULL,
  '§5(b)', 'Access to essential services',
  'Confirm flagged clauses reviewed by legal · Art. 14 human decision on contract rejection',
  'likely', true, 390, '1.1'),

-- Oracle Procurement Cloud
('oracle-procurement', 'Supplier Qualification Intelligence', 'AI-scored supplier pre-qualification',
  'red', 'Opt-in', NULL,
  '§5(b)', 'Access to essential services',
  'Art. 9 risk register · Art. 13 supplier notice · Art. 14 procurement review before disqualification',
  'verified', true, 400, '1.1'),

('oracle-procurement', 'Smart Approvals', 'AI-driven approval routing and auto-approval thresholds',
  'yellow', 'Opt-in', NULL,
  '§5(b)', 'Access to essential services',
  'Confirm auto-approval thresholds documented · Art. 14 escalation path for flagged POs',
  'likely', true, 410, '1.1'),

-- Ivalua
('ivalua', 'Supplier 360 Risk Analytics', 'AI risk profiling across financial, ESG, and delivery metrics',
  'red', 'On by default', NULL,
  '§5(b)', 'Access to essential services',
  'Art. 9 risk register · Art. 13 supplier disclosure · Art. 14 category manager override before exclusion',
  'verified', true, 420, '1.1'),

('ivalua', 'AI-Assisted Sourcing Recommendations', 'Recommends suppliers for RFx shortlists',
  'yellow', 'Opt-in', NULL,
  '§5(b)', 'Access to essential services',
  'Confirm recommendation criteria transparent · Art. 14 sourcing lead reviews shortlist',
  'likely', true, 430, '1.1')

ON CONFLICT DO NOTHING;