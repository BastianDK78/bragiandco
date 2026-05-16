-- ============================================================
-- Seed 012: Batch 4 — 20 vendors/products (v1.4)
-- Multi-product expansion, European HR, Google, Talent,
-- Contact Center, Financial Services
-- Run enum ALTER TYPEs separately before this file.
-- ============================================================

-- ══════════════════════════════════════════════════════════════
-- VENDORS (14 new + 6 existing vendor products as new entries)
-- ══════════════════════════════════════════════════════════════

INSERT INTO vendors (id, name, hq_country, website, product_category) VALUES
  -- Multi-product expansion (new product lines from existing vendors)
  ('microsoft-entra',     'Microsoft Entra ID',        'US', 'https://microsoft.com/entra',             'itsm'),
  ('microsoft-purview',   'Microsoft Purview',         'US', 'https://microsoft.com/purview',           'other'),
  ('salesforce-marketing','Salesforce Marketing Cloud','US', 'https://salesforce.com/marketing-cloud',  'martech'),
  ('sap-concur',          'SAP Concur',               'DE', 'https://concur.com',                      'erp'),
  ('sap-fieldglass',      'SAP Fieldglass',           'DE', 'https://fieldglass.com',                  'talent'),
  ('oracle-cx',           'Oracle CX Unity',          'US', 'https://oracle.com/cx',                   'crm'),
  -- European HR
  ('personio',            'Personio',                  'DE', 'https://personio.com',                    'hris'),
  ('rippling',            'Rippling',                  'US', 'https://rippling.com',                    'hris'),
  -- Google
  ('google-workspace',    'Google Workspace (Gemini)', 'US', 'https://workspace.google.com',            'productivity'),
  ('google-talent',       'Google Cloud Talent Solution','US','https://cloud.google.com/talent-solution','ats'),
  -- Talent platforms
  ('phenom',              'Phenom',                    'US', 'https://phenom.com',                      'talent'),
  ('beamery',             'Beamery',                   'GB', 'https://beamery.com',                     'talent'),
  ('paradox',             'Paradox (Olivia)',          'US', 'https://paradox.ai',                      'ats'),
  ('shl',                 'SHL',                       'GB', 'https://shl.com',                         'ats'),
  ('textio',              'Textio',                    'US', 'https://textio.com',                      'ats'),
  -- Contact Center
  ('verint',              'Verint',                    'US', 'https://verint.com',                      'cx'),
  ('five9',               'Five9',                     'US', 'https://five9.com',                       'cx'),
  ('talkdesk',            'Talkdesk',                  'US', 'https://talkdesk.com',                    'cx'),
  -- Financial Services
  ('temenos',             'Temenos',                   'CH', 'https://temenos.com',                     'credit'),
  ('verisk',              'Verisk',                    'US', 'https://verisk.com',                      'credit')
ON CONFLICT (id) DO NOTHING;

-- ══════════════════════════════════════════════════════════════
-- FINDINGS
-- ══════════════════════════════════════════════════════════════

INSERT INTO heatmap_findings
  (vendor_id, feature_name, feature_desc, risk_level, default_state, default_state_note,
   annex_iii_ref, annex_iii_category, deployer_obligation_gap,
   confidence, published, display_order, version, verified_by, verification_method)
VALUES

-- ── Microsoft Multi-Product Expansion ─────────────────────

('microsoft-entra', 'Identity Protection Risk Scoring', 'ML-driven sign-in and user risk levels triggering access policies',
  'red', 'On by default', '(Entra ID P2 license; risk policies must be configured but risk detection is always-on)',
  '§4(b)', 'Employment management',
  'Art. 9 risk register · Art. 13 employee notice (identity monitored and risk-scored) · Art. 14 IT/HR review before employment action based on risk state · Individual-level scoring',
  'likely', true, 1210, '1.4', 'bg', 'analyst_inference'),

('microsoft-entra', 'Conditional Access — Risk-Based Policies', 'Automated access denial based on real-time risk assessment',
  'red', 'Opt-in', '(policies must be created by admin; risk signals feed automatically)',
  '§4(b)', 'Employment management',
  'Art. 9 risk register · Art. 13 employee notice · Art. 14 admin override/exclusion path · Can lock employee out of work tools based on AI risk score',
  'likely', true, 1220, '1.4', 'bg', 'analyst_inference'),

('microsoft-purview', 'Insider Risk Management', 'ML-scored insider risk indicators from employee activity signals',
  'red', 'Opt-in', '(requires policy configuration; signals auto-collected once enabled)',
  '§4(b)', 'Employment management',
  'Art. 9 risk register · Art. 13 employee notice (activity monitored) · Art. 14 HR/legal review before any action · Art. 15 risk indicator transparency · Individual employee risk profiling',
  'likely', true, 1230, '1.4', 'bg', 'analyst_inference'),

('microsoft-purview', 'Communication Compliance', 'AI-detected policy violations in employee communications',
  'yellow', 'Opt-in', '(requires policy setup specifying which users/channels to monitor)',
  '§4(b)', 'Employment management',
  'Art. 13 employee notice (communications monitored) · Art. 14 reviewer decision before disciplinary action · Transparency about which classifiers applied',
  'likely', true, 1240, '1.4', 'bg', 'analyst_inference'),

('salesforce-marketing', 'Einstein Engagement Scoring', 'ML-predicted likelihood of customer engagement (open, click, convert)',
  'yellow', 'On by default', '(Einstein enabled marketing orgs)',
  '§5(b)', 'Access to essential services',
  'Art. 13 notice if scoring drives service differentiation · Lower risk if marketing-only · Higher risk if engagement score gates offers or support tiers',
  'likely', true, 1250, '1.4', 'bg', 'analyst_inference'),

('salesforce-marketing', 'Einstein Send Time Optimization', 'ML-optimized delivery timing per recipient',
  'yellow', 'On by default', NULL,
  '§5(b)', 'Access to essential services',
  'Low direct risk — timing optimization. Higher risk if combined with engagement scoring to exclude disengaged segments from critical communications',
  'likely', true, 1260, '1.4', 'bg', 'analyst_inference'),

('sap-concur', 'Expense Fraud Detection AI', 'ML-flagged suspicious expense claims and duplicate submissions',
  'yellow', 'On by default', '(Concur Detect add-on)',
  '§4(b)', 'Employment management',
  'Art. 13 employee notice (expenses AI-monitored) · Art. 14 finance/HR review before investigation · Flags can trigger disciplinary proceedings',
  'likely', true, 1270, '1.4', 'bg', 'analyst_inference'),

('sap-concur', 'Audit Intelligence', 'AI-prioritized expense audit selection targeting high-risk submitters',
  'yellow', 'On by default', NULL,
  '§4(b)', 'Employment management',
  'Art. 13 employee notice · Art. 14 auditor review · Concern: disproportionate audit targeting based on AI profiling of employees',
  'likely', true, 1280, '1.4', 'bg', 'analyst_inference'),

('sap-fieldglass', 'Worker Intelligence', 'AI matching and scoring for contingent workforce placement',
  'red', 'On by default', '(core platform function)',
  '§4(a)', 'Recruitment',
  'Art. 9 risk register · Art. 13 worker notice · Art. 14 hiring manager review · Directly determines contingent worker access to assignments',
  'likely', true, 1290, '1.4', 'bg', 'analyst_inference'),

('sap-fieldglass', 'Rate Benchmarking AI', 'ML-driven rate recommendations for contingent labor',
  'yellow', 'On by default', NULL,
  '§4(b)', 'Employment management',
  'Art. 13 worker notice if rate AI drives compensation decisions · Art. 14 procurement override · Directly affects worker pay',
  'likely', true, 1300, '1.4', 'bg', 'analyst_inference'),

('oracle-cx', 'Unity Customer Intelligence', 'ML-unified customer scoring and propensity models',
  'yellow', 'Opt-in', '(requires CX Unity configuration)',
  '§5(b)', 'Access to essential services',
  'Art. 13 customer notice if scoring drives service differentiation · Art. 14 override for consequential decisions · Lower risk if marketing segmentation only',
  'likely', true, 1310, '1.4', 'bg', 'analyst_inference'),

('oracle-cx', 'Next Best Action AI', 'ML-recommended next actions per customer across channels',
  'yellow', 'Opt-in', NULL,
  '§5(b)', 'Access to essential services',
  'Lower risk if recommendations advisory · Higher risk if auto-executed (e.g., auto-downgrades service tier) · Art. 14 agent review',
  'likely', true, 1320, '1.4', 'bg', 'analyst_inference'),

-- ── European HR ───────────────────────────────────────────

('personio', 'AI-Powered Recruiting Recommendations', 'AI candidate matching and application ranking',
  'yellow', 'On by default', '(Personio Recruiting module)',
  '§4(a)', 'Recruitment',
  'Art. 13 candidate notice · Art. 14 recruiter review before rejection · Critical for EU SMEs: most common HR platform in DACH/Nordics',
  'likely', true, 1330, '1.4', 'bg', 'analyst_inference'),

('personio', 'Performance AI Insights', 'AI-assisted performance cycle summaries and recommendations',
  'yellow', 'On by default', NULL,
  '§4(b)', 'Employment management',
  'Art. 13 employee notice · Art. 14 manager review · Lower risk if AI assists writing (like Lattice) · Higher risk if generates performance judgements',
  'likely', true, 1340, '1.4', 'bg', 'analyst_inference'),

('rippling', 'Workforce Analytics AI', 'Unified HR+IT+Finance intelligence with predictive workforce insights',
  'yellow', 'On by default', '(Rippling Unity platform)',
  '§4(b)', 'Employment management',
  'Art. 13 employee notice · Confirm individual vs aggregate predictions · Unique risk: combines HR + IT activity + finance data into single employee view',
  'likely', true, 1350, '1.4', 'bg', 'analyst_inference'),

('rippling', 'Compliance AI', 'Automated compliance monitoring and enforcement across HR/IT/Finance',
  'yellow', 'On by default', NULL,
  '§4(b)', 'Employment management',
  'Art. 13 employee notice · Art. 14 HR review before enforcement actions · Monitors policy violations across unified platform',
  'likely', true, 1360, '1.4', 'bg', 'analyst_inference'),

-- ── Google ────────────────────────────────────────────────

('google-workspace', 'Gemini in Meet (Meeting Notes)', 'AI-generated meeting summaries, action items, and attendance tracking',
  'yellow', 'On by default', '(Workspace plans with Gemini; admin can disable)',
  '§4(b)', 'Employment management',
  'Art. 13 participant notice · Confirm summaries not used as performance evidence · Same scope as M365 Copilot meeting features',
  'likely', true, 1370, '1.4', 'bg', 'analyst_inference'),

('google-workspace', 'Gemini in Gmail/Docs', 'AI email drafting, document summarization, and writing assistance',
  'yellow', 'On by default', '(Workspace plans with Gemini)',
  '§4(b)', 'Employment management',
  'Lower risk unless productivity metrics tracked per employee · Art. 13 notice if usage monitored',
  'likely', true, 1380, '1.4', 'bg', 'analyst_inference'),

('google-talent', 'Job Search and Matching API', 'ML-powered job-to-candidate matching used by ATS platforms',
  'red', 'On by default', '(API is the product; matching is core function)',
  '§4(a)', 'Recruitment',
  'Art. 9 risk register · Art. 13 candidate notice · Art. 14 platform/recruiter override · Hidden infrastructure: many ATS platforms use this underneath without disclosing',
  'likely', true, 1390, '1.4', 'bg', 'analyst_inference'),

('google-talent', 'Commute Search and Profile Matching', 'Location-based and profile-based candidate filtering',
  'yellow', 'On by default', NULL,
  '§4(a)', 'Recruitment',
  'Art. 13 candidate notice · Concern: commute-based filtering can proxy for socioeconomic/demographic discrimination · Art. 14 recruiter awareness',
  'likely', true, 1400, '1.4', 'bg', 'analyst_inference'),

-- ── Talent Platforms ──────────────────────────────────────

('phenom', 'AI Talent Matching', 'ML candidate-to-job matching across career site, CRM, and internal mobility',
  'red', 'On by default', '(core platform function)',
  '§4(a) + §4(b)', 'Recruitment + Employment management',
  'Art. 9 risk register · Art. 13 candidate/employee notice · Art. 14 recruiter/manager review · Covers external recruiting AND internal mobility in single system',
  'likely', true, 1410, '1.4', 'bg', 'analyst_inference'),

('phenom', 'Talent Analytics and Predictions', 'ML workforce predictions including attrition and performance',
  'yellow', 'On by default', NULL,
  '§4(b)', 'Employment management',
  'Art. 13 employee notice · Confirm prediction level (individual vs team) · Art. 14 manager review before action',
  'likely', true, 1420, '1.4', 'bg', 'analyst_inference'),

('beamery', 'Talent Graph AI', 'Skills inference and talent matching from billions of data points',
  'red', 'On by default', '(core platform capability)',
  '§4(a) + §4(b)', 'Recruitment + Employment management',
  'Art. 9 risk register · Art. 13 candidate/employee notice · Art. 14 recruiter override · AI infers skills from external signals without candidate input',
  'likely', true, 1430, '1.4', 'bg', 'analyst_inference'),

('beamery', 'Workforce Planning Intelligence', 'ML-driven strategic workforce planning and gap analysis',
  'yellow', 'Opt-in', NULL,
  '§4(b)', 'Employment management',
  'Art. 13 notice if planning outputs identify specific roles/people for reduction · Lower risk if aggregate scenario modeling only',
  'likely', true, 1440, '1.4', 'bg', 'analyst_inference'),

('paradox', 'Olivia Conversational AI', 'Autonomous chatbot that screens, schedules, and rejects candidates',
  'red', 'On by default', '(Olivia is the core product)',
  '§4(a)', 'Recruitment',
  'Art. 9 risk register · Art. 13 candidate notice (interacting with AI, not human) · Art. 14 recruiter override for rejections · Textbook Annex III: autonomous employment decisions',
  'likely', true, 1450, '1.4', 'bg', 'analyst_inference'),

('paradox', 'Automated Interview Scheduling and Screening', 'AI-driven multi-step candidate qualification',
  'yellow', 'On by default', NULL,
  '§4(a)', 'Recruitment',
  'Art. 13 candidate notice · Lower risk if scheduling only · Higher risk if screening questions auto-disqualify without human review',
  'likely', true, 1460, '1.4', 'bg', 'analyst_inference'),

('shl', 'Cognitive and Personality Assessments', 'Psychometric testing with ML scoring for hiring decisions',
  'red', 'On when feature licensed', NULL,
  '§4(a)', 'Recruitment',
  'Art. 9 risk register · Art. 13 candidate notice · Art. 14 recruiter review · Art. 15 validation documentation · 45M+ assessments/year globally. Directly gates employment.',
  'likely', true, 1470, '1.4', 'bg', 'analyst_inference'),

('shl', 'Talent Mobility Matching', 'AI skills matching for internal mobility and succession planning',
  'yellow', 'Opt-in', NULL,
  '§4(b)', 'Employment management',
  'Art. 13 employee notice · Art. 14 manager review · Determines which employees are surfaced for opportunities',
  'likely', true, 1480, '1.4', 'bg', 'analyst_inference'),

('textio', 'Augmented Writing for Job Posts', 'AI that rewrites job descriptions to attract/exclude specific demographics',
  'yellow', 'On by default', '(core product function)',
  '§4(a)', 'Recruitment',
  'Art. 13 recruiter notice (AI shaping candidate pool composition) · Unique risk: AI intentionally alters who applies · Can inadvertently discriminate via language optimization',
  'likely', true, 1490, '1.4', 'bg', 'analyst_inference'),

('textio', 'Performance Feedback Analysis', 'AI analysis of manager feedback for bias patterns',
  'yellow', 'On by default', NULL,
  '§4(b)', 'Employment management',
  'Art. 13 manager notice (feedback analyzed for bias) · Lower risk: observational/diagnostic · Higher risk if auto-modifies feedback or flags individuals',
  'likely', true, 1500, '1.4', 'bg', 'analyst_inference'),

-- ── Contact Center ────────────────────────────────────────

('verint', 'Interaction Analytics (Speech/Text)', 'Voice and text analysis with emotion and sentiment scoring',
  'red', 'On by default', '(core WEM capability)',
  '§1(c) + §4(b)', 'Emotion recognition + Employment management',
  'Art. 9 risk register · Art. 13 agent + customer notice · Art. 14 QA supervisor review · Dual scope: acoustic emotion analysis + agent performance scoring',
  'likely', true, 1510, '1.4', 'bg', 'analyst_inference'),

('verint', 'Quality Management AI', 'AI-scored agent quality from 100% of interactions',
  'red', 'On by default', NULL,
  '§4(b)', 'Employment management',
  'Art. 9 risk register · Art. 13 agent notice · Art. 14 supervisor review before performance actions · 100% automated scoring replaces sample-based manual QA',
  'likely', true, 1520, '1.4', 'bg', 'analyst_inference'),

('five9', 'Intelligent Virtual Agent', 'AI-powered self-service with intent detection and sentiment',
  'yellow', 'On when feature licensed', NULL,
  '§1(c) + §4(b)', 'Emotion recognition + Employment management',
  'Art. 13 customer notice (AI interaction) · Art. 13 agent notice if deflection rate tracked per agent · Sentiment detection from voice',
  'likely', true, 1530, '1.4', 'bg', 'analyst_inference'),

('five9', 'Agent Assist with Real-Time Guidance', 'AI coaching and next-best-action during live calls',
  'yellow', 'On when feature licensed', NULL,
  '§4(b)', 'Employment management',
  'Art. 13 agent notice · Lower risk if guidance optional · Higher risk if adherence to AI suggestions tracked in performance metrics',
  'likely', true, 1540, '1.4', 'bg', 'analyst_inference'),

('talkdesk', 'Mood Insights', 'AI-detected customer and agent mood from voice and text',
  'red', 'On by default', '(Talkdesk AI Platform)',
  '§1(c) + §4(b)', 'Emotion recognition + Employment management',
  'Art. 9 risk register · Art. 13 agent + customer notice · Art. 14 supervisor review · Explicitly "mood" detection from voice = emotion recognition',
  'likely', true, 1550, '1.4', 'bg', 'analyst_inference'),

('talkdesk', 'QM Assist — Automated Quality Scoring', 'AI scores 100% of agent interactions on adherence and quality',
  'red', 'On by default', NULL,
  '§4(b)', 'Employment management',
  'Art. 9 risk register · Art. 13 agent notice · Art. 14 QA review before performance action · Replaces sample-based QA with 100% automated scoring',
  'likely', true, 1560, '1.4', 'bg', 'analyst_inference'),

-- ── Financial Services ────────────────────────────────────

('temenos', 'Explainable AI for Credit Decisions', 'ML credit scoring with regulatory explainability built in',
  'red', 'On by default', '(core Temenos AI capability)',
  '§5(a)', 'Creditworthiness assessment',
  'Art. 9 risk register · Art. 13 applicant disclosure · Art. 14 human review of adverse decisions · Art. 15 model explainability documentation · 3,000+ banks globally',
  'likely', true, 1570, '1.4', 'bg', 'analyst_inference'),

('temenos', 'Financial Crime Detection', 'ML-driven AML and fraud detection',
  'yellow', 'On by default', NULL,
  '§5(b)', 'Access to essential services',
  'Art. 13 customer notice if account actions taken · Art. 14 compliance officer review before account restriction · Can freeze access to banking services',
  'likely', true, 1580, '1.4', 'bg', 'analyst_inference'),

('verisk', 'Underwriting Risk Analytics', 'ML-scored insurance underwriting data and risk models',
  'red', 'On by default', '(industry data utility)',
  '§5(b)', 'Access to essential services',
  'Art. 9 risk register · Art. 13 applicant notice · Art. 14 underwriter review · Verisk data informs most US P&C underwriting decisions. Industry standard.',
  'likely', true, 1590, '1.4', 'bg', 'analyst_inference'),

('verisk', 'Claims Analytics (ISO ClaimSearch)', 'ML fraud scoring on insurance claims using industry database',
  'red', 'On by default', '(industry utility — 1.7B claims in database)',
  '§5(b)', 'Access to essential services',
  'Art. 9 risk register · Art. 13 claimant notice · Art. 14 adjuster review before denial · ISO ClaimSearch is industry-wide shared database. Directly gates claim payouts.',
  'likely', true, 1600, '1.4', 'bg', 'analyst_inference')

ON CONFLICT DO NOTHING;
