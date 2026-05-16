-- ============================================================
-- Seed 010: Batch 3 — 20 vendors (v1.3)
-- Background checks, Video/Security, Insurance, People Analytics,
-- Payroll, ATS, Cybersecurity, Meeting AI, CS, Supply Chain, Legal, GRC
-- Run enum ALTER TYPEs separately before this file.
-- ============================================================

-- ══════════════════════════════════════════════════════════════
-- VENDORS (20 new)
-- ══════════════════════════════════════════════════════════════

INSERT INTO vendors (id, name, hq_country, website, product_category) VALUES
  -- Background checks
  ('checkr',               'Checkr',                    'US', 'https://checkr.com',                    'ats'),
  ('sterling',             'Sterling',                  'US', 'https://sterlingcheck.com',              'ats'),
  -- Video / Physical security
  ('verkada',              'Verkada',                   'US', 'https://verkada.com',                    'other'),
  ('hikvision',            'Hikvision',                 'CN', 'https://hikvision.com',                  'other'),
  -- Insurance
  ('shift-technology',     'Shift Technology',          'FR', 'https://shift-technology.com',           'credit'),
  ('guidewire',            'Guidewire',                 'US', 'https://guidewire.com',                  'credit'),
  -- People Analytics
  ('visier',               'Visier',                    'CA', 'https://visier.com',                     'performance'),
  ('anaplan',              'Anaplan',                   'US', 'https://anaplan.com',                    'erp'),
  -- Payroll / Global HR
  ('adp',                  'ADP',                       'US', 'https://adp.com',                        'hris'),
  ('deel',                 'Deel',                      'US', 'https://deel.com',                       'hris'),
  -- ATS
  ('icims',                'iCIMS',                     'US', 'https://icims.com',                      'ats'),
  ('smartrecruiters',      'SmartRecruiters',           'US', 'https://smartrecruiters.com',            'ats'),
  -- Cybersecurity
  ('darktrace',            'Darktrace',                 'GB', 'https://darktrace.com',                  'itsm'),
  ('crowdstrike',          'CrowdStrike',              'US', 'https://crowdstrike.com',                'itsm'),
  -- Meeting AI
  ('otter-ai',             'Otter.ai',                  'US', 'https://otter.ai',                       'productivity'),
  ('fireflies',            'Fireflies.ai',              'US', 'https://fireflies.ai',                   'productivity'),
  -- Customer Success
  ('gainsight',            'Gainsight',                 'US', 'https://gainsight.com',                  'crm'),
  -- Supply Chain
  ('blue-yonder',          'Blue Yonder',               'US', 'https://blueyonder.com',                 'erp'),
  -- Contract / Legal AI
  ('ironclad',             'Ironclad',                  'US', 'https://ironcladapp.com',                'procurement'),
  -- GRC
  ('onetrust',             'OneTrust',                  'US', 'https://onetrust.com',                   'other')
ON CONFLICT (id) DO NOTHING;

-- ══════════════════════════════════════════════════════════════
-- FINDINGS
-- ══════════════════════════════════════════════════════════════

INSERT INTO heatmap_findings
  (vendor_id, feature_name, feature_desc, risk_level, default_state, default_state_note,
   annex_iii_ref, annex_iii_category, deployer_obligation_gap,
   confidence, published, display_order, version, verified_by, verification_method)
VALUES

-- ── Background Checks ─────────────────────────────────────

('checkr', 'AI-Powered Adjudication', 'Automated criminal record assessment and hiring eligibility determination',
  'red', 'On by default', '(core product function)',
  '§4(a)', 'Recruitment',
  'Art. 9 risk register · Art. 13 candidate notice of AI assessment · Art. 14 human review before adverse action · Art. 15 accuracy documentation',
  'likely', true, 810, '1.3', 'bg', 'analyst_inference'),

('checkr', 'Candidate Insights ML', 'ML risk scoring on background check results',
  'red', 'On by default', NULL,
  '§4(a)', 'Recruitment',
  'Art. 9 risk register · Art. 13 candidate disclosure · Art. 14 individualized assessment before denial · FCRA adverse action requirements compound EU AI Act obligations',
  'likely', true, 820, '1.3', 'bg', 'analyst_inference'),

('sterling', 'AI-Assisted Verification', 'Automated identity and credential verification',
  'red', 'On by default', '(core product)',
  '§4(a)', 'Recruitment',
  'Art. 9 risk register · Art. 13 candidate notice · Art. 14 human review of adverse findings · Art. 15 verification accuracy documentation',
  'likely', true, 830, '1.3', 'bg', 'analyst_inference'),

('sterling', 'Continuous Monitoring AI', 'Ongoing post-hire criminal and compliance monitoring',
  'red', 'Opt-in', '(requires separate service agreement)',
  '§4(b)', 'Employment management',
  'Art. 9 risk register · Art. 13 employee notice of continuous monitoring · Art. 14 human review before any employment action based on alert',
  'likely', true, 840, '1.3', 'bg', 'analyst_inference'),

-- ── Video / Physical Security ─────────────────────────────

('verkada', 'Facial Recognition Access', 'AI-powered face matching for building access control',
  'red', 'On when feature licensed', NULL,
  '§1(a)', 'Biometric identification',
  'Art. 9 risk register · Art. 13 prominent signage + employee notice · Art. 14 alternative access method · Potential Art. 5 prohibition in workplace if real-time',
  'likely', true, 850, '1.3', 'bg', 'analyst_inference'),

('verkada', 'Person of Interest Alerts', 'AI watchlist matching from camera feeds',
  'red', 'On when feature licensed', NULL,
  '§1(a)', 'Biometric identification',
  'Art. 5 prohibition assessment required (real-time biometric ID in public spaces) · Art. 9 risk register · Art. 13 disclosure · Art. 14 human verification before action',
  'likely', true, 860, '1.3', 'bg', 'analyst_inference'),

('hikvision', 'DeepinView Facial Recognition', 'AI face detection and matching for access control',
  'red', 'On by default', '(hardware-embedded AI)',
  '§1(a)', 'Biometric identification',
  'Art. 5 prohibition assessment (real-time biometric ID) · Art. 9 risk register · Art. 13 prominent signage · Art. 14 alternative access · EU sanctions/entity list considerations',
  'likely', true, 870, '1.3', 'bg', 'analyst_inference'),

('hikvision', 'Behavior Analysis', 'AI detection of loitering, crowd formation, running',
  'yellow', 'On by default', '(camera firmware feature)',
  '§1(b)', 'Biometric categorisation',
  'Art. 13 signage · Confirm no individual employee behavior profiling from footage · Lower risk if purely safety/security detection',
  'likely', true, 880, '1.3', 'bg', 'analyst_inference'),

-- ── Insurance ─────────────────────────────────────────────

('shift-technology', 'Claims Fraud Detection', 'AI-scored fraud probability on insurance claims',
  'red', 'On by default', '(core product function)',
  '§5(b)', 'Access to essential services',
  'Art. 9 risk register · Art. 13 claimant notice of AI assessment · Art. 14 human claims adjuster review before denial · Art. 15 model accuracy documentation',
  'likely', true, 890, '1.3', 'bg', 'analyst_inference'),

('shift-technology', 'Underwriting AI', 'ML risk assessment for policy pricing and acceptance',
  'red', 'On by default', NULL,
  '§5(b)', 'Access to essential services',
  'Art. 9 risk register · Art. 13 applicant notice · Art. 14 human underwriter review · Art. 15 actuarial model documentation · Directly determines insurance access and pricing',
  'likely', true, 900, '1.3', 'bg', 'analyst_inference'),

('guidewire', 'Predict for Underwriting', 'ML models for risk selection and pricing',
  'red', 'Opt-in', '(requires Guidewire Cloud configuration)',
  '§5(b)', 'Access to essential services',
  'Art. 9 risk register · Art. 13 applicant disclosure · Art. 14 underwriter override · Art. 15 model performance and fairness documentation',
  'likely', true, 910, '1.3', 'bg', 'analyst_inference'),

('guidewire', 'ClaimCenter AI', 'Automated claims triage and fraud scoring',
  'red', 'Opt-in', NULL,
  '§5(b)', 'Access to essential services',
  'Art. 9 risk register · Art. 13 claimant notice · Art. 14 adjuster review before denial · Directly gates access to insurance payouts',
  'likely', true, 920, '1.3', 'bg', 'analyst_inference'),

-- ── People Analytics ──────────────────────────────────────

('visier', 'Predictive Attrition', 'Individual-level flight risk scoring per employee',
  'red', 'On by default', '(core analytics feature)',
  '§4(b)', 'Employment management',
  'Art. 9 risk register · Art. 13 employee notice · Art. 14 manager review before retention/termination actions · Individual-level prediction = highest risk tier',
  'likely', true, 930, '1.3', 'bg', 'analyst_inference'),

('visier', 'Compensation Equity AI', 'ML-driven pay gap analysis and adjustment recommendations',
  'yellow', 'Opt-in', NULL,
  '§4(b)', 'Employment management',
  'Art. 13 employee notice if recommendations drive individual compensation changes · Art. 14 HR review · Lower risk if advisory only',
  'likely', true, 940, '1.3', 'bg', 'analyst_inference'),

('anaplan', 'Workforce Planning AI', 'ML-driven headcount optimization and scenario modeling',
  'yellow', 'Opt-in', '(requires PlanIQ configuration)',
  '§4(b)', 'Employment management',
  'Art. 13 notice if AI recommendations drive specific headcount reduction decisions · Art. 14 leadership review · Higher risk if role-level recommendations',
  'likely', true, 950, '1.3', 'bg', 'analyst_inference'),

('anaplan', 'PlanIQ Demand Forecasting', 'ML time-series forecasting for supply and demand',
  'yellow', 'Opt-in', NULL,
  '§5(b)', 'Access to essential services',
  'Lower risk unless forecasts auto-adjust supplier orders · Art. 14 planner override · Primarily internal planning tool',
  'likely', true, 960, '1.3', 'bg', 'analyst_inference'),

-- ── Payroll / Global HR ───────────────────────────────────

('adp', 'DataCloud Workforce Intelligence', 'AI-driven workforce benchmarking and predictions',
  'yellow', 'On by default', '(DataCloud customers)',
  '§4(b)', 'Employment management',
  'Art. 13 employee notice if predictions surface at individual level · Confirm aggregation level · ADP benchmarks 1M+ employers',
  'likely', true, 970, '1.3', 'bg', 'analyst_inference'),

('adp', 'Intelligent Self-Service', 'AI-powered employee query resolution and payroll assistance',
  'yellow', 'On by default', NULL,
  '§4(b)', 'Employment management',
  'Lower risk: advisory/self-service tool · Art. 13 notice that AI answers queries · Confirm no automated payroll changes without human approval',
  'likely', true, 980, '1.3', 'bg', 'analyst_inference'),

('deel', 'Worker Classification AI', 'Automated contractor vs employee classification assessment',
  'red', 'On by default', '(embedded in onboarding flow)',
  '§4(a)', 'Recruitment',
  'Art. 9 risk register · Art. 13 worker notice of AI classification · Art. 14 legal/HR review before classification decision · Directly determines employment relationship type',
  'likely', true, 990, '1.3', 'bg', 'analyst_inference'),

('deel', 'Compliance Risk Scoring', 'ML-driven compliance risk per worker arrangement',
  'yellow', 'On by default', NULL,
  '§4(b)', 'Employment management',
  'Art. 13 worker notice · Art. 14 HR review of flagged arrangements · Risk depends on whether scoring triggers automatic contract changes',
  'likely', true, 1000, '1.3', 'bg', 'analyst_inference'),

-- ── ATS ───────────────────────────────────────────────────

('icims', 'AI Talent Matching', 'ML-powered candidate-to-job matching and ranking',
  'red', 'On by default', '(iCIMS Talent Cloud AI)',
  '§4(a)', 'Recruitment',
  'Art. 9 risk register · Art. 13 candidate notice · Art. 14 recruiter review before auto-rejection · Art. 15 matching model documentation',
  'likely', true, 1010, '1.3', 'bg', 'analyst_inference'),

('icims', 'Video Interview Intelligence', 'AI-assisted video interview analysis',
  'yellow', 'On when feature licensed', NULL,
  '§4(a)', 'Recruitment',
  'Art. 13 candidate notice (AI analysis of video response) · Art. 14 recruiter override · Confirm no facial/emotion analysis (text/content only)',
  'likely', true, 1020, '1.3', 'bg', 'analyst_inference'),

('smartrecruiters', 'SmartAssistant AI Matching', 'AI candidate matching and ranking engine',
  'red', 'On by default', '(core platform feature)',
  '§4(a)', 'Recruitment',
  'Art. 9 risk register · Art. 13 candidate notice · Art. 14 recruiter review · SmartRecruiters has EU AI Act readiness page',
  'likely', true, 1030, '1.3', 'bg', 'analyst_inference'),

('smartrecruiters', 'Bias Insights', 'AI-detected bias patterns in hiring pipeline',
  'yellow', 'On by default', NULL,
  '§4(a)', 'Recruitment',
  'Art. 13 recruiter notice (AI monitoring their decisions) · Lower risk: observational/diagnostic tool · Higher risk if auto-intervenes in pipeline',
  'likely', true, 1040, '1.3', 'bg', 'analyst_inference'),

-- ── Cybersecurity ─────────────────────────────────────────

('darktrace', 'Enterprise Immune System', 'AI user behavior analytics detecting anomalous employee actions',
  'red', 'On by default', '(core product function)',
  '§4(b)', 'Employment management',
  'Art. 9 risk register · Art. 13 employee notice (behavioral monitoring) · Art. 14 SOC analyst review before HR escalation · Dual scope: security + employment implications',
  'likely', true, 1050, '1.3', 'bg', 'analyst_inference'),

('darktrace', 'Insider Threat Detection', 'ML-scored insider risk per employee',
  'red', 'On by default', NULL,
  '§4(b)', 'Employment management',
  'Art. 9 risk register · Art. 13 employee notice · Art. 14 human review before any employment action · Individual-level risk scoring of employees = high-risk',
  'likely', true, 1060, '1.3', 'bg', 'analyst_inference'),

('crowdstrike', 'User Risk Scoring', 'AI-driven identity risk score per employee',
  'red', 'On by default', '(Falcon Identity Threat Protection)',
  '§4(b)', 'Employment management',
  'Art. 9 risk register · Art. 13 employee notice · Art. 14 SOC/HR review before access restriction or employment action · Individual risk profiling',
  'likely', true, 1070, '1.3', 'bg', 'analyst_inference'),

('crowdstrike', 'Behavioral Analytics', 'ML baseline and anomaly detection on user activity',
  'yellow', 'On by default', NULL,
  '§4(b)', 'Employment management',
  'Art. 13 employee notice (activity monitored and baselined) · Lower risk if purely security alerting · Higher risk if feeds into HR decisions',
  'likely', true, 1080, '1.3', 'bg', 'analyst_inference'),

-- ── Meeting AI ────────────────────────────────────────────

('otter-ai', 'Meeting Transcription and AI Notes', 'Real-time transcription with speaker identification and summaries',
  'yellow', 'On by default', '(once account created and bot invited)',
  '§1(c) + §4(b)', 'Emotion recognition + Employment management',
  'Art. 13 all participants (AI recording) · Confirm no acoustic emotion analysis · Higher risk if meeting scores feed into performance reviews',
  'likely', true, 1090, '1.3', 'bg', 'analyst_inference'),

('otter-ai', 'OtterPilot Sales Intelligence', 'Automated call analysis with deal scoring',
  'yellow', 'On by default', '(Business/Enterprise plans)',
  '§4(b)', 'Employment management',
  'Art. 13 rep and customer notice · Confirm scoring not used for individual performance evaluation without review',
  'likely', true, 1100, '1.3', 'bg', 'analyst_inference'),

('fireflies', 'Meeting AI Analysis', 'Call recording, transcription, and conversation intelligence',
  'yellow', 'On by default', '(once connected to calendar)',
  '§1(c) + §4(b)', 'Emotion recognition + Employment management',
  'Art. 13 all meeting participants · Confirm sentiment scores not linked to individual performance · Topic and action item extraction',
  'likely', true, 1110, '1.3', 'bg', 'analyst_inference'),

('fireflies', 'Deal Intelligence', 'AI-scored deal health from recorded calls',
  'yellow', 'On by default', '(Business+ plans)',
  '§4(b)', 'Employment management',
  'Art. 13 rep notice if scores affect their evaluation · Lower risk if purely deal-level (not rep-level) intelligence',
  'likely', true, 1120, '1.3', 'bg', 'analyst_inference'),

-- ── Customer Success ──────────────────────────────────────

('gainsight', 'Health Score AI', 'ML-predicted customer churn risk driving CSM actions',
  'yellow', 'On by default', '(core platform feature)',
  '§4(b)', 'Employment management',
  'Art. 13 CSM notice if health scores drive their territory/performance metrics · Lower risk if purely customer-focused · Higher risk if CSM evaluated on AI-predicted scores',
  'likely', true, 1130, '1.3', 'bg', 'analyst_inference'),

('gainsight', 'CSM Performance Analytics', 'AI-benchmarked CSM effectiveness scoring',
  'yellow', 'On by default', NULL,
  '§4(b)', 'Employment management',
  'Art. 13 CSM notice · Art. 14 manager review before performance actions · Individual-level CSM scoring from AI',
  'likely', true, 1140, '1.3', 'bg', 'analyst_inference'),

-- ── Supply Chain ──────────────────────────────────────────

('blue-yonder', 'Luminate Demand Sensing', 'ML short-term demand forecasting with supplier allocation',
  'yellow', 'On by default', '(Luminate Platform)',
  '§5(b)', 'Access to essential services',
  'Confirm AI allocation does not auto-reduce supplier orders without planner review · Art. 14 override · Affects supplier revenue',
  'likely', true, 1150, '1.3', 'bg', 'analyst_inference'),

('blue-yonder', 'Supplier Collaboration AI', 'AI-optimized supplier selection and allocation',
  'yellow', 'On by default', NULL,
  '§5(b)', 'Access to essential services',
  'Art. 13 supplier notice if AI determines allocation share · Art. 14 category manager review · Directly affects supplier business volume',
  'likely', true, 1160, '1.3', 'bg', 'analyst_inference'),

-- ── Contract / Legal AI ───────────────────────────────────

('ironclad', 'AI Contract Review', 'Automated contract risk analysis and clause flagging',
  'yellow', 'On by default', '(Ironclad AI feature)',
  '§5(b)', 'Access to essential services',
  'Art. 14 legal team review before contract rejection · Lower risk if advisory only · Higher risk if auto-rejects supplier terms',
  'likely', true, 1170, '1.3', 'bg', 'analyst_inference'),

('ironclad', 'AI Playbook Enforcement', 'Automated compliance checking against legal playbook',
  'yellow', 'On by default', NULL,
  '§5(b)', 'Access to essential services',
  'Confirm non-compliant contracts flagged for human review not auto-rejected · Art. 14 legal decision authority preserved',
  'likely', true, 1180, '1.3', 'bg', 'analyst_inference'),

-- ── GRC / Compliance ──────────────────────────────────────

('onetrust', 'AI Risk Scoring', 'ML-driven privacy and compliance risk assessments',
  'yellow', 'On by default', '(OneTrust platform)',
  '§4(b)', 'Employment management',
  'Art. 13 employee notice if risk scoring applies to internal teams/processes · Lower risk if applied to vendors/third parties only',
  'likely', true, 1190, '1.3', 'bg', 'analyst_inference'),

('onetrust', 'Vendor Risk AI', 'Automated third-party vendor risk assessment and scoring',
  'yellow', 'On by default', NULL,
  '§5(b)', 'Access to essential services',
  'Art. 13 vendor notice of AI scoring · Art. 14 procurement review before vendor de-listing · Irony: compliance tool itself requires AI Act compliance',
  'likely', true, 1200, '1.3', 'bg', 'analyst_inference')

ON CONFLICT DO NOTHING;
