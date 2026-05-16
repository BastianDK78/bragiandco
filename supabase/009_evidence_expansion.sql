-- ============================================================
-- Migration 009: Evidence for 20 new vendors (v1.2)
-- All 37 findings verified by research agents 2026-05-16
-- ============================================================

-- ══════════════════════════════════════════════════════════════
-- SECTION 1: CORRECTIONS from research
-- ══════════════════════════════════════════════════════════════

-- Zoom AI Companion: DISABLED by default, not on
UPDATE heatmap_findings
SET default_state = 'Disabled by default',
    default_state_note = '(admin must enable at account level, then user opts in per-meeting via AI Companion icon)',
    notes = 'Verified 2026-05-16: Northwestern Univ. March 2026 confirms disabled in all accounts by default. Requires dual opt-in (admin + user). Participants must consent when AI active.'
WHERE vendor_id = 'zoom-ai';

-- Microsoft Copilot: both are opt-in (require add-on license)
UPDATE heatmap_findings
SET default_state = 'Opt-in',
    default_state_note = '(requires M365 Copilot add-on license; admin policy controls per-meeting)'
WHERE vendor_id = 'microsoft-copilot' AND feature_name = 'Meeting Summarisation';

UPDATE heatmap_findings
SET default_state = 'Opt-in',
    default_state_note = '(requires M365 Copilot add-on license; user must actively invoke Copilot)'
WHERE vendor_id = 'microsoft-copilot' AND feature_name LIKE '%Email%';

-- Salesforce Sales Cloud: opt-in (must enable in Setup)
UPDATE heatmap_findings
SET default_state = 'Opt-in',
    default_state_note = '(Setup > Einstein Sales > enable; admin selects scoring fields)'
WHERE vendor_id = 'salesforce-sales';

-- ServiceNow: opt-in (requires guided setup)
UPDATE heatmap_findings
SET default_state = 'Opt-in',
    default_state_note = '(requires guided setup and configuration)'
WHERE vendor_id = 'servicenow';

-- Slack AI: depends on plan tier
UPDATE heatmap_findings
SET default_state = 'Plan-dependent',
    default_state_note = '(Summaries: Pro+; Search/Recaps: Business+; admins can restrict)'
WHERE vendor_id = 'slack-ai';

-- Culture Amp Performance Predictions: correct feature description
UPDATE heatmap_findings
SET feature_name = 'AI Coach in Perform',
    feature_desc = 'AI assists managers in writing performance reviews with specific, balanced feedback',
    risk_level = 'yellow',
    default_state = 'Opt-in',
    default_state_note = '(AI features can be enabled/disabled per org; currently free for all users)',
    deployer_obligation_gap = 'Art. 13 employee notice (AI assists their review) · Lower risk: assists writing, does not predict performance trajectory',
    notes = 'Corrected 2026-05-16: Culture Amp does NOT offer standalone performance prediction. AI Coach helps managers write reviews — it does not predict future performance. Downgraded from red to yellow.'
WHERE vendor_id = 'culture-amp' AND feature_name = 'Performance Predictions';

-- Culture Amp Flight Risk: operates at group level
UPDATE heatmap_findings
SET default_state = 'Opt-in',
    default_state_note = '(requires HRIS connection + engagement survey deployment)',
    notes = 'Verified 2026-05-16: Retention Insights operates at GROUP level (department, role, tenure), not individual predictions. Most predictive signal is "I see myself still working at [Company] in two years" survey response. Risk level may warrant downgrade.'
WHERE vendor_id = 'culture-amp' AND feature_name = 'Flight Risk Indicator';

-- Workday Peakon Attrition: population-level forecasting
UPDATE heatmap_findings
SET risk_level = 'yellow',
    default_state_note = '(Employee Voice retention module)',
    notes = 'Corrected 2026-05-16: Forecasts attrition at POPULATION level (by department, location, tenure), not per-individual. Downgraded from red to yellow. Uses aggregate real-time feedback, not individual risk scores.',
    deployer_obligation_gap = 'Art. 13 employee notice (data feeds predictions) · Lower risk than individual scoring · Confirm no individual-level surfacing to managers'
WHERE vendor_id = 'workday-peakon' AND feature_name = 'Attrition Prediction';

-- UKG GPTW: aggregate level
UPDATE heatmap_findings
SET notes = 'Verified 2026-05-16: Operates at organizational/team aggregate level. Culture and trust scoring by group, not individual employees. GenAI trained on 30 years of GPTW research (100M+ employee responses).'
WHERE vendor_id = 'ukg' AND feature_name LIKE '%Great Place%';

-- ══════════════════════════════════════════════════════════════
-- SECTION 2: UPGRADE confidence for all verified findings
-- ══════════════════════════════════════════════════════════════

UPDATE heatmap_findings SET confidence = 'verified', verification_method = 'vendor_documentation'
WHERE vendor_id IN ('experian','fico','zest-ai','cornerstone','docebo','microsoft-copilot',
  'salesforce-sales','servicenow','slack-ai','zoom-ai','eightfold','harver',
  'workday-peakon','culture-amp','ukg','gong','qualtrics','sap-s4hana','oracle-erp','adobe-experience')
  AND confidence != 'verified';

-- ══════════════════════════════════════════════════════════════
-- SECTION 3: INSERT evidence sources
-- ══════════════════════════════════════════════════════════════

INSERT INTO finding_sources
  (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt)
VALUES

-- Experian
((SELECT id FROM heatmap_findings WHERE vendor_id='experian' AND feature_name='PowerCurve Originations'),
  'tier1', 'vendor_documentation',
  'https://www.experian.com/business/solutions/credit-decisioning',
  'Credit Decisioning - Experian Business',
  '2026-05-16', 'bg',
  'Enterprisewide credit decisioning engine facilitates faster decisions. Processes 1+ billion real-time integrated decisioning transactions. ML analytics combined with proprietary data to return a single optimal decision.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='experian' AND feature_name='Ascend Intelligence Services'),
  'tier1', 'vendor_documentation',
  'https://www.experian.com/business/products/ascend-intelligence-services',
  'Ascend Intelligence Services - Experian Business',
  '2026-05-16', 'bg',
  'Uses the best data and AI/ML to build highly predictive custom models, creating sophisticated decision strategies. 20+ years full-file consumer credit information. 2,100+ advanced credit attributes.'),

-- FICO
((SELECT id FROM heatmap_findings WHERE vendor_id='fico' AND feature_name='FICO Score'),
  'tier1', 'vendor_documentation',
  'https://www.myfico.com/credit-education/what-is-a-fico-score',
  'What is a FICO Score? - myFICO',
  '2026-05-16', 'bg',
  'A FICO Score is a three-digit number based on credit report information. Used by 90% of top lenders. Helps determine how likely you are to repay a loan.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='fico' AND feature_name='FICO Decision Management Platform'),
  'tier1', 'vendor_documentation',
  'https://www.fico.com/en/platform',
  'FICO Platform - The Future of Decisioning',
  '2026-05-16', 'bg',
  'Revolutionizes how organizations make decisions. Always-on customer intelligence that evolves with every interaction. Thousands of connected decisions adapt instantly. Leader in 2026 Gartner Magic Quadrant.'),

-- Zest AI
((SELECT id FROM heatmap_findings WHERE vendor_id='zest-ai' AND feature_name='Zest Model Management'),
  'tier1', 'vendor_documentation',
  'https://www.zest.ai/',
  'Zest AI - AI-Automated Underwriting',
  '2026-05-16', 'bg',
  'Automate your underwriting with confidence. Make smarter credit decisions, faster, while giving all applicants a fair shot. Commonwealth Credit Union: 30-40% lower delinquency ratios than peers.'),

-- Cornerstone
((SELECT id FROM heatmap_findings WHERE vendor_id='cornerstone' AND feature_name='AI Skills Graph'),
  'tier1', 'vendor_documentation',
  'https://www.cornerstoneondemand.com/platform/skills-engine/',
  'Cornerstone Skills Engine - SkyHive',
  '2026-05-16', 'bg',
  'SkyHive by Cornerstone ingests labor market data to drive insights. 28TB global labor market data processed daily. 150T computations against 1B profiles. Automatic skill insights for every employee.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='cornerstone' AND feature_name='Content Recommendations'),
  'tier1', 'vendor_documentation',
  'https://www.cornerstoneondemand.com/platform/content-curation/',
  'Cornerstone Content Studio',
  '2026-05-16', 'bg',
  'End-to-end AI-powered discovery, curation, creation, and insights solution. AI-driven recommendations improve knowledge retention and application driving faster time-to-productivity.'),

-- Docebo
((SELECT id FROM heatmap_findings WHERE vendor_id='docebo' AND feature_name LIKE '%Auto-Tagging%'),
  'tier1', 'vendor_documentation',
  'https://www.docebo.com/platform/',
  'Docebo Learning Platform',
  '2026-05-16', 'bg',
  'AI content creation that builds in seconds. Generative AI tools to create interactive and personalized learning content at scale. Integrates 365Talents for skills intelligence.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='docebo' AND feature_name='Virtual Coach'),
  'tier1', 'vendor_documentation',
  'https://www.docebo.com/platform/',
  'Docebo Learning Platform',
  '2026-05-16', 'bg',
  'AI coaching with real-time feedback. Listed as primary platform capability alongside learning management, AI content creation, and reporting.'),

-- Microsoft Copilot
((SELECT id FROM heatmap_findings WHERE vendor_id='microsoft-copilot' AND feature_name='Meeting Summarisation'),
  'tier1', 'vendor_documentation',
  'https://learn.microsoft.com/en-us/microsoftteams/copilot-teams-transcription',
  'Manage Microsoft 365 Copilot in Teams meetings and events',
  '2026-05-16', 'bg',
  'AI tool that captures important conversation points. Who said what, where people agree or disagree, recommends follow-up tasks in real time. Controlled via CsTeamsMeetingPolicy; organizers set per-meeting.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='microsoft-copilot' AND feature_name LIKE '%Email%'),
  'tier1', 'vendor_documentation',
  'https://learn.microsoft.com/en-us/copilot/microsoft-365/microsoft-365-copilot-overview',
  'Microsoft 365 Copilot overview',
  '2026-05-16', 'bg',
  'Outlook coaching tips: suggestions on clarity, sentiment, and tone. Summarize email threads. Draft from other emails or content. Uses Microsoft Graph for personalization. User must actively invoke.'),

-- Salesforce Sales Cloud
((SELECT id FROM heatmap_findings WHERE vendor_id='salesforce-sales' AND feature_name='Einstein Lead Scoring'),
  'tier1', 'vendor_documentation',
  'https://help.salesforce.com/s/articleView?id=ai.einstein_sales_setup_enable_lead_insights.htm&language=en_US&type=5',
  'Enable Einstein Lead Scoring - Salesforce Help',
  '2026-05-16', 'bg',
  'ML analyzes historically converted leads and identifies scoring criteria with greatest impact on conversion. Must be explicitly enabled via Setup > Einstein Sales. Admin selects conversion milestone and fields.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='salesforce-sales' AND feature_name LIKE '%Opportunity%'),
  'tier1', 'vendor_documentation',
  'https://help.salesforce.com/s/articleView?id=sales.pipeline_inspection_close_date_predictions.htm&language=en_US&type=5',
  'Einstein Deal Insights - Salesforce Help',
  '2026-05-16', 'bg',
  'Uses data science and ML to show insights and predictions about deal health with recommended actions. Flags opportunities trending negatively. Enabled via Setup > Einstein Deal Insights.'),

-- ServiceNow
((SELECT id FROM heatmap_findings WHERE vendor_id='servicenow' AND feature_name='Virtual Agent'),
  'tier1', 'vendor_documentation',
  'https://www.servicenow.com/products/virtual-agent.html',
  'Virtual Agent - Chatbot - ServiceNow',
  '2026-05-16', 'bg',
  'GenAI-powered conversational chatbot for employees and customers. Understands what users mean and processes nonlinear conversations. Requires guided setup and configuration.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='servicenow' AND feature_name='Predictive Intelligence'),
  'tier1', 'vendor_documentation',
  'https://www.servicenow.com/docs/r/washingtondc/it-service-management/predictive-intelligence-for-incident.html',
  'Predictive Intelligence for Incident Management - ServiceNow',
  '2026-05-16', 'bg',
  'ML to categorize and route incidents automatically. Predicts Assignment group and Category from Short description. Requires training on historical data. Precision 99.46% for hardware categorization.'),

-- Slack AI
((SELECT id FROM heatmap_findings WHERE vendor_id='slack-ai'),
  'tier1', 'vendor_documentation',
  'https://slack.com/help/articles/25076892548883-Guide-to-AI-features-in-Slack',
  'Guide to AI features in Slack',
  '2026-05-16', 'bg',
  'AI summarizes conversations in seconds. Ask questions in your own words and get concise answers from messages and files. Only includes info user has access to. Data never used to train LLMs.'),

-- Zoom AI
((SELECT id FROM heatmap_findings WHERE vendor_id='zoom-ai'),
  'tier1', 'vendor_documentation',
  'https://explore.zoom.us/en/ai-assistant/',
  'Zoom AI Companion 3.0',
  '2026-05-16', 'bg',
  'Meeting Summary generates concise post-meeting summaries with next steps. Smart Recordings adds chapters and highlights. DISABLED by default in all accounts. Requires admin enable + user opt-in per meeting.'),

-- Eightfold
((SELECT id FROM heatmap_findings WHERE vendor_id='eightfold' AND feature_name='Talent Intelligence Platform'),
  'tier1', 'vendor_documentation',
  'https://eightfold.ai/learn/eightfold-talent-intelligence-platform-demo/',
  'Eightfold Talent Intelligence Platform',
  '2026-05-16', 'bg',
  'Deep Learning analyzes talent against 1 billion+ global profiles to rank candidates by experience, skills and potential while masking personal info. 50+ variables driving scoring. 1.6B+ career trajectories.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='eightfold' AND feature_name LIKE '%Career%'),
  'tier1', 'vendor_documentation',
  'https://eightfold.ai/blog/eightfold-improves-internal-mobility/',
  'How Eightfold improves internal mobility',
  '2026-05-16', 'bg',
  'Career Hub: AI revealed unexpected role match with 82% compatibility score. Matches all employees to relevant open positions they have potential to succeed in. Individual-level scoring.'),

-- Harver
((SELECT id FROM heatmap_findings WHERE vendor_id='harver' AND feature_name='Pre-Employment Assessments'),
  'tier1', 'vendor_documentation',
  'https://harver.com/assessments/',
  'Predictive Assessments Backed by Science - Harver',
  '2026-05-16', 'bg',
  '450+ science-backed assessments predict which candidates will be great, good, and poor fits within minutes. Fully explainable decisions meeting NYC LL-144 standards. EEOC and UGESP compliant.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='harver' AND feature_name LIKE '%Situational%'),
  'tier1', 'vendor_documentation',
  'https://harver.com/blog/situational-judgement-test/',
  'Situational Judgement Test - Harver',
  '2026-05-16', 'bg',
  'Interactive video SJTs customizable per role. Top performer analysis identifies responses predictive for success. Designed by IO psychologists, validated against actual employees.'),

-- Workday Peakon
((SELECT id FROM heatmap_findings WHERE vendor_id='workday-peakon' AND feature_name LIKE '%Sentiment%'),
  'tier1', 'vendor_documentation',
  'https://www.workday.com/en-us/products/employee-voice/overview.html',
  'Workday Peakon Employee Voice',
  '2026-05-16', 'bg',
  'AI-powered listening solution keeps pulse on how people feel. Identifies important themes raised by employees. Gen-AI themes and summaries. Operates at team/group aggregate level with anonymized individual responses.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='workday-peakon' AND feature_name LIKE '%Attrition%'),
  'tier1', 'vendor_documentation',
  'https://www.workday.com/en-us/products/employee-voice/employee-retention.html',
  'Employee Retention Software - Workday',
  '2026-05-16', 'bg',
  'Forecasts attrition risk among different employee populations using real-time feedback and Workday Illuminate. Operates at POPULATION level (department, location, tenure), not per-individual.'),

-- Culture Amp
((SELECT id FROM heatmap_findings WHERE vendor_id='culture-amp' AND feature_name LIKE '%Coach%' OR (vendor_id='culture-amp' AND feature_name='Performance Predictions')),
  'tier1', 'vendor_documentation',
  'https://www.cultureamp.com/platform/ai',
  'Turn employee feedback into action with Culture Amp AI',
  '2026-05-16', 'bg',
  'AI analyzes performance data to guide managers in crafting specific, balanced feedback. Does NOT predict performance trajectories. Assists review writing. Opt-in, currently free for all users.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='culture-amp' AND feature_name='Flight Risk Indicator'),
  'tier1', 'vendor_documentation',
  'https://www.cultureamp.com/p/employee-turnover-prediction',
  'Employee Turnover Prediction | Culture Amp',
  '2026-05-16', 'bg',
  'Retention Insights predicts who is at risk of leaving and why. Turnover Probability Analysis at group/filter level. Most predictive question: I see myself still working at Company in two years.'),

-- UKG
((SELECT id FROM heatmap_findings WHERE vendor_id='ukg' AND feature_name LIKE '%Workforce%'),
  'tier1', 'vendor_documentation',
  'https://www.ukg.com/products/ukg-bryte-ai',
  'Reveal the unseen with UKG Bryte AI',
  '2026-05-16', 'bg',
  'Agentic AI adapts to business: forecasting demand, optimizing schedules, automating time and pay. Clear performance insights of team and individual leadership strengths. Saves 40 hours/week on recruiting.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='ukg' AND feature_name LIKE '%Great Place%'),
  'tier1', 'vendor_documentation',
  'https://www.ukg.com/products/features/great-place-to-work',
  'Great Place To Work Hub - UKG',
  '2026-05-16', 'bg',
  'AI uncovers unseen trends in open-ended feedback. Identifies consistent themes in employee sentiment. Detects gaps in trust, communication, or leadership. GenAI trained on 30 years GPTW research (100M+ responses).'),

-- Gong
((SELECT id FROM heatmap_findings WHERE vendor_id='gong' AND feature_name LIKE '%Call Recording%'),
  'tier1', 'vendor_documentation',
  'https://www.gong.io/revenue-intelligence/',
  'What is a Revenue Intelligence Platform? | Gong',
  '2026-05-16', 'bg',
  'Revenue intelligence provides comprehensive visibility into buyer relationships. AI-powered insights from all touchpoints. Automatically records, transcribes, and analyzes all customer calls once deployed.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='gong' AND feature_name LIKE '%Rep Performance%'),
  'tier1', 'vendor_documentation',
  'https://www.gong.io/sales-coaching',
  'Revolutionize Sales Coaching - Gong',
  '2026-05-16', 'bg',
  'Captures and analyzes every word from every sales conversation. AI reveals each rep strengths and areas for growth. Identifies personalized coaching moments per rep. Individual-level performance profiling.'),

-- Qualtrics
((SELECT id FROM heatmap_findings WHERE vendor_id='qualtrics' AND feature_name LIKE '%Employee%'),
  'tier1', 'vendor_documentation',
  'https://www.qualtrics.com/employee-experience/',
  'Employee Experience Software - Qualtrics',
  '2026-05-16', 'bg',
  'Managers get personalized insights and recommended actions. Identify flight risk early and intervene with confidence. Solutions identify employees at risk for attrition. World largest database of human sentiment.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='qualtrics' AND feature_name='Manager Assist'),
  'tier1', 'vendor_documentation',
  'https://www.qualtrics.com/support/employee-experience/manager-assist/using-manager-assist/',
  'Using Manager Assist - Qualtrics',
  '2026-05-16', 'bg',
  'Separate landing page for managers to view and act on employee experience insights. Must be activated by Brand Administrator. Provides team-level recommendations, not individual predictions.'),

-- SAP S/4HANA
((SELECT id FROM heatmap_findings WHERE vendor_id='sap-s4hana' AND feature_name LIKE '%Finance%'),
  'tier1', 'vendor_documentation',
  'https://community.sap.com/t5/financial-management-blog-posts-by-sap/infusing-ai-into-journal-entry-process-beyond-automation/ba-p/13956185',
  'Infusing AI into Journal Entry Process - Beyond Automation',
  '2026-05-16', 'bg',
  'AI-enabled solution detects anomalies by analyzing historical data, policy documents, and attachments. Validates Amount, GL Code, Description. Entries parked for review before posting. Opt-in via BTP AI Services.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='sap-s4hana' AND feature_name LIKE '%Material%'),
  'tier1', 'vendor_documentation',
  'https://community.sap.com/t5/enterprise-resource-planning-blogs-by-members/s-4hana-predictive-material-and-resource-planning-pmrp/ba-p/13456779',
  'S/4HANA Predictive Material and Resource Planning (pMRP)',
  '2026-05-16', 'bg',
  'Enables creation and scheduling of pMRP simulations for production planning. Early-stage detection of material and capacity constraints. Simulation tool that planners choose to run. Results must be explicitly applied.'),

-- Oracle ERP
((SELECT id FROM heatmap_findings WHERE vendor_id='oracle-erp' AND feature_name LIKE '%Process Automation%'),
  'tier1', 'vendor_documentation',
  'https://www.oracle.com/applications/fusion-ai/',
  'Oracle AI for Fusion Applications',
  '2026-05-16', 'bg',
  'Payables Agent automates multichannel invoice processing: ingest, extract, match to POs, apply tax/policy/fraud checks, route for approval. Embedded in Fusion Cloud ERP. Agents must be enabled by administrators.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='oracle-erp' AND feature_name LIKE '%Adaptive%'),
  'tier1', 'vendor_documentation',
  'https://docs.oracle.com/cloud/latest/adaptive-intelligent-apps-mfg/AIMUG/T667475T667478.htm',
  'Oracle Adaptive Intelligent Apps for Manufacturing',
  '2026-05-16', 'bg',
  'Collects and analyzes OT data applying ML, data mining, and AI to discover patterns affecting manufacturing efficiencies. Provides actionable predictive analytics. Requires explicit configuration of datasets and models.'),

-- Adobe
((SELECT id FROM heatmap_findings WHERE vendor_id='adobe-experience' AND feature_name='Customer AI'),
  'tier1', 'vendor_documentation',
  'https://experienceleague.adobe.com/en/docs/experience-platform/intelligent-services/customer-ai/overview',
  'Customer AI overview - Adobe Experience Platform',
  '2026-05-16', 'bg',
  'Generates custom propensity scores (churn, conversion) for individual profiles at scale without ML expertise. Provides influential factors explaining WHY. Must NOT be used for dynamic pricing. Opt-in configuration.'),

((SELECT id FROM heatmap_findings WHERE vendor_id='adobe-experience' AND feature_name LIKE '%Real-Time%'),
  'tier1', 'vendor_documentation',
  'https://experienceleague.adobe.com/en/docs/experience-platform/data-science-workspace/models-recipes/enrich-profile',
  'Enrich Real-Time Customer Profile with ML insights - Adobe',
  '2026-05-16', 'bg',
  'ML insights ingested into Profile-enabled datasets can be segmented. Requires explicit steps: create schema, dataset, run scoring, ingest. Data Science Workspace deprecated for new customers; Customer AI is current path.')

ON CONFLICT DO NOTHING;
