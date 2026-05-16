-- ============================================================
-- Migration 013: Evidence for batch 4 vendors (v1.4)
-- All 40 findings verified by research agents 2026-05-16
-- ============================================================

-- ══════════════════════════════════════════════════════════════
-- SECTION 1: CORRECTIONS
-- ══════════════════════════════════════════════════════════════

-- Google Workspace: admin consent OFF by default
UPDATE heatmap_findings
SET default_state = 'Off by default',
    default_state_note = '(admin consent setting OFF by default; admin can enable, then host toggles per meeting)'
WHERE vendor_id = 'google-workspace' AND feature_name LIKE '%Meet%';

UPDATE heatmap_findings
SET default_state_note = '(included in Business Standard+ subscription; admin controls available)'
WHERE vendor_id = 'google-workspace' AND feature_name LIKE '%Gmail%';

-- Rippling Compliance AI: rename — no standalone product
UPDATE heatmap_findings
SET feature_name = 'Policy Automation and AI Analytics',
    feature_desc = 'Rule-based policy enforcement with AI-powered natural language queries across HR/IT/Finance',
    notes = 'Corrected 2026-05-16: No standalone "Compliance AI" product. Platform has policy automation + general AI analytics (natural language queries). Compliance page is about their own regulatory compliance, not customer-facing AI monitoring.'
WHERE vendor_id = 'rippling' AND feature_name = 'Compliance AI';

-- SAP Concur: both are paid add-ons
UPDATE heatmap_findings
SET default_state = 'Opt-in',
    default_state_note = '(Concur Detect by Oversight — separate paid add-on)'
WHERE vendor_id = 'sap-concur' AND feature_name LIKE '%Fraud%';

UPDATE heatmap_findings
SET default_state = 'Opt-in',
    default_state_note = '(Intelligent Audit — separate paid service combining AI + human auditors)'
WHERE vendor_id = 'sap-concur' AND feature_name = 'Audit Intelligence';

-- Talkdesk Mood Insights: rename + mark as Preview
UPDATE heatmap_findings
SET feature_name = 'Mood Detector',
    default_state = 'Preview',
    default_state_note = '(Preview feature, not GA; requires Customer Experience Analytics add-on)',
    notes = 'Corrected 2026-05-16: Renamed from Mood Insights to Mood Detector (May 2025). Still Preview status — available to selected customers only. LLM-powered: captures gratitude, annoyance, relief beyond basic sentiment.'
WHERE vendor_id = 'talkdesk' AND feature_name = 'Mood Insights';

-- Talkdesk QM Assist: add-on
UPDATE heatmap_findings
SET default_state = 'Opt-in',
    default_state_note = '(add-on requiring additional licensing; enablement by Talkdesk)'
WHERE vendor_id = 'talkdesk' AND feature_name LIKE '%Quality%';

-- Salesforce Marketing: both opt-in
UPDATE heatmap_findings
SET default_state = 'Opt-in',
    default_state_note = '(must be activated by admin; requires 90 days engagement data)'
WHERE vendor_id = 'salesforce-marketing' AND feature_name = 'Einstein Engagement Scoring';

UPDATE heatmap_findings
SET default_state = 'Opt-in',
    default_state_note = '(must be activated in Setup; requires 90 days data; added per journey)'
WHERE vendor_id = 'salesforce-marketing' AND feature_name = 'Einstein Send Time Optimization';

-- Microsoft Entra: risk detection is always-on but policies are opt-in
UPDATE heatmap_findings
SET default_state_note = '(risk detection always-on with P2 license; policy enforcement requires explicit Conditional Access configuration)'
WHERE vendor_id = 'microsoft-entra' AND feature_name = 'Identity Protection Risk Scoring';

-- Verint QM: opt-in add-on
UPDATE heatmap_findings
SET default_state = 'Opt-in',
    default_state_note = '(Quality Bot add-on; augments manual QA gradually)'
WHERE vendor_id = 'verint' AND feature_name LIKE '%Quality%';

-- Personio: more accurately "automated workflows" than ML matching
UPDATE heatmap_findings
SET feature_name = 'Automated Recruiting Workflows',
    feature_desc = 'Automated screening, scheduling, and data-driven recruiting insights',
    notes = 'Corrected 2026-05-16: Personio does not explicitly market AI candidate matching/ranking. Features are automated screening workflows + analytics dashboards. DACH/EU market positioning. Their AI product page exists but specific ML features unconfirmed.'
WHERE vendor_id = 'personio' AND feature_name LIKE '%Recruiting%';

-- ══════════════════════════════════════════════════════════════
-- SECTION 2: UPGRADE confidence
-- ══════════════════════════════════════════════════════════════

UPDATE heatmap_findings SET confidence = 'verified', verification_method = 'vendor_documentation'
WHERE vendor_id IN ('microsoft-entra','microsoft-purview','salesforce-marketing','sap-concur',
  'sap-fieldglass','oracle-cx','personio','rippling','google-workspace','google-talent',
  'phenom','beamery','paradox','shl','textio','verint','five9','talkdesk','temenos','verisk')
  AND confidence != 'verified' AND published = true;

-- ══════════════════════════════════════════════════════════════
-- SECTION 3: INSERT evidence sources
-- ══════════════════════════════════════════════════════════════

INSERT INTO finding_sources
  (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt)
VALUES

-- Microsoft Entra
((SELECT id FROM heatmap_findings WHERE vendor_id='microsoft-entra' AND feature_name LIKE '%Risk Scoring%'),
  'tier1', 'vendor_documentation',
  'https://learn.microsoft.com/en-us/entra/id-protection/concept-identity-protection-risks',
  'What are risk detections? - Microsoft Entra',
  '2026-05-16', 'bg',
  'ID Protection runs real-time sign-in detections generating sign-in session risk level. Covers sign-in risk (anonymous IP, password spray, impossible travel) and user risk (leaked credentials, anomalous activity).'),

((SELECT id FROM heatmap_findings WHERE vendor_id='microsoft-entra' AND feature_name LIKE '%Conditional%'),
  'tier1', 'vendor_documentation',
  'https://learn.microsoft.com/en-us/entra/id-protection/howto-identity-protection-configure-risk-policies',
  'Configure and enable risk policies - Microsoft Entra',
  '2026-05-16', 'bg',
  'Two risk policy types to automate response to risks. User risk policy at High requiring remediation, sign-in risk at Medium+ requiring MFA. Policies must be explicitly created and enabled.'),

-- Microsoft Purview
((SELECT id FROM heatmap_findings WHERE vendor_id='microsoft-purview' AND feature_name LIKE '%Insider%'),
  'tier1', 'vendor_documentation',
  'https://learn.microsoft.com/en-us/purview/insider-risk-management',
  'Learn about Insider Risk Management - Microsoft Purview',
  '2026-05-16', 'bg',
  'Correlates signals to identify malicious or inadvertent insider risks: IP theft, data leakage, security violations. All global indicators disabled by default. Users pseudonymized by default.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='microsoft-purview' AND feature_name LIKE '%Communication%'),
  'tier1', 'vendor_documentation',
  'https://learn.microsoft.com/en-us/purview/communication-compliance',
  'Learn about Communication Compliance - Microsoft Purview',
  '2026-05-16', 'bg',
  'Detects regulatory compliance and business conduct violations. AI classifiers for hate, violence, sexual, threat, discrimination, harassment. User-reported messages policy enabled by default in Teams admin.'),

-- Salesforce Marketing
((SELECT id FROM heatmap_findings WHERE vendor_id='salesforce-marketing' AND feature_name LIKE '%Engagement%'),
  'tier1', 'vendor_documentation',
  'https://trailhead.salesforce.com/content/learn/modules/einstein-engagement-scoring-in-marketing-cloud/explore-engagement-scoring-',
  'Engagement Scoring Benefits & Insights - Trailhead',
  '2026-05-16', 'bg',
  'Uses customer data and ML to assign subscribers a score predicting likelihood to open, click, stay subscribed, or convert. Assigns personas: dormant, window shopper, selective, loyalist.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='salesforce-marketing' AND feature_name LIKE '%Send Time%'),
  'tier1', 'vendor_documentation',
  'https://trailhead.salesforce.com/content/learn/modules/einstein-send-time-and-frequency-optimization/send-messages-at-the-right-time-1',
  'Optimize Send Time for Email and Push - Trailhead',
  '2026-05-16', 'bg',
  'ML determines best time to send to each contact using 90 days engagement data. Assigns likelihood score to each of 168 hours per week per contact. Must be added explicitly to Journey Builder.'),

-- SAP Concur
((SELECT id FROM heatmap_findings WHERE vendor_id='sap-concur' AND feature_name LIKE '%Fraud%'),
  'tier1', 'vendor_documentation',
  'https://www.concur.com/products/concur-detect',
  'Concur Detect by Oversight',
  '2026-05-16', 'bg',
  'AI and ML to detect fraud and compliance risks. Automated receipt extraction, translation, deep learning, NLP. Finds suspicious spending before payment. Separates intentional fraud from mistakes.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='sap-concur' AND feature_name='Audit Intelligence'),
  'tier1', 'vendor_documentation',
  'https://www.concur.com/products/intelligent-audit',
  'Concur Audit: Intelligent, Automated, Compliant Spending',
  '2026-05-16', 'bg',
  'Combines human auditors with AI for efficient compliant audit. Understands specific travel and expense policies. Validates receipts, matches expenses to date/amount/vendor. Multi-language support.'),

-- SAP Fieldglass
((SELECT id FROM heatmap_findings WHERE vendor_id='sap-fieldglass' AND feature_name LIKE '%Worker%'),
  'tier1', 'vendor_documentation',
  'https://www.sap.com/products/hcm/contingent-workforce-management.html',
  'SAP Fieldglass Contingent Workforce Management',
  '2026-05-16', 'bg',
  'SAP Business AI and ML to source and select candidates faster. Source top-skilled candidates at optimal rates and compare side-by-side including benchmarked rates. AI-enhanced job descriptions.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='sap-fieldglass' AND feature_name LIKE '%Rate%'),
  'tier1', 'vendor_documentation',
  'https://community.sap.com/t5/spend-management-blog-posts-by-sap/data-driven-hiring-mastering-rate-guidance-in-sap-fieldglass/ba-p/14181246',
  'Data-Driven Hiring: Rate Guidance in SAP Fieldglass',
  '2026-05-16', 'bg',
  'Rate Guidance offers market data integration with trends from other SAP Fieldglass customers plus C2ER and Brightfield TDX. Supported in 180+ countries. Average 2% savings on labor rates.'),

-- Oracle CX
((SELECT id FROM heatmap_findings WHERE vendor_id='oracle-cx' AND feature_name LIKE '%Unity%'),
  'tier1', 'vendor_documentation',
  'https://www.oracle.com/cx/customer-data-platform/use-cases/',
  'Oracle Unity CDP - Intelligence Workbench Models',
  '2026-05-16', 'bg',
  '27+ ready-to-use AI models including contact lead scoring, CLV, churn propensity, engagement propensity, product propensity, RFM scoring. 80+ behavioral scores and 100+ attributes.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='oracle-cx' AND feature_name LIKE '%Next Best%'),
  'tier1', 'vendor_documentation',
  'https://docs.oracle.com/en/cloud/saas/cx-unity/cx-unity-user/Help/Analytics/Next_Best_Recommendations/Analytics_NextBestRecommendation_CreateAction.htm',
  'Creating Next best actions - Oracle CX Unity',
  '2026-05-16', 'bg',
  'Predicts customer needs and recommends most relevant actions based on sales and transaction patterns. Generates top five recommended actions per customer. ML-driven auto-selection from trained catalog.'),

-- Personio
((SELECT id FROM heatmap_findings WHERE vendor_id='personio' AND feature_name LIKE '%Recruiting%' OR (vendor_id='personio' AND feature_name LIKE '%Automated%')),
  'tier1', 'vendor_documentation',
  'https://www.personio.com/product/recruiting/',
  'Personio Recruiting',
  '2026-05-16', 'bg',
  'Automated screening, interview scheduling, and reminders. Real-time dashboards and detailed metrics. DACH/EU-headquartered (Munich). More accurately automated workflows than ML-based candidate ranking.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='personio' AND feature_name LIKE '%Performance%'),
  'tier1', 'vendor_documentation',
  'https://www.personio.com/product/performance/',
  'Performance Management Software - Personio',
  '2026-05-16', 'bg',
  'Smarter Manager Reviews with performance signals. Trust insight over instinct. Data-driven performance management with analytics. More analytics dashboards than AI-generated summaries.'),

-- Rippling
((SELECT id FROM heatmap_findings WHERE vendor_id='rippling' AND feature_name LIKE '%Workforce%'),
  'tier1', 'vendor_documentation',
  'https://www.rippling.com/analytics',
  'Analytics - Workforce analytics | Rippling',
  '2026-05-16', 'bg',
  'Unified HR+IT+Finance data without manual exports. Real-time data in easy-to-use report builder. AI surfaces business-critical insights and delegates tedious tasks.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='rippling' AND feature_name LIKE '%Policy%' OR (vendor_id='rippling' AND feature_name='Compliance AI')),
  'tier1', 'vendor_documentation',
  'https://www.rippling.com/platform/ai',
  'AI that is not all talk - Rippling',
  '2026-05-16', 'bg',
  'Unlock business-critical insights and delegate tedious tasks to AI built for HR, Payroll, IT, Finance. General AI capabilities, not standalone compliance monitoring product.'),

-- Google Workspace
((SELECT id FROM heatmap_findings WHERE vendor_id='google-workspace' AND feature_name LIKE '%Meet%'),
  'tier1', 'vendor_documentation',
  'https://support.google.com/meet/answer/14754931',
  'Take notes for me in Google Meet',
  '2026-05-16', 'bg',
  'AI automatically captures meeting notes in Google Docs. Admin consent setting OFF by default. Can be auto-enabled by admin for certain meetings. Host Management controls toggling.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='google-workspace' AND feature_name LIKE '%Gmail%'),
  'tier1', 'vendor_documentation',
  'https://workspace.google.com/intl/en/solutions/ai/',
  'AI tools for a better way to work - Google Workspace',
  '2026-05-16', 'bg',
  'Summarize threads, find key details, draft emails with Gemini. Create formatted first drafts matching tone and style. Data not used to train models. Included in Business Standard+.'),

-- Google Talent
((SELECT id FROM heatmap_findings WHERE vendor_id='google-talent' AND feature_name LIKE '%Job Search%'),
  'tier1', 'vendor_documentation',
  'https://cloud.google.com/talent-solution/job-search/docs',
  'Cloud Talent Solution documentation - Job Search',
  '2026-05-16', 'bg',
  'ML brings job search beyond keyword limitations. Automatically detects and infers related titles, seniority, industry. RESTful API with client libraries. Usage-based pricing.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='google-talent' AND feature_name LIKE '%Commute%'),
  'tier1', 'vendor_documentation',
  'https://cloud.google.com/talent-solution/job-search/docs/commute-search',
  'Implementing commute search - Cloud Talent Solution',
  '2026-05-16', 'bg',
  'Allows job seekers to search by commute time. Estimates commute based on transit mode and travel time. Supports TRANSIT and DRIVING. Developer API requiring implementation.'),

-- Phenom
((SELECT id FROM heatmap_findings WHERE vendor_id='phenom' AND feature_name LIKE '%Talent Matching%'),
  'tier1', 'vendor_documentation',
  'https://www.phenom.com/talent-acquisition',
  'Phenom for Talent Acquisition Leaders',
  '2026-05-16', 'bg',
  'AI-powered candidate matching identifies and prioritizes top skills. Surfaces candidates from public data, past applicants, current employees. Personalized Fit Score with transparent prediction explanations.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='phenom' AND feature_name LIKE '%Analytics%'),
  'tier1', 'vendor_documentation',
  'https://www.phenom.com/talent-analytics',
  'Phenom Talent Analytics',
  '2026-05-16', 'bg',
  'Real-time insights for engagement, hiring, internal mobility. Forecasting trends from predictive analytics. Job-Seeker Behavior forecasting and source attribution.'),

-- Beamery
((SELECT id FROM heatmap_findings WHERE vendor_id='beamery' AND feature_name LIKE '%Talent Graph%'),
  'tier1', 'vendor_documentation',
  'https://www.beamery.com/platform',
  'The AI Platform For Workforce Transformation - Beamery',
  '2026-05-16', 'bg',
  'Digital twin of workforce with dynamic skills, tasks, market data. Ray AI Talent Advisor surfaces transparent context-aware recommendations. Ethical AI as platform pillar. 25% faster performance milestones.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='beamery' AND feature_name LIKE '%Workforce Planning%'),
  'tier1', 'vendor_documentation',
  'https://www.beamery.com/platform',
  'The AI Platform For Workforce Transformation - Beamery',
  '2026-05-16', 'bg',
  'Model change scenarios, anticipate talent risks, uncover automation opportunities. Agile Workforce Intelligence suite. Separately purchasable module within Beamery platform.'),

-- Paradox
((SELECT id FROM heatmap_findings WHERE vendor_id='paradox' AND feature_name LIKE '%Olivia%'),
  'tier1', 'vendor_documentation',
  'https://www.paradox.ai/',
  'Paradox - Meet the AI assistant for all things hiring',
  '2026-05-16', 'bg',
  'Olivia automates hiring tasks. Validates qualifications upfront through chat/text. Flynn Group automates 90% of hiring. 7-Eleven saved 40,000 hours/week. Compass Group: 120,000 hires/year with 20 recruiters.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='paradox' AND feature_name LIKE '%Scheduling%'),
  'tier1', 'vendor_documentation',
  'https://www.paradox.ai/products/screening',
  'Paradox Screening',
  '2026-05-16', 'bg',
  'Olivia screens for role requirements and fast-tracks qualified candidates. If not the right fit, respectfully dispositions them or shares other jobs. 63% reduction time-to-apply. Autonomous rejection confirmed.'),

-- SHL
((SELECT id FROM heatmap_findings WHERE vendor_id='shl' AND feature_name LIKE '%Cognitive%'),
  'tier1', 'vendor_documentation',
  'https://www.shl.com/solutions/products/assessments/',
  'World-Class Talent Assessments - SHL',
  '2026-05-16', 'bg',
  'Evaluate fit, readiness, and potential with personality tests, skills assessments, and job simulations. 300+ people scientists. ML scoring produces well-rounded job score per candidate. Integrates with 80+ ATS.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='shl' AND feature_name LIKE '%Mobility%'),
  'tier1', 'vendor_documentation',
  'https://www.shl.com/solutions/talent-management/talent-mobility/',
  'SHL Talent Mobility - Match People to Opportunities',
  '2026-05-16', 'bg',
  'Objective assessments to understand current workforce skills. Global Skills Assessment (96 skills in 15 minutes). Match individuals to multiple roles. 600+ validated O*Net profiles.'),

-- Textio
((SELECT id FROM heatmap_findings WHERE vendor_id='textio' AND feature_name LIKE '%Job Posts%'),
  'tier1', 'vendor_documentation',
  'https://www.textio.com/recruiting',
  'Textio Recruiting',
  '2026-05-16', 'bg',
  'Generate optimized job posts. Textio Score predicts who will apply. Age Graph, Gender Meter, Custom Brand Guidance. Powered by millions of real hiring outcomes. Detects and eliminates unconscious bias.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='textio' AND feature_name LIKE '%Feedback%'),
  'tier1', 'vendor_documentation',
  'https://www.textio.com/products',
  'Textio Feedback',
  '2026-05-16', 'bg',
  'Helps managers give growth-oriented feedback free of ageism, sexism, racism. Powered by thousands of performance outcomes. Real-time bias detection, tone adjustment, risk detection. 67% increase in feedback quality.'),

-- Verint
((SELECT id FROM heatmap_findings WHERE vendor_id='verint' AND feature_name LIKE '%Interaction%'),
  'tier1', 'vendor_documentation',
  'https://www.verint.com/engagement/our-offerings/solutions/workforce-engagement/interaction-analytics/',
  'Verint CX Analytics - AI-Powered',
  '2026-05-16', 'bg',
  'Interact with customers on any channel while uncovering insights. Most-used and highest-rated speech analytics. Genie Bot uses generative AI embedded in Speech Analytics for immediate insights.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='verint' AND feature_name LIKE '%Quality%'),
  'tier1', 'vendor_documentation',
  'https://www.verint.com/automated-quality-management/',
  'Verint Quality Bot - AI-Powered Automated QM',
  '2026-05-16', 'bg',
  'Autoscore 100% of voice and digital interactions. Assesses agent empathy, script adherence, compliance. FinTech increased compliance coverage from 1% to 96% without adding headcount. Gradual adoption model.'),

-- Five9
((SELECT id FROM heatmap_findings WHERE vendor_id='five9' AND feature_name LIKE '%Virtual%'),
  'tier1', 'vendor_documentation',
  'https://www.five9.com/products/capabilities/intelligent-virtual-agent',
  'Virtual Agent Software | Five9',
  '2026-05-16', 'bg',
  'Practical AI to understand what customers want and provide it quickly without human agent. 25 synthetic voice avatars. Seamless handoff to live agents with context. No-code development platform.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='five9' AND feature_name LIKE '%Agent Assist%'),
  'tier1', 'vendor_documentation',
  'https://www.five9.com/products/capabilities/agent-assist',
  'Five9 AI Agent Assist',
  '2026-05-16', 'bg',
  'Automatically provides real-time guidance cards and checklists. Agents get reminders and tips. Uses OpenAI GPT for auto-generated summaries. Reduced AHT by 30 seconds.'),

-- Talkdesk
((SELECT id FROM heatmap_findings WHERE vendor_id='talkdesk' AND feature_name LIKE '%Mood%'),
  'tier1', 'vendor_documentation',
  'https://www.talkdesk.com/news-and-press/press-releases/navigator-and-mood-insights/',
  'Talkdesk Mood Insights announcement',
  '2026-05-16', 'bg',
  'Evaluates customers emotional states throughout interaction. LLM-powered: captures gratitude, annoyance, relief. Beyond traditional sentiment. Preview feature (renamed Mood Detector May 2025). Not GA.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='talkdesk' AND feature_name LIKE '%QM%' OR (vendor_id='talkdesk' AND feature_name LIKE '%Quality%')),
  'tier1', 'vendor_documentation',
  'https://www.talkdesk.com/cloud-contact-center/wem/quality-management/',
  'Quality Management Software | Talkdesk',
  '2026-05-16', 'bg',
  'AI-driven automation evaluates 100% of interactions. Flexible scorecards with AI scoring. GenAI reviews full conversation context. Add-on requiring additional licensing and Talkdesk enablement.'),

-- Temenos
((SELECT id FROM heatmap_findings WHERE vendor_id='temenos' AND feature_name LIKE '%Credit%'),
  'tier1', 'vendor_documentation',
  'https://www.temenos.com/blog/how-explainable-ai-will-transform-the-banking-industry/',
  'How Explainable AI Will Transform Banking - Temenos',
  '2026-05-16', 'bg',
  'XAI conducts complex eligibility checks while adhering to risk criteria and maintaining transparency. Regulators mandating transparent models. Uses Fuzzy Logic for interpretable IF-Then rules. 3,000+ banks.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='temenos' AND feature_name LIKE '%Financial Crime%'),
  'tier1', 'vendor_documentation',
  'https://www.temenos.com/solutions/financial-crime-mitigation/',
  'Financial Crime Mitigation - Temenos',
  '2026-05-16', 'bg',
  'Creates unique financial DNA per customer from income, spending, transaction patterns. Self-learning algorithms distinguish usual from unusual behavior. FCM AI Agent reduces false positives in real-time screening.'),

-- Verisk
((SELECT id FROM heatmap_findings WHERE vendor_id='verisk' AND feature_name LIKE '%Underwriting%'),
  'tier1', 'vendor_documentation',
  'https://www.verisk.com/insurance/capabilities/underwriting-and-rating/',
  'Underwriting and Rating Solutions - Verisk',
  '2026-05-16', 'bg',
  'Industry-leading datasets for actionable insights. AI/ML for complex variable interactions predicting outcomes. Covers personal property to commercial auto. Scalable risk data.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='verisk' AND feature_name LIKE '%Claims%'),
  'tier1', 'vendor_documentation',
  'https://www.verisk.com/insurance/products/claimsearch/',
  'ClaimSearch - Largest P&C claims intelligence network',
  '2026-05-16', 'bg',
  'Fraud detection at first notice with instant fraud indicators and match reports. 1.8B+ claims records. AI and ML introduced 2018. Digital Media Forensics with 500M images. Contributory network model.')

ON CONFLICT DO NOTHING;
