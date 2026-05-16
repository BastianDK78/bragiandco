-- ============================================================
-- Migration 011: Evidence for batch 3 vendors (v1.3)
-- All findings verified by research agents 2026-05-16
-- ============================================================

-- ══════════════════════════════════════════════════════════════
-- SECTION 1: CORRECTIONS
-- ══════════════════════════════════════════════════════════════

-- iCIMS Video Interview Intelligence — NOT FOUND, unpublish
UPDATE heatmap_findings
SET published = false,
    notes = 'UNPUBLISHED 2026-05-16: iCIMS offers Video Interviews for structured delivery but NO AI-powered video analysis, sentiment scoring, or automated evaluation of video content found.'
WHERE vendor_id = 'icims' AND feature_name = 'Video Interview Intelligence';

-- Verkada: opt-in, not "on when licensed"
UPDATE heatmap_findings
SET default_state = 'Opt-in',
    default_state_note = '(must enable Face Unlock at org level + per device + per user enrollment)'
WHERE vendor_id = 'verkada' AND feature_name = 'Facial Recognition Access';

UPDATE heatmap_findings
SET default_state = 'Opt-in',
    default_state_note = '(requires creating POI profiles + configuring alert schedule)'
WHERE vendor_id = 'verkada' AND feature_name = 'Person of Interest Alerts';

-- Checkr: Assess Lite is free/default, but Premium analytics are paid
UPDATE heatmap_findings
SET default_state_note = '(Assess Lite free with every account; Standard/Premium are upgrades)'
WHERE vendor_id = 'checkr' AND feature_name = 'AI-Powered Adjudication';

UPDATE heatmap_findings
SET feature_name = 'Assess Analytics and Insights',
    feature_desc = 'ML-powered charge classification with predictive funnel analytics',
    default_state = 'Opt-in',
    default_state_note = '(Premium tier paid upgrade)',
    notes = 'Corrected 2026-05-16: Not per-candidate risk scoring. ML classifies charges into 235 categories; analytics predict funnel impact of criteria changes. Renamed from Candidate Insights ML.'
WHERE vendor_id = 'checkr' AND feature_name = 'Candidate Insights ML';

-- SmartRecruiters Bias Insights: not a standalone product
UPDATE heatmap_findings
SET feature_name = 'Fair Hiring AI (embedded bias mitigation)',
    feature_desc = 'Diversity-aware matching that avoids keyword-only screening',
    default_state = 'On by default',
    default_state_note = '(embedded in SmartAssistant matching)',
    notes = 'Corrected 2026-05-16: No standalone "Bias Insights" dashboard. Bias mitigation is embedded in matching technology + separate Diversity Hiring Toolkit. Renamed.'
WHERE vendor_id = 'smartrecruiters' AND feature_name = 'Bias Insights';

-- Gainsight CSM Performance: partial confirmation
UPDATE heatmap_findings
SET feature_name = 'Scorecard and CTA Analytics',
    feature_desc = 'Customer health scoring with automated calls-to-action and risk triage',
    notes = 'Corrected 2026-05-16: No standalone CSM Performance Analytics with AI benchmarking found. Gainsight provides scorecards, CTAs, and risk management frameworks. Staircase AI acquisition adds real-time engagement insights. Renamed.'
WHERE vendor_id = 'gainsight' AND feature_name = 'CSM Performance Analytics';

-- Fireflies Deal Intelligence: conversation analytics, not standalone
UPDATE heatmap_findings
SET feature_desc = 'Topic tracking, sentiment analysis, and competitor mention detection across recorded calls',
    notes = 'Corrected 2026-05-16: Not standalone deal scoring. Conversation Intelligence with topic trackers for competitors, pricing, objections. No pipeline-level deal health score.'
WHERE vendor_id = 'fireflies' AND feature_name = 'Deal Intelligence';

-- Anaplan Workforce Planning: scenario tool, not automated decisions
UPDATE heatmap_findings
SET notes = 'Verified 2026-05-16: Primarily a planning/scenario modeling tool. Models workforce demand and capacity but humans control all final headcount decisions. Lower EU AI Act risk than individual-level tools.'
WHERE vendor_id = 'anaplan' AND feature_name LIKE '%Workforce Planning%';

-- iCIMS rename to reflect actual branding
UPDATE heatmap_findings
SET feature_name = 'Coalesce AI Talent Matching',
    feature_desc = 'Intelligent agents for sourcing, matching, engagement and coordination',
    default_state = 'Configurable',
    default_state_note = '(dial up or down, on or off at any step)',
    notes = 'Verified 2026-05-16: Rebranded to ICIMS Coalesce AI. Certified TrustArc Responsible AI. Sourcing Agent in Early Access (GA Winter 2026). Recruiters stay in control.'
WHERE vendor_id = 'icims' AND feature_name = 'AI Talent Matching';

-- ══════════════════════════════════════════════════════════════
-- SECTION 2: UPGRADE confidence for all verified findings
-- ══════════════════════════════════════════════════════════════

UPDATE heatmap_findings SET confidence = 'verified', verification_method = 'vendor_documentation'
WHERE vendor_id IN ('checkr','sterling','verkada','hikvision','shift-technology','guidewire',
  'visier','anaplan','adp','deel','icims','smartrecruiters','darktrace','crowdstrike',
  'otter-ai','fireflies','gainsight','blue-yonder','ironclad','onetrust')
  AND confidence != 'verified' AND published = true;

-- ══════════════════════════════════════════════════════════════
-- SECTION 3: INSERT evidence sources
-- ══════════════════════════════════════════════════════════════

INSERT INTO finding_sources
  (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt)
VALUES

-- Checkr
((SELECT id FROM heatmap_findings WHERE vendor_id='checkr' AND feature_name='AI-Powered Adjudication'),
  'tier1', 'vendor_documentation',
  'https://checkr.com/products/adjudication',
  'Adjudication | Checkr Products',
  '2026-05-16', 'bg',
  'Proprietary charge classifier uses ML to categorize and compare criminal charges. Assess Lite included free with every account. Automated compliance rules baked into reporting. Assess Premium reduces manual review by 85%.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='checkr' AND feature_name LIKE '%Assess%' AND feature_name != 'AI-Powered Adjudication'),
  'tier1', 'vendor_documentation',
  'https://checkr.com/products/assess',
  'Assess | Checkr Products',
  '2026-05-16', 'bg',
  'Powerful analytics predict funnel impact before making changes to hiring criteria. Discover where to optimize funnel to avoid ruling out qualified candidates. 235 criminal record categories.'),

-- Sterling
((SELECT id FROM heatmap_findings WHERE vendor_id='sterling' AND feature_name='AI-Assisted Verification'),
  'tier1', 'vendor_documentation',
  'https://www.sterlingcheck.com/services/identity-verification/',
  'Identity Solutions You Can Trust | Sterling',
  '2026-05-16', 'bg',
  'AI to scan, verify, and parse global ID document images. ML liveness detection matches government ID to selfie. Identity risk score. 500% growth in identity-first solutions since 2022.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='sterling' AND feature_name='Continuous Monitoring AI'),
  'tier1', 'vendor_documentation',
  'https://fadv.com/solutions/criminal-records-monitoring/',
  'Criminal Records Monitoring | First Advantage',
  '2026-05-16', 'bg',
  'Real-time criminal record reports on ongoing basis. Upload worker roster, system automatically monitors. 90%+ coverage US. 400M court records updated every hour. Event-driven, not periodic.'),

-- Verkada
((SELECT id FROM heatmap_findings WHERE vendor_id='verkada' AND feature_name='Facial Recognition Access'),
  'tier1', 'vendor_documentation',
  'https://www.verkada.com/access-control/access-station/',
  'AF64 Access Station Pro | Verkada',
  '2026-05-16', 'bg',
  'Face Unlock uses facial recognition with infrared 3D sensor to verify identity and protect against spoofing. On-device processing. Max 50,000 faces. Unavailable in Portland, Oregon and Illinois.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='verkada' AND feature_name='Person of Interest Alerts'),
  'tier1', 'vendor_documentation',
  'https://help.verkada.com/verkada-cameras/analytics/create-camera-event-alerts/person-of-interest-alerts',
  'Person of Interest Alerts | Verkada Help',
  '2026-05-16', 'bg',
  'POI alerts notify when specific face detected by camera. Upload image to create POI profile. Configurable notifications. Includes face search across all cameras and license plate association.'),

-- Hikvision
((SELECT id FROM heatmap_findings WHERE vendor_id='hikvision' AND feature_name LIKE '%Facial%'),
  'tier1', 'vendor_documentation',
  'https://www.hikvision.com/us-en/products/access-control-products/face-recognition-terminals/',
  'Face Recognition Terminals - Hikvision',
  '2026-05-16', 'bg',
  'MinMoe terminals reach recognition speed of 0.2 seconds with accuracy over 99%. Dual lenses perform in zero-light environments. Anti-spoofing technology. Under US FCC sanctions.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='hikvision' AND feature_name='Behavior Analysis'),
  'tier1', 'vendor_documentation',
  'https://www.hikvision.com/content/dam/hikvision/products/S000000001/S000000132/S000000014/S000000015/OFR003337/M000007567/User_Manual/UD18053B_Behavior-Analysis-Server_User-Manual_3.2.5_20221125.pdf',
  'Behavior Analysis Server User Manual - Hikvision',
  '2026-05-16', 'bg',
  'DeepinMind detects: loitering, gathering, running, violent motion, mobile phone use, falling down. Deep Learning algorithms on GPU-enabled NVRs. 90% false alarm reduction.'),

-- Shift Technology
((SELECT id FROM heatmap_findings WHERE vendor_id='shift-technology' AND feature_name='Claims Fraud Detection'),
  'tier1', 'vendor_documentation',
  'https://www.shift-technology.com/solutions/fraud-risk',
  'Shift Fraud & Risk',
  '2026-05-16', 'bg',
  'Analyzes for fraud and automates triage for high-risk cases. Insurance Data Network uncovers complex multi-carrier schemes. Human-in-the-loop by design. $2B fraud uncovered in US in 2025.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='shift-technology' AND feature_name='Underwriting AI'),
  'tier1', 'vendor_documentation',
  'https://www.shift-technology.com/resources/reports-and-insights/ai-in-underwriting-case-examples-from-leading-insurers',
  'AI in insurance underwriting: use cases from leading insurers',
  '2026-05-16', 'bg',
  'Generated more than $15 per new policy in prevented losses, projected $30M+ annually. AI-powered detection enables optimized pricing, prevents fraud entering the book. 40% impact rate on policy alerts.'),

-- Guidewire
((SELECT id FROM heatmap_findings WHERE vendor_id='guidewire' AND feature_name LIKE '%Underwriting%'),
  'tier1', 'vendor_documentation',
  'https://www.guidewire.com/products/analytics/predict',
  'Guidewire Predict (Analytics)',
  '2026-05-16', 'bg',
  'Embed predictive analytics into underwriting and claims. Make smarter decisions on risk selection, pricing, claims triage. $50M annual R&D. 26M+ claims feed Data Cooperative models.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='guidewire' AND feature_name LIKE '%ClaimCenter%'),
  'tier1', 'vendor_documentation',
  'https://www.guidewire.com/products/analytics/industry-intel',
  'Guidewire Industry Intel - Claims Intel',
  '2026-05-16', 'bg',
  'Claims Intel provides insights at first notice throughout claims lifecycle. Scores integrated into ClaimCenter. Built on pooled data representing $326B+ in DWP. Auto, WC, and commercial lines.'),

-- Visier
((SELECT id FROM heatmap_findings WHERE vendor_id='visier' AND feature_name LIKE '%Attrition%'),
  'tier1', 'vendor_documentation',
  'https://www.visier.com/blog/predictive-people-analytics-machine-learning/',
  'Validating Predictive People Analytics and ML - Visier',
  '2026-05-16', 'bg',
  'Up to 17x more accurate than guesswork at predicting risk of exit. Random forest algorithm examines historical employee data. Users can remove attributes that could lead to unintended bias.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='visier' AND feature_name LIKE '%Compensation%'),
  'tier1', 'vendor_documentation',
  'https://www.visier.com/blog/gender-wage-gap-2025-visier-customers-outperform/',
  'Gender Wage Gap 2025 Status | Visier',
  '2026-05-16', 'bg',
  'Workforce analytics provides visibility into pay equity issues. Identifies hidden biases, analyzes representation, benchmarks compensation fairly. Based on 25M+ live employee records from 55K+ customers.'),

-- Anaplan
((SELECT id FROM heatmap_findings WHERE vendor_id='anaplan' AND feature_name LIKE '%Workforce%'),
  'tier1', 'vendor_documentation',
  'https://www.anaplan.com/solutions/capacity-planning-optimization/',
  'Workforce Capacity Planning | Anaplan',
  '2026-05-16', 'bg',
  'Identify workforce risks, understand headcount decision impact in real-time. AI agent for smarter workforce planning. Scenario modeling tool — humans control all final decisions.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='anaplan' AND feature_name LIKE '%PlanIQ%'),
  'tier1', 'vendor_documentation',
  'https://www.anaplan.com/platform/anaplan-planiq/',
  'Anaplan PlanIQ: AI-Powered Forecasting',
  '2026-05-16', 'bg',
  'Combines statistical, AI, and ML techniques. Choose from DeepAR+ or Prophet. In 70% of predictions ML delivers same or greater accuracy than expert. Start seeing impact in days.'),

-- ADP
((SELECT id FROM heatmap_findings WHERE vendor_id='adp' AND feature_name LIKE '%DataCloud%'),
  'tier1', 'vendor_documentation',
  'https://www.adp.com/what-we-offer/products/adp-datacloud.aspx',
  'Workforce Analytics | ADP DataCloud',
  '2026-05-16', 'bg',
  'AI-powered analytics drive growth throughout employee lifecycle. Preconfigured KPIs. Benchmarks from 39M+ employees. Predictive analytics surface workforce trends including top performer flight risk.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='adp' AND feature_name LIKE '%Self-Service%'),
  'tier1', 'vendor_documentation',
  'https://www.adp.com/what-we-offer/ai-solutions/ai-agents.aspx',
  'AI Agents for Payroll & HR | ADP',
  '2026-05-16', 'bg',
  'ADP Assist agents review company policies, benefits, compliance guidelines. Provide employees clear answers aligned to organizational rules. Saved 19,000 minutes across 600+ orgs in one month.'),

-- Deel
((SELECT id FROM heatmap_findings WHERE vendor_id='deel' AND feature_name LIKE '%Classification%'),
  'tier1', 'vendor_documentation',
  'https://www.deel.com/blog/how-ai-and-data-labelers-can-avoid-contractor-misclassification-risks/',
  'How AI Can Avoid Contractor Misclassification Risks - Deel',
  '2026-05-16', 'bg',
  'AI-powered classification tool uses latest local case law to assess workforce with 90% accuracy. Answer questions to identify which workers should be employees or contractors.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='deel' AND feature_name LIKE '%Compliance Risk%'),
  'tier1', 'vendor_documentation',
  'https://www.deel.com/blog/misclassification-of-employees-as-independent-contractors/',
  'The Definitive Employer Guide to Worker Classification - Deel',
  '2026-05-16', 'bg',
  'Continuous Compliance Hub tracks updates in labor and tax laws worldwide. Compliance Monitor flags risks and provides recommended actions. Monitors classification drift over time.'),

-- Darktrace
((SELECT id FROM heatmap_findings WHERE vendor_id='darktrace' AND feature_name LIKE '%Immune%'),
  'tier1', 'vendor_documentation',
  'https://www.darktrace.com/products/detect',
  'Darktrace ActiveAI Security Platform',
  '2026-05-16', 'bg',
  'Self-Learning AI learns from unique business data to identify anomalous activity. Continuously learns and adapts, developing understanding of normal employee behavior. Less than 4% of investigations require human review.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='darktrace' AND feature_name LIKE '%Insider%'),
  'tier1', 'vendor_documentation',
  'https://www.darktrace.com/solutions/insider-threat',
  'Identify Insider Threats | Darktrace',
  '2026-05-16', 'bg',
  'Self-Learning AI develops understanding of normal employee behavior. Detects subtle anomalies that could indicate insider threat. Autonomous Response can block traffic, force logouts, disable accounts. Winner Best Insider Threat Solution 2025.'),

-- CrowdStrike
((SELECT id FROM heatmap_findings WHERE vendor_id='crowdstrike' AND feature_name LIKE '%Risk Scoring%'),
  'tier1', 'vendor_documentation',
  'https://www.crowdstrike.com/en-us/platform/next-gen-identity-security/ueba/',
  'AI-powered UEBA | CrowdStrike Falcon Identity Protection',
  '2026-05-16', 'bg',
  'Continuously assessing user behavior and risk levels. Dynamically enforces MFA. Over 100 behavior analytics and risk scores for every account. 310% ROI per Forrester TEI.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='crowdstrike' AND feature_name LIKE '%Behavioral%'),
  'tier1', 'vendor_documentation',
  'https://www.crowdstrike.com/en-us/platform/next-gen-identity-security/ueba/',
  'AI-powered UEBA | CrowdStrike Falcon Identity Protection',
  '2026-05-16', 'bg',
  'AI establishes normal behavior baselines, identifying deviations for proactive threat prevention. Automatically baselines normal user behavior with advanced AI/ML to stop suspicious activity.'),

-- iCIMS
((SELECT id FROM heatmap_findings WHERE vendor_id='icims' AND feature_name LIKE '%Coalesce%'),
  'tier1', 'vendor_documentation',
  'https://www.icims.com/products/ai-recruiting-software/',
  'ICIMS Coalesce AI | AI Recruiting Software',
  '2026-05-16', 'bg',
  'Intelligent agents support sourcing, matching, engagement, coordination. Recruiters stay in control choosing how much autonomy to enable. Certified TrustArc Responsible AI. Configurable on/off per step.'),

-- SmartRecruiters
((SELECT id FROM heatmap_findings WHERE vendor_id='smartrecruiters' AND feature_name LIKE '%SmartAssistant%'),
  'tier1', 'vendor_documentation',
  'https://www.smartrecruiters.com/recruiting-software/ai-recruiting-technology/',
  'AI Recruiting Technology | SmartRecruiters',
  '2026-05-16', 'bg',
  'SmartAssistant screens applicants instantaneously, conducts in-depth candidate analysis backed by data science, prioritizes with scored matches. Now rebranded as Winston Intelligence.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='smartrecruiters' AND feature_name LIKE '%Fair Hiring%'),
  'tier1', 'vendor_documentation',
  'https://www.smartrecruiters.com/resources/article/ai-hiring-software-has-many-powers/',
  'How AI Hiring Software Streamlines Recruitment | SmartRecruiters',
  '2026-05-16', 'bg',
  'Matches candidate fit with context not just keywords. Can find candidates who did not go to prestigious college or work for brand-name employer. Promotes diversity through non-keyword matching.'),

-- Otter.ai
((SELECT id FROM heatmap_findings WHERE vendor_id='otter-ai' AND feature_name LIKE '%Transcription%'),
  'tier1', 'vendor_documentation',
  'https://otter.ai/',
  'Otter Meeting Agent - AI Notetaker',
  '2026-05-16', 'bg',
  'AI Notetaker with transcription, automated summaries, AI Chat. Live transcription in multiple languages with speaker recognition. Turns every meeting into summary with decisions and action items.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='otter-ai' AND feature_name LIKE '%Sales%'),
  'tier1', 'vendor_documentation',
  'https://otter.ai/sales-agent',
  'Otter.ai - AI Sales Notetaker',
  '2026-05-16', 'bg',
  'Real-time sales insights: objections, competitor mentions, pricing discussions. Live coaching for objection handling. Deal intelligence extracts buying signals. CRM syncing to Salesforce/HubSpot.'),

-- Fireflies
((SELECT id FROM heatmap_findings WHERE vendor_id='fireflies' AND feature_name LIKE '%Meeting%'),
  'tier1', 'vendor_documentation',
  'https://fireflies.ai/conversation-intelligence',
  'Conversation Intelligence | Fireflies.ai',
  '2026-05-16', 'bg',
  'Consolidates insights around speakers, topics, sentiment. Compare trends and measure conversation quality over time. 95%+ accurate transcription in 100+ languages. SOC 2, GDPR, HIPAA compliant.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='fireflies' AND feature_name='Deal Intelligence'),
  'tier1', 'vendor_documentation',
  'https://fireflies.ai/conversation-intelligence',
  'Conversation Intelligence | Fireflies.ai',
  '2026-05-16', 'bg',
  'Track topics like features, competitors, price, objections. Detailed analytics across every conversation for sales teams. Topic Trackers for custom keyword monitoring. CRM auto-fill integration.'),

-- Gainsight
((SELECT id FROM heatmap_findings WHERE vendor_id='gainsight' AND feature_name LIKE '%Health%'),
  'tier1', 'vendor_documentation',
  'https://www.gainsight.com/glossary/entry/predicting-customer-churn/',
  'Predicting Customer Churn | Gainsight',
  '2026-05-16', 'bg',
  'AI-powered unified health score consolidating churn prediction, sentiment analysis, and risk signals. CLV-based churn prediction. Calls-to-Action triggered by risk thresholds.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='gainsight' AND feature_name LIKE '%Scorecard%'),
  'tier1', 'vendor_documentation',
  'https://www.gainsight.com/blog/how-gainsight-uses-scorecards-and-calls-to-action/',
  'How Gainsight uses Scorecards and CTAs',
  '2026-05-16', 'bg',
  'Eight risk categories with CTAs for each. Data from CRM, product usage, support tickets, financial data into composite health. Staircase AI acquisition adds real-time engagement insights.'),

-- Blue Yonder
((SELECT id FROM heatmap_findings WHERE vendor_id='blue-yonder' AND feature_name LIKE '%Demand%'),
  'tier1', 'vendor_documentation',
  'https://blueyonder.com/solutions/supply-chain-planning/demand-planning',
  'Demand Planning Software | Blue Yonder',
  '2026-05-16', 'bg',
  'Statistical methods, ML and AI for demand sensing. 12% improvement in forecast accuracy. Patented algorithms with deep meta learning. Leader in Gartner MQ Supply Chain Planning 2026.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='blue-yonder' AND feature_name LIKE '%Supplier%'),
  'tier1', 'vendor_documentation',
  'https://blueyonder.com/why-blue-yonder/ai-and-machine-learning',
  'AI Supply Chain Software | Blue Yonder',
  '2026-05-16', 'bg',
  'AI agents continuously monitor supply chain, spotting disruptions before they affect operations. Generate actionable alerts, recommend solutions. Dynamic risk scoring for supplier disruption management.'),

-- Ironclad
((SELECT id FROM heatmap_findings WHERE vendor_id='ironclad' AND feature_name LIKE '%Contract Review%'),
  'tier1', 'vendor_documentation',
  'https://ironcladapp.com/product/jurist/',
  'JURIST - AI Contract Partner | Ironclad',
  '2026-05-16', 'bg',
  'Identifies and extracts legal, financial, operational risks based on company playbooks. Built on 2B+ contracts. Multi-agent architecture. ISO 27001 and SOC 2 Type II. MNDA review in minutes vs hours.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='ironclad' AND feature_name LIKE '%Playbook%'),
  'tier1', 'vendor_documentation',
  'https://ironcladapp.com/product/jurist/',
  'JURIST - AI Contract Partner | Ironclad',
  '2026-05-16', 'bg',
  'Upload company playbook, click Redline, automatically redline entire contract against predefined positions and fallbacks. Highlights missing clauses, risky terms, compliance gaps. Beta access.'),

-- OneTrust
((SELECT id FROM heatmap_findings WHERE vendor_id='onetrust' AND feature_name LIKE '%AI Risk%'),
  'tier1', 'vendor_documentation',
  'https://www.onetrust.com/solutions/ai-governance/',
  'AI Governance | OneTrust',
  '2026-05-16', 'bg',
  'Centralize AI risk, ownership, compliance. EU AI Act, NIST, ISO 42001 templates. Automate risk tiering workflows. Runtime guardrails with prompt/output filtering. Real-time policy violation detection.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='onetrust' AND feature_name LIKE '%Vendor Risk%'),
  'tier1', 'vendor_documentation',
  'https://www.onetrust.com/products/third-party-risk-management/',
  'Third-Party Risk Management | OneTrust',
  '2026-05-16', 'bg',
  'AI ingests external risk evidence and generates questionnaire responses. Auto-approval workflows for low-risk third parties. 20M+ cyber risk insights. Accelerates assessments by up to 70%.')

ON CONFLICT DO NOTHING;
