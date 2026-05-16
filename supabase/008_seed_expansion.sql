-- ============================================================
-- Seed 008: 20 new vendors + findings (v1.2)
-- Credit/Insurance, Education, Productivity, Employment AI,
-- Conversation Intelligence, ERP/MarTech
-- Run enum ALTER TYPEs separately before this file.
-- ============================================================

-- ══════════════════════════════════════════════════════════════
-- VENDORS (20 new)
-- ══════════════════════════════════════════════════════════════

INSERT INTO vendors (id, name, hq_country, website, product_category) VALUES
  -- Credit / Insurance (§5a)
  ('experian',             'Experian PowerCurve',       'IE', 'https://experian.com/business/products/powercurve',  'credit'),
  ('fico',                 'FICO',                      'US', 'https://fico.com',                                   'credit'),
  ('zest-ai',             'Zest AI',                   'US', 'https://zest.ai',                                    'credit'),
  -- Education / L&D (§3)
  ('cornerstone',          'Cornerstone OnDemand',      'US', 'https://cornerstoneondemand.com',                    'lms'),
  ('docebo',               'Docebo',                    'CA', 'https://docebo.com',                                 'lms'),
  -- Productivity / Collaboration
  ('microsoft-copilot',    'Microsoft 365 Copilot',     'US', 'https://microsoft.com/microsoft-365/copilot',        'productivity'),
  ('salesforce-sales',     'Salesforce Sales Cloud',    'US', 'https://salesforce.com/sales-cloud',                 'crm'),
  ('servicenow',           'ServiceNow',               'US', 'https://servicenow.com',                             'itsm'),
  ('slack-ai',             'Slack AI',                  'US', 'https://slack.com/features/ai',                      'productivity'),
  ('zoom-ai',              'Zoom AI Companion',         'US', 'https://zoom.us/ai-assistant',                       'productivity'),
  -- Employment AI specialists (§4)
  ('eightfold',            'Eightfold AI',              'US', 'https://eightfold.ai',                               'talent'),
  ('harver',               'Harver',                    'NL', 'https://harver.com',                                 'talent'),
  ('workday-peakon',       'Workday Peakon',            'DK', 'https://peakon.com',                                 'performance'),
  ('culture-amp',          'Culture Amp',               'AU', 'https://cultureamp.com',                             'performance'),
  ('ukg',                  'UKG Pro',                   'US', 'https://ukg.com',                                    'hris'),
  -- Conversation intelligence
  ('gong',                 'Gong',                      'US', 'https://gong.io',                                    'crm'),
  ('qualtrics',            'Qualtrics XM',              'US', 'https://qualtrics.com',                              'performance'),
  -- ERP / MarTech
  ('sap-s4hana',           'SAP S/4HANA',              'DE', 'https://sap.com/s4hana',                             'erp'),
  ('oracle-erp',           'Oracle ERP Cloud',          'US', 'https://oracle.com/erp',                             'erp'),
  ('adobe-experience',     'Adobe Experience Platform', 'US', 'https://business.adobe.com/products/experience-platform', 'martech')
ON CONFLICT (id) DO NOTHING;

-- ══════════════════════════════════════════════════════════════
-- FINDINGS
-- ══════════════════════════════════════════════════════════════

INSERT INTO heatmap_findings
  (vendor_id, feature_name, feature_desc, risk_level, default_state, default_state_note,
   annex_iii_ref, annex_iii_category, deployer_obligation_gap,
   confidence, published, display_order, version, verified_by, verification_method)
VALUES

-- ── Credit / Insurance ────────────────────────────────────

('experian', 'PowerCurve Originations', 'Automated credit decisioning engine',
  'red', 'On by default', '(core product function)',
  '§5(a)', 'Creditworthiness assessment',
  'Art. 9 risk register · Art. 13 applicant disclosure of AI scoring · Art. 14 human review of adverse decisions · Art. 15 accuracy documentation from Experian',
  'verified', true, 440, '1.2', 'bg', 'vendor_documentation'),

('experian', 'Ascend Intelligence Services', 'ML-driven credit risk models',
  'red', 'On by default', NULL,
  '§5(a)', 'Creditworthiness assessment',
  'Art. 9 risk register · Art. 13 disclosure · Art. 14 adverse action review · Art. 15 model performance documentation',
  'verified', true, 450, '1.2', 'bg', 'vendor_documentation'),

('fico', 'FICO Score', 'Consumer credit scoring model',
  'red', 'On by default', '(industry standard, embedded in lender workflows)',
  '§5(a)', 'Creditworthiness assessment',
  'Art. 9 risk register · Art. 13 consumer disclosure · Art. 14 human review of denials · Art. 15 FICO model validation documentation',
  'verified', true, 460, '1.2', 'bg', 'vendor_documentation'),

('fico', 'FICO Decision Management Platform', 'Rules + ML decisioning for lending',
  'red', 'On by default', NULL,
  '§5(a)', 'Creditworthiness assessment',
  'Art. 9 risk register · Art. 13 applicant notice · Art. 14 human override for automated denials · Art. 15 model governance documentation',
  'verified', true, 470, '1.2', 'bg', 'vendor_documentation'),

('zest-ai', 'Zest Model Management', 'Fair lending ML model platform',
  'red', 'On by default', '(core product)',
  '§5(a)', 'Creditworthiness assessment',
  'Art. 9 risk register · Art. 13 applicant disclosure · Art. 14 adverse action review · Art. 15 bias audit documentation (Zest provides)',
  'verified', true, 480, '1.2', 'bg', 'vendor_documentation'),

-- ── Education / L&D ──────────────────────────────────────

('cornerstone', 'AI Skills Graph', 'Infers employee skills and recommends learning paths',
  'yellow', 'On by default', '(for Skills module customers)',
  '§3(a)', 'Education and vocational training',
  'Art. 13 employee notice of AI-inferred skills · Confirm skills inference not used in promotion decisions without human review',
  'likely', true, 490, '1.2', 'bg', 'analyst_inference'),

('cornerstone', 'Content Recommendations', 'AI-driven learning content assignment',
  'yellow', 'On by default', NULL,
  '§3(a)', 'Education and vocational training',
  'Art. 13 employee notice · Confirm auto-assigned content does not gate career progression without review',
  'likely', true, 500, '1.2', 'bg', 'analyst_inference'),

('docebo', 'AI-Powered Auto-Tagging', 'Automatic content categorisation and skill mapping',
  'yellow', 'On by default', NULL,
  '§3(a)', 'Education and vocational training',
  'Art. 13 notice if skill tags feed into performance or promotion decisions · Lower risk if purely navigational',
  'likely', true, 510, '1.2', 'bg', 'analyst_inference'),

('docebo', 'Virtual Coach', 'AI learning companion with adaptive recommendations',
  'yellow', 'Opt-in', NULL,
  '§3(a)', 'Education and vocational training',
  'Art. 13 learner notice · Confirm completion predictions not used for employment decisions',
  'likely', true, 520, '1.2', 'bg', 'analyst_inference'),

-- ── Productivity / Collaboration ─────────────────────────

('microsoft-copilot', 'Meeting Summarisation', 'AI-generated meeting summaries and action items',
  'yellow', 'On by default', '(M365 Copilot license)',
  '§4(b)', 'Employment management',
  'Art. 13 employee notice · Confirm summaries not used as performance evidence without human review',
  'likely', true, 530, '1.2', 'bg', 'analyst_inference'),

('microsoft-copilot', 'Email Drafting and Prioritisation', 'AI-drafted replies and inbox prioritisation',
  'yellow', 'On by default', '(M365 Copilot license)',
  '§4(b)', 'Employment management',
  'Lower risk unless email productivity metrics feed performance reviews · Art. 13 notice if tracked',
  'likely', true, 540, '1.2', 'bg', 'analyst_inference'),

('salesforce-sales', 'Einstein Lead Scoring', 'ML-predicted lead conversion probability',
  'yellow', 'On by default', '(Einstein enabled orgs)',
  '§4(b)', 'Employment management',
  'Art. 13 rep notice if scores drive territory assignment or quota · Confirm scoring transparency',
  'likely', true, 550, '1.2', 'bg', 'analyst_inference'),

('salesforce-sales', 'Einstein Opportunity Insights', 'Deal risk and next-step predictions',
  'yellow', 'On by default', '(Einstein enabled orgs)',
  '§4(b)', 'Employment management',
  'Art. 13 rep notice if deal predictions affect performance metrics · Lower risk if advisory only',
  'likely', true, 560, '1.2', 'bg', 'analyst_inference'),

('servicenow', 'Virtual Agent', 'AI-powered IT service chatbot',
  'yellow', 'Opt-in', '(requires configuration)',
  '§4(b)', 'Employment management',
  'Art. 13 employee notice (interacting with AI) · Confirm resolution metrics not tied to support staff KPIs',
  'likely', true, 570, '1.2', 'bg', 'analyst_inference'),

('servicenow', 'Predictive Intelligence', 'Auto-categorises, routes, and prioritises incidents',
  'yellow', 'Opt-in', NULL,
  '§4(b)', 'Employment management',
  'Art. 13 agent notice if routing affects workload/performance metrics · Art. 14 override for misclassification',
  'likely', true, 580, '1.2', 'bg', 'analyst_inference'),

('slack-ai', 'Channel Summaries and Search', 'AI-generated channel digests and semantic search',
  'yellow', 'On by default', '(Slack AI add-on)',
  '§4(b)', 'Employment management',
  'Lower risk unless usage/engagement metrics tracked per employee · Art. 13 notice if activity monitored',
  'likely', true, 590, '1.2', 'bg', 'analyst_inference'),

('zoom-ai', 'Meeting Summary and Smart Recording', 'AI meeting notes, chapters, and sentiment highlights',
  'yellow', 'On by default', '(AI Companion enabled accounts)',
  '§1(c) + §4(b)', 'Emotion recognition + Employment management',
  'Art. 13 participant notice (AI recording and analysis) · Confirm sentiment highlights not used in performance evaluation · Dual scope if acoustic analysis present',
  'likely', true, 600, '1.2', 'bg', 'analyst_inference'),

-- ── Employment AI Specialists ────────────────────────────

('eightfold', 'Talent Intelligence Platform', 'AI matching across recruiting, retention, mobility',
  'red', 'On by default', '(core platform function)',
  '§4(a) + §4(b)', 'Recruitment + Employment management',
  'Art. 9 risk register · Art. 13 candidate and employee notice · Art. 14 recruiter/manager override · Art. 15 bias documentation',
  'verified', true, 610, '1.2', 'bg', 'vendor_documentation'),

('eightfold', 'Career Navigator', 'AI-driven internal mobility and skills development',
  'yellow', 'On by default', NULL,
  '§4(b)', 'Employment management',
  'Art. 13 employee notice · Confirm mobility recommendations do not auto-exclude employees from opportunities',
  'likely', true, 620, '1.2', 'bg', 'analyst_inference'),

('harver', 'Pre-Employment Assessments', 'Behavioral and cognitive assessments for hiring',
  'red', 'On when feature licensed', NULL,
  '§4(a)', 'Recruitment',
  'Art. 9 risk register · Art. 13 applicant notice · Art. 14 recruiter override · Art. 15 validation documentation from Harver',
  'verified', true, 630, '1.2', 'bg', 'vendor_documentation'),

('harver', 'Situational Judgement Tests', 'AI-scored scenario-based candidate assessment',
  'yellow', 'On when feature licensed', NULL,
  '§4(a)', 'Recruitment',
  'Art. 13 applicant notice · Confirm scoring criteria documented · Art. 14 recruiter review before auto-rejection',
  'likely', true, 640, '1.2', 'bg', 'analyst_inference'),

('workday-peakon', 'Employee Sentiment AI', 'Continuous listening with AI-predicted engagement trends',
  'yellow', 'On by default', '(Peakon module)',
  '§4(b)', 'Employment management',
  'Art. 13 employee notice · Confirm individual sentiment not surfaced to direct managers · Verify aggregation level',
  'likely', true, 650, '1.2', 'bg', 'analyst_inference'),

('workday-peakon', 'Attrition Prediction', 'ML-predicted flight risk per employee',
  'red', 'On by default', '(Peakon module)',
  '§4(b)', 'Employment management',
  'Art. 9 risk register · Art. 13 employee notice · Art. 14 manager review before retention actions · Individual-level prediction = high risk',
  'likely', true, 660, '1.2', 'bg', 'analyst_inference'),

('culture-amp', 'Performance Predictions', 'AI-predicted performance trajectory',
  'red', 'On by default', NULL,
  '§4(b)', 'Employment management',
  'Art. 9 risk register · Art. 13 employee notice · Art. 14 manager review before promotion/PIP decisions · Individual-level prediction = high risk',
  'likely', true, 670, '1.2', 'bg', 'analyst_inference'),

('culture-amp', 'Flight Risk Indicator', 'ML-predicted attrition probability',
  'red', 'On by default', NULL,
  '§4(b)', 'Employment management',
  'Art. 9 risk register · Art. 13 employee notice · Art. 14 human review before any action taken on prediction',
  'likely', true, 680, '1.2', 'bg', 'analyst_inference'),

('ukg', 'Pro Workforce Analytics', 'AI-driven workforce insights and predictions',
  'yellow', 'On by default', '(Pro WFM customers)',
  '§4(b)', 'Employment management',
  'Art. 13 employee notice · Confirm predictions aggregated at team level · Art. 14 if individual-level signals surfaced',
  'likely', true, 690, '1.2', 'bg', 'analyst_inference'),

('ukg', 'Great Place to Work AI', 'Employee engagement and culture scoring',
  'yellow', 'On by default', NULL,
  '§4(b)', 'Employment management',
  'Art. 13 employee notice · Confirm individual responses not identifiable · Lower risk if purely survey aggregation',
  'likely', true, 700, '1.2', 'bg', 'analyst_inference'),

-- ── Conversation Intelligence ────────────────────────────

('gong', 'Call Recording AI Analysis', 'Voice/video call analysis with deal scoring',
  'red', 'On by default', '(core product function)',
  '§1(c) + §4(b)', 'Emotion recognition + Employment management',
  'Art. 9 risk register · Art. 13 all call participants · Art. 14 manager override on deal scores · Dual scope: voice analysis + rep performance',
  'verified', true, 710, '1.2', 'bg', 'vendor_documentation'),

('gong', 'Rep Performance Scoring', 'AI-scored sales rep effectiveness from calls',
  'red', 'On by default', NULL,
  '§4(b)', 'Employment management',
  'Art. 9 risk register · Art. 13 rep notice · Art. 14 manager review before performance actions · Individual performance scoring from AI',
  'verified', true, 720, '1.2', 'bg', 'vendor_documentation'),

('qualtrics', 'Employee Experience AI', 'Employee sentiment analysis and engagement predictions',
  'yellow', 'On by default', '(EX module)',
  '§4(b)', 'Employment management',
  'Art. 13 employee notice · Confirm individual sentiment not surfaced to managers · Verify anonymity thresholds',
  'likely', true, 730, '1.2', 'bg', 'analyst_inference'),

('qualtrics', 'Manager Assist', 'AI-recommended actions for managers based on team sentiment',
  'yellow', 'On by default', NULL,
  '§4(b)', 'Employment management',
  'Art. 13 employee notice (data feeds manager recommendations) · Art. 14 manager decides action · Confirm no individual attribution',
  'likely', true, 740, '1.2', 'bg', 'analyst_inference'),

-- ── ERP / MarTech ────────────────────────────────────────

('sap-s4hana', 'Joule for Finance', 'AI-assisted financial close and anomaly detection',
  'yellow', 'Opt-in', '(requires Joule activation)',
  '§5(b)', 'Access to essential services',
  'Confirm AI anomaly flags do not auto-block supplier payments · Art. 14 AP reviewer override · Lower risk if advisory',
  'likely', true, 750, '1.2', 'bg', 'analyst_inference'),

('sap-s4hana', 'Predictive Material Planning', 'ML demand forecasting for supply chain',
  'yellow', 'Opt-in', NULL,
  '§5(b)', 'Access to essential services',
  'Lower direct risk unless forecasting auto-adjusts supplier orders without human review · Art. 14 planner override',
  'likely', true, 760, '1.2', 'bg', 'analyst_inference'),

('oracle-erp', 'Intelligent Process Automation', 'AI-driven AP matching and exception handling',
  'yellow', 'Opt-in', NULL,
  '§5(b)', 'Access to essential services',
  'Art. 14 AP reviewer override before payment blocks · Confirm auto-matching thresholds documented',
  'likely', true, 770, '1.2', 'bg', 'analyst_inference'),

('oracle-erp', 'Adaptive Intelligent Apps', 'Embedded ML predictions across ERP modules',
  'yellow', 'Opt-in', '(requires AI Apps license)',
  '§5(b)', 'Access to essential services',
  'Scope depends on which module: finance (supplier payment), procurement (supplier access), HCM (employment). Assess per deployment.',
  'likely', true, 780, '1.2', 'bg', 'analyst_inference'),

('adobe-experience', 'Customer AI', 'Propensity scoring and predictive audiences',
  'yellow', 'Opt-in', NULL,
  '§5(b)', 'Access to essential services',
  'Art. 13 customer notice if scoring affects service access or pricing · Lower risk if purely marketing segmentation',
  'likely', true, 790, '1.2', 'bg', 'analyst_inference'),

('adobe-experience', 'Real-Time Customer Profile', 'Unified profile with ML-enriched attributes',
  'yellow', 'On by default', '(AEP feature)',
  '§5(b)', 'Access to essential services',
  'Confirm ML-enriched attributes do not drive automated access/pricing decisions · Art. 13 notice if personalization is consequential',
  'likely', true, 800, '1.2', 'bg', 'analyst_inference')

ON CONFLICT DO NOTHING;
