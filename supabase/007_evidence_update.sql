-- ============================================================
-- Migration 007: Evidence verification update (2026-05-16)
-- Based on parallel agent research across all 16 vendors.
-- ============================================================

-- ══════════════════════════════════════════════════════════════
-- SECTION 1: UNPUBLISH findings that cannot be verified
-- ══════════════════════════════════════════════════════════════

-- NICE Facial Expression Analysis — no documentation found anywhere
UPDATE heatmap_findings
SET published = false,
    notes = 'UNPUBLISHED 2026-05-16: No tier1 documentation found. NICE offers video as a contact channel but no facial expression recognition product. Feature may have been inferred from a press release or demo, not a shipped product.'
WHERE vendor_id = 'nice-cxone' AND feature_name = 'Facial Expression Analysis';

-- NICE Agent Emotion Monitoring — not a distinct feature
UPDATE heatmap_findings
SET published = false,
    notes = 'UNPUBLISHED 2026-05-16: Not a distinct employee-side emotion monitoring feature. NICE Interaction Analytics applies sentiment to both agent and customer turns in conversation, but there is no separate workplace/HR-oriented agent emotional wellbeing monitoring system.'
WHERE vendor_id = 'nice-cxone' AND feature_name = 'Agent Emotion Monitoring';

-- ══════════════════════════════════════════════════════════════
-- SECTION 2: CORRECT default_state and risk_level
-- ══════════════════════════════════════════════════════════════

-- Workday Recruiting Agent: not "on by default" — it's a licensed add-on (HiredScore)
UPDATE heatmap_findings
SET risk_level = 'yellow',
    default_state = 'Licensed add-on',
    default_state_note = '(HiredScore AI, requires separate purchase)',
    notes = 'Corrected 2026-05-16: HiredScore AI for Recruiting is a separately licensed product, not on by default. Requires purchase, integration, and configuration.'
WHERE vendor_id = 'workday' AND feature_name = 'Recruiting Agent';

-- SAP Joule: not "on by default" even for Joule tenants
UPDATE heatmap_findings
SET default_state = 'Opt-in',
    default_state_note = '(requires multi-step activation: AI Units license + BTP provisioning + AI Services Administration enablement + permissions)',
    notes = 'Corrected 2026-05-16: Even on Joule-enabled tenants, the Performance & Goals Agent must be explicitly enabled in AI Services Administration.'
WHERE vendor_id = 'sap-successfactors' AND feature_name = 'Joule';

-- Oracle Dynamic Skills Graph: not "on by default"
UPDATE heatmap_findings
SET default_state = 'Opt-in',
    default_state_note = '(requires AI Apps activation + profile options + ingestion pipeline)',
    notes = 'Corrected 2026-05-16: Requires ORA_HRT_AI_SKILLS_ASSISTANT profile option set to Yes, Oracle AI Apps activation, and data ingestion pipeline setup.'
WHERE vendor_id = 'oracle-hcm' AND feature_name = 'Dynamic Skills Graph';

-- MS Viva Manager Effectiveness: not on by default for E3/E5
UPDATE heatmap_findings
SET default_state = 'Opt-in',
    default_state_note = '(requires premium Viva Insights license + Analyst role + Power BI setup)',
    notes = 'Corrected 2026-05-16: This is an analyst-driven Power BI report template, not a passively surfaced dashboard. Requires premium Viva Insights subscription beyond base E3/E5.'
WHERE vendor_id = 'microsoft-viva' AND feature_name LIKE '%Manager Effectiveness%';

-- MS Viva Performance Insights: partially correct
UPDATE heatmap_findings
SET default_state_note = '(premium Viva Insights subscription required; auto-enabled for managers with direct reports once licensed)',
    notes = 'Corrected 2026-05-16: Team insights require premium Viva Insights subscription. Auto-enabled for licensed managers with direct reports, but managers can opt out.'
WHERE vendor_id = 'microsoft-viva' AND feature_name LIKE '%Performance Insights%';

-- Zendesk Tone Shift: reclassify — it's a writing tool, not emotion detection
UPDATE heatmap_findings
SET annex_iii_ref = '§4(b)',
    annex_iii_category = 'Employment management',
    deployer_obligation_gap = 'Low risk: agent writing assistant, not emotion classification. Confirm tool usage not tracked for performance scoring.',
    notes = 'Corrected 2026-05-16: "Enhance Writing" is an agent-facing generative AI writing tool (adjust tone to friendly/formal). It does NOT detect customer emotion. The sentiment classification lives in Intelligent Triage (separate finding). §1(c) biometric scope does NOT apply.'
WHERE vendor_id = 'zendesk' AND feature_name LIKE '%Tone Shift%';

-- Salesforce Einstein Case Classification: correct default state
UPDATE heatmap_findings
SET default_state = 'Opt-in',
    default_state_note = '(requires enablement in Setup, admin selects training data and fields to predict)',
    notes = 'Verified 2026-05-16: Requires explicit enablement. Admin chooses which closed cases Einstein learns from. At highest confidence auto-fills; at lower confidence shows 3 suggestions.'
WHERE vendor_id = 'salesforce-service' AND feature_name = 'Einstein Case Classification';

-- Salesforce Conversation Mining: correct default state and category
UPDATE heatmap_findings
SET risk_level = 'yellow',
    default_state = 'Opt-in',
    default_state_note = '(requires enablement, Part of Service Intelligence SKU)',
    annex_iii_category = 'Employment management',
    notes = 'Corrected 2026-05-16: Opt-in feature (Part of Service Intelligence SKU). Extracts intent/topic patterns from transcripts. NOT emotion/biometric classification. Downgraded from red to yellow.'
WHERE vendor_id = 'salesforce-service' AND feature_name = 'Einstein Conversation Mining';

-- Salesforce Einstein Sentiment: correct default state
UPDATE heatmap_findings
SET default_state = 'Opt-in',
    default_state_note = '(requires Service Cloud Voice + Amazon Connect setup)',
    notes = 'Corrected 2026-05-16: Requires Service Cloud Voice enablement and configuration. Voice sentiment uses acoustic characteristics (pitch, speed, steadiness) via Amazon Connect Contact Lens.'
WHERE vendor_id = 'salesforce-service' AND feature_name = 'Einstein Sentiment Analysis';

-- Freshworks Sentiment: correct default state
UPDATE heatmap_findings
SET default_state = 'Opt-in',
    default_state_note = '(Admin > Freddy > Sentiment Analysis > Toggle on)',
    confidence = 'verified',
    verification_method = 'vendor_documentation'
WHERE vendor_id = 'freshworks' AND feature_name LIKE '%Sentiment%';

-- Freshworks Auto Triage: partially on by default for Enterprise
UPDATE heatmap_findings
SET default_state = 'On by default',
    default_state_note = '(Enterprise plan: enabled by default for Priority field; auto-apply suggestions is opt-in)',
    confidence = 'verified',
    verification_method = 'vendor_documentation'
WHERE vendor_id = 'freshworks' AND feature_name LIKE '%Auto Triage%';

-- Freshworks Canned Response: upgrade from unverified
UPDATE heatmap_findings
SET confidence = 'verified',
    verification_method = 'vendor_documentation',
    default_state = 'Opt-in',
    default_state_note = '(Admin > Freddy > AI Copilot > Canned response suggester)',
    risk_level = 'yellow',
    notes = 'Verified 2026-05-16: Agent-facing suggestion system. Recommends pre-written templates. Agent retains full control (Insert or Replace). Very low EU AI Act risk.'
WHERE vendor_id = 'freshworks' AND feature_name LIKE '%Canned Response%';

-- Genesys Predictive Engagement: upgrade confidence
UPDATE heatmap_findings
SET confidence = 'verified',
    verification_method = 'vendor_documentation',
    default_state = 'Licensed add-on',
    default_state_note = '(requires configuration of tracking, segments, outcomes, and action maps)',
    notes = 'Verified 2026-05-16: Full tier1 documentation confirmed with implementation guides, SDKs, analytics. Licensed feature with event-driven pricing.'
WHERE vendor_id = 'genesys' AND feature_name = 'Predictive Engagement';

-- Genesys Workforce Forecasting: upgrade confidence
UPDATE heatmap_findings
SET confidence = 'verified',
    verification_method = 'vendor_documentation',
    default_state = 'Licensed add-on',
    default_state_note = '(WFM module; Automatic Best Method is default when creating forecasts)',
    notes = 'Verified 2026-05-16: AI-powered Automatic Best Method Selection uses advanced time-series forecasting, outlier detection, and data repair. Forecasts span up to 130 weeks.'
WHERE vendor_id = 'genesys' AND feature_name = 'Workforce Forecasting AI';

-- Genesys note: add EU AI Act self-assessment context
UPDATE heatmap_findings
SET notes = 'Verified 2026-05-16: Genesys states in EU AI Act FAQ that sentiment analysis is "language-based" and "does not rely on biometric data." Our §1(c) classification represents independent analysis — language-based emotion inference may still qualify as emotion recognition under Art. 3(39).'
WHERE vendor_id = 'genesys' AND feature_name LIKE '%Emotion Detection%';

UPDATE heatmap_findings
SET notes = 'Verified 2026-05-16: Genesys states agent empathy scoring is "language-based, not biometric." Evaluates language for empathy/emotional intelligence. Admin must explicitly enable. Our dual-scope classification (§1(c) + §4(b)) represents independent analysis of Art. 3(39) definition.'
WHERE vendor_id = 'genesys' AND feature_name = 'Agent Empathy Scoring';

-- ══════════════════════════════════════════════════════════════
-- SECTION 3: UPGRADE confidence for all newly verified findings
-- ══════════════════════════════════════════════════════════════

-- SAP Ariba Guided Buying
UPDATE heatmap_findings SET confidence = 'verified', verification_method = 'vendor_documentation'
WHERE vendor_id = 'sap-ariba' AND feature_name LIKE '%Guided Buying%';

-- SAP Ariba Invoice Anomaly
UPDATE heatmap_findings SET confidence = 'verified', verification_method = 'vendor_documentation'
WHERE vendor_id = 'sap-ariba' AND feature_name = 'Invoice Anomaly Detection';

-- Coupa Spend Classification
UPDATE heatmap_findings SET confidence = 'verified', verification_method = 'vendor_documentation'
WHERE vendor_id = 'coupa' AND feature_name = 'AI Spend Classification';

-- Coupa Contract Risk
UPDATE heatmap_findings SET confidence = 'verified', verification_method = 'vendor_documentation'
WHERE vendor_id = 'coupa' AND feature_name LIKE '%Contract Risk%';

-- Oracle Smart Approvals
UPDATE heatmap_findings SET confidence = 'verified', verification_method = 'vendor_documentation'
WHERE vendor_id = 'oracle-procurement' AND feature_name = 'Smart Approvals';

-- Ivalua Sourcing Recommendations
UPDATE heatmap_findings SET confidence = 'verified', verification_method = 'vendor_documentation'
WHERE vendor_id = 'ivalua' AND feature_name LIKE '%Sourcing Recommendations%';

-- Zendesk Tone Shift
UPDATE heatmap_findings SET confidence = 'verified', verification_method = 'vendor_documentation'
WHERE vendor_id = 'zendesk' AND feature_name LIKE '%Tone Shift%';

-- Salesforce Case Classification
UPDATE heatmap_findings SET confidence = 'verified', verification_method = 'vendor_documentation'
WHERE vendor_id = 'salesforce-service' AND feature_name = 'Einstein Case Classification';

-- Salesforce Conversation Mining
UPDATE heatmap_findings SET confidence = 'verified', verification_method = 'vendor_documentation'
WHERE vendor_id = 'salesforce-service' AND feature_name = 'Einstein Conversation Mining';

-- ══════════════════════════════════════════════════════════════
-- SECTION 4: INSERT new verified finding_sources
-- ══════════════════════════════════════════════════════════════

-- Workday Recruiting Agent
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='workday' AND feature_name='Recruiting Agent'),
  'tier1', 'vendor_documentation',
  'https://www.workday.com/en-us/products/talent-management/ai-recruiting.html',
  'HiredScore AI for Recruiting | Workday',
  '2026-05-16', 'bg',
  'Identify the most relevant candidates quickly with unbiased, AI-driven candidate grading. Separately licensed product (HiredScore AI) requiring purchase and implementation.');

-- Workday Talent Mobility
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='workday' AND feature_name='Talent Mobility Agent'),
  'tier1', 'vendor_documentation',
  'https://www.workday.com/en-us/products/talent-management/ai-talent-mobility.html',
  'HiredScore AI for Talent Mobility | Workday',
  '2026-05-16', 'bg',
  'Employees are automatically aligned with open roles based on skills, experience, interests, and company mobility rules. Separately licensed product.');

-- SAP Joule Performance
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='sap-successfactors' AND feature_name='Joule'),
  'tier1', 'vendor_documentation',
  'https://community.sap.com/t5/human-capital-management-blog-posts-by-sap/successfactors-joule-performance-amp-goals-agent-activation/ba-p/14282073',
  'SuccessFactors Joule - Performance&Goals Agent Activation',
  '2026-05-16', 'bg',
  'Joule in SuccessFactors supports its first agent for Performance and Goals. Requires multi-step activation: AI Units license, BTP provisioning, AI Services Administration enablement, permissions.');

-- SAP Candidate Matching
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='sap-successfactors' AND feature_name='Candidate Matching'),
  'tier1', 'vendor_documentation',
  'https://community.sap.com/t5/human-capital-management-blog-posts-by-sap/successfactors-ai-ai-based-skill-topics-in-recruiting-set-up-and-hints/ba-p/13984884',
  'SuccessFactors AI - AI based Skill-Matching in Recruiting',
  '2026-05-16', 'bg',
  'Applicant Screening provides visibility into the applicant skills match. Candidates automatically sorted from best fit to least fit. Requires AI Units license and explicit activation.');

-- SAP Sentiment Analysis
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='sap-successfactors' AND feature_name='Sentiment Analysis'),
  'tier1', 'vendor_documentation',
  'https://community.sap.com/t5/human-capital-management-blog-posts-by-sap/successfactors-ai-assisted-360-review-incl-sentiment-analysis-set-up-and/ba-p/14098754',
  'SuccessFactors AI - Assisted 360 Review incl. Sentiment analysis',
  '2026-05-16', 'bg',
  'AI-driven feature analyzes inputs from Detailed 360 Reports to discern the overall sentiment of raters towards an employee skills or competencies. Requires AI Units license and manual activation.');

-- Oracle Job Applicant Score
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='oracle-hcm' AND feature_name='Job Applicant Score'),
  'tier1', 'vendor_documentation',
  'https://docs.oracle.com/en/cloud/saas/readiness/hcm/25b/recr-25b/25B-recruiting-wn-f37003.htm',
  'Redwood Experience: Job Application AI Rating (Oracle 25B What''s New)',
  '2026-05-16', 'bg',
  'Uses Generative AI to generate matching scores 0-5 by comparing candidate information with job requisition requirements. Profile option ORA_IRC_APPLICANT_AI_SCORES_FEATURE_ENABLED default set to N (disabled).');

-- Oracle Dynamic Skills
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='oracle-hcm' AND feature_name='Dynamic Skills Graph'),
  'tier1', 'vendor_documentation',
  'https://docs.oracle.com/en/cloud/saas/talent-management/faidy/set-up-skills-center-for-dynamic-skills.html',
  'Enable Skills Center for Dynamic Skills (Implementing Dynamic Skills)',
  '2026-05-16', 'bg',
  'Oracle Dynamic Skills uses organizational data to automatically identify, infer, and recommend skills. Requires ORA_HRT_AI_SKILLS_ASSISTANT profile option set to Yes, AI Apps activation, and ingestion pipeline.');

-- MS Viva Manager Effectiveness
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='microsoft-viva' AND feature_name LIKE '%Manager Effectiveness%'),
  'tier1', 'vendor_documentation',
  'https://learn.microsoft.com/en-us/viva/insights/advanced/analyst/templates/manager-effectiveness',
  'Manager effectiveness report - Viva Insights',
  '2026-05-16', 'bg',
  'Analyst-driven Power BI template analyzing people-manager behaviors across five themes. Requires premium Viva Insights license, Analyst role, and Power BI Desktop setup.');

-- MS Viva Work Pattern
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='microsoft-viva' AND feature_name LIKE '%Work Pattern%'),
  'tier1', 'vendor_documentation',
  'https://learn.microsoft.com/en-us/viva/insights/personal/setup/deployment-guide',
  'Personal insights deployment guide - Microsoft Viva',
  '2026-05-16', 'bg',
  'Personal insights turned On by default after licenses assigned. Default scenario: all surfaces of Viva Insights are turned on. Users can individually opt out.');

-- MS Viva Performance Insights
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='microsoft-viva' AND feature_name LIKE '%Performance Insights%'),
  'tier1', 'vendor_documentation',
  'https://learn.microsoft.com/en-us/viva/insights/org-team-insights/team-insights',
  'Team insights - Viva Insights',
  '2026-05-16', 'bg',
  'Team insights available for managers with premium Viva Insights subscription and direct reports. Managers can opt out. Cannot see individual team members personal collaboration habits.');

-- HireVue Video Interviews
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='hirevue' AND feature_name='AI-Scored Video Interviews'),
  'tier1', 'vendor_documentation',
  'https://www.hirevue.com/products/assessments',
  'Assessment Software | HireVue',
  '2026-05-16', 'bg',
  'Uses AI to score structured interviews comparing answers against predefined job-related criteria. Uses NLP analyzing only the content of a response. Facial analysis removed January 2021.');

-- HireVue Game-Based
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='hirevue' AND feature_name='Game-Based Assessments'),
  'tier1', 'vendor_documentation',
  'https://www.hirevue.com/products/game-based-assessments',
  'Game-Based Assessments | HireVue',
  '2026-05-16', 'bg',
  'AI-driven game-based assessments measuring Personality & Work Style, Working with People, and Working with Information. Games are adaptive with randomized tasks.');

-- Greenhouse
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='greenhouse' AND feature_name='Talent Rediscovery'),
  'tier1', 'vendor_documentation',
  'https://www.greenhouse.io/ai-recruiting',
  'AI Recruiting | Greenhouse',
  '2026-05-16', 'bg',
  'Talent rediscovery and filtering tools that surface qualified talent. Customers can enable or disable any AI feature at org level via Configure > AI Tools. ISO 42001:2023 certified.'),
((SELECT id FROM heatmap_findings WHERE vendor_id='greenhouse' AND feature_name='Resume Review'),
  'tier1', 'vendor_documentation',
  'https://www.greenhouse.io/ai-recruiting',
  'AI Recruiting | Greenhouse',
  '2026-05-16', 'bg',
  'Greenhouse-patented parsing technology helps review resumes with identifying details redacted. Org-level opt-in via Configure > AI Tools. Monthly third-party bias audits by Warden AI.');

-- Lattice
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='lattice' AND feature_name='AI Performance Review Summaries'),
  'tier1', 'vendor_documentation',
  'https://lattice.com/ai',
  'Lattice AI | AI for HR',
  '2026-05-16', 'bg',
  'Performance Insights: managers get personalized suggestions based on goals, feedback, growth areas from the review period. Reduces recency bias. Powered by OpenAI. Does not make performance decisions autonomously.'),
((SELECT id FROM heatmap_findings WHERE vendor_id='lattice' AND feature_name='Team Health AI Signals'),
  'tier1', 'vendor_documentation',
  'https://lattice.com/ai',
  'Lattice AI | AI for HR',
  '2026-05-16', 'bg',
  'Team Health: view engagement and satisfaction trends based on survey data, one-on-ones, and Updates. Real-time insights and recommendations to improve participation and reduce attrition. Includes burnout risk flagging.');

-- Salesforce
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='salesforce-service' AND feature_name='Einstein Sentiment Analysis'),
  'tier1', 'vendor_documentation',
  'https://help.salesforce.com/s/articleView?id=service.voice_conversation_sentiments.htm&language=en_US&type=5',
  'Auto-Generated Sentiments of Call Conversations',
  '2026-05-16', 'bg',
  'Sentiment scores from +5 to -5. Analyzes each conversation turn. Service Cloud Voice uses Amazon Connect Contact Lens to analyze spoken words and speaking patterns (pitch, speed, voice steadiness).'),
((SELECT id FROM heatmap_findings WHERE vendor_id='salesforce-service' AND feature_name='Einstein Case Classification'),
  'tier1', 'vendor_documentation',
  'https://help.salesforce.com/s/articleView?id=service.cc_service_what_is.htm&language=en_US&type=5',
  'Autofill Case Fields with Einstein Case Classification Apps',
  '2026-05-16', 'bg',
  'Einstein Case Classification predicts and auto-fills case fields like category, issue type, or priority based on patterns from historical data. After classification, can run case assignment rules for routing.'),
((SELECT id FROM heatmap_findings WHERE vendor_id='salesforce-service' AND feature_name='Einstein Conversation Mining'),
  'tier1', 'vendor_documentation',
  'https://help.salesforce.com/s/articleView?id=sf.conversation_mining_intro.htm&language=en_US&type=5',
  'Tracking Contact Reasons with Einstein Conversation Mining',
  '2026-05-16', 'bg',
  'Automatically scans large volumes of text from customer service conversations to find common topics and group them as contact reasons. Uses NLP to read thousands of conversations. Part of Service Intelligence SKU.');

-- Zendesk
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='zendesk' AND feature_name='Intelligent Triage'),
  'tier1', 'vendor_documentation',
  'https://support.zendesk.com/hc/en-us/articles/4550640560538-Automatically-detecting-customer-intent-sentiment-and-language',
  'Automatically detecting customer intent, sentiment, and language',
  '2026-05-16', 'bg',
  'Intelligent triage uses AI to automatically analyze tickets classifying intent, sentiment, and language. Sentiment signals how positive or negative the customer feels. Values: Very Positive to Very Negative.'),
((SELECT id FROM heatmap_findings WHERE vendor_id='zendesk' AND feature_name LIKE '%Tone Shift%'),
  'tier1', 'vendor_documentation',
  'https://support.zendesk.com/hc/en-us/articles/6948495103002-Turning-on-the-enhance-writing-generative-AI-feature',
  'Turning the enhance writing generative AI feature off or on',
  '2026-05-16', 'bg',
  'Make more friendly / Make more formal: Changes tone of agent comment. On by default for all groups once Copilot add-on active. Agent-facing writing tool, NOT emotion detection.');

-- Freshworks
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='freshworks' AND feature_name LIKE '%Sentiment%'),
  'tier1', 'vendor_documentation',
  'https://support.freshdesk.com/support/solutions/articles/50000009489-introduction-to-sentiment-analysis-prioritize-tickets-based-on-customer-sentiments',
  'Introduction to Sentiment Analysis: Prioritize tickets based on customer sentiments',
  '2026-05-16', 'bg',
  'AI-powered prediction to understand customer expectations by predicting real-time ticket sentiment. Scores 0-100. Must be manually enabled: Admin > Freddy > Sentiment Analysis > Toggle on.'),
((SELECT id FROM heatmap_findings WHERE vendor_id='freshworks' AND feature_name LIKE '%Auto Triage%'),
  'tier1', 'vendor_documentation',
  'https://support.freshdesk.com/support/solutions/articles/50000002117-setting-up-auto-triage',
  'Setting up Auto Triage',
  '2026-05-16', 'bg',
  'Auto Triage powered by Freddy AI auto-classifies incoming tickets. Enterprise plan: enabled by default for Priority field. Continuously learns from existing ticket data.'),
((SELECT id FROM heatmap_findings WHERE vendor_id='freshworks' AND feature_name LIKE '%Canned Response%'),
  'tier1', 'vendor_documentation',
  'https://support.freshdesk.com/support/solutions/articles/50000002341-use-canned-response-suggestions-to-respond-to-tickets-faster',
  'Configure and use Freddy AI canned response suggestions',
  '2026-05-16', 'bg',
  'Freddy AI recommends existing canned responses based on similar past tickets, frequency of use, and resolution status. Agents review and apply recommendations. Opt-in: Admin > Freddy > AI Copilot > Canned response suggester.');

-- NICE CXone
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='nice-cxone' AND feature_name='Real-Time Voice Emotion Detection'),
  'tier1', 'vendor_documentation',
  'https://www.nice.com/products/cx-analytics/interaction-analytics',
  'AI Interaction Analytics | NICE',
  '2026-05-16', 'bg',
  'Sentiment evaluates how positive or negative an interaction was, for both the agent and the customer. Uses speech analytics, NLP, ML, and transcription. Frustration metric detects language signaling frustration.'),
((SELECT id FROM heatmap_findings WHERE vendor_id='nice-cxone' AND feature_name='Agent Soft-Skill Behaviour Analysis'),
  'tier1', 'vendor_documentation',
  'https://www.nice.com/products/cx-analytics/interaction-analytics',
  'AI Interaction Analytics | NICE',
  '2026-05-16', 'bg',
  'CSAT model analyzes agent soft skill behaviors proven to influence positive sentiment: empathy, acknowledging loyalty, demonstrating ownership, asking effective questions. Aggregated by agent, team, location.');

-- Genesys
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='genesys' AND feature_name LIKE '%Emotion Detection%'),
  'tier1', 'vendor_documentation',
  'https://help.mypurecloud.com/articles/understand-sentiment-analysis/',
  'Understand sentiment analysis - Genesys Cloud',
  '2026-05-16', 'bg',
  'Sentiment analysis classifies each customer phrase as positive, negative, or neutral based on language used. Works out-of-the-box once licensed. Genesys states: does not rely on biometric data.'),
((SELECT id FROM heatmap_findings WHERE vendor_id='genesys' AND feature_name='Agent Empathy Scoring'),
  'tier1', 'vendor_documentation',
  'https://help.mypurecloud.com/articles/understand-agent-empathy-analysis/',
  'Understand agent empathy analysis - Genesys Cloud',
  '2026-05-16', 'bg',
  'Gauges agent empathy and emotional intelligence by evaluating language used. Score -100 to +100. Must be explicitly enabled in Admin > Quality > Speech and Text Analytics. Genesys states: language-based, not biometric.'),
((SELECT id FROM heatmap_findings WHERE vendor_id='genesys' AND feature_name='Predictive Engagement'),
  'tier1', 'vendor_documentation',
  'https://help.mypurecloud.com/articles/about-predictive-engagement/',
  'About Predictive Engagement - Genesys Cloud',
  '2026-05-16', 'bg',
  'AI-powered customer engagement analyzing visitor behaviors on websites, predicting outcomes, and personalizing engagements. Licensed feature with event-driven pricing requiring configuration.'),
((SELECT id FROM heatmap_findings WHERE vendor_id='genesys' AND feature_name='Workforce Forecasting AI'),
  'tier1', 'vendor_documentation',
  'https://help.mypurecloud.com/articles/about-workforce-management/',
  'About workforce management - Genesys Cloud',
  '2026-05-16', 'bg',
  'AI-powered forecasting with Automatic Best Method Selection using advanced time-series techniques, outlier detection, and data repair. Forecasts span up to 130 weeks.');

-- SAP Ariba
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='sap-ariba' AND feature_name='Supplier Risk Score'),
  'tier1', 'vendor_documentation',
  'https://help.sap.com/docs/strategic-sourcing/setting-up-sap-ariba-supplier-risk/understanding-how-risk-exposure-is-calculated-b73f5772201f453199e9357e1a4373fb',
  'Risk Exposure Calculation Models - SAP Ariba',
  '2026-05-16', 'bg',
  'Quantifies overall risk exposure on scale 1-100. Raw risk exposure calculated by multiplying scores for contributing factors per domain. Uses external data providers (Moody''s) against configurable thresholds.'),
((SELECT id FROM heatmap_findings WHERE vendor_id='sap-ariba' AND feature_name LIKE '%Guided Buying%'),
  'tier1', 'vendor_documentation',
  'https://www.sap.com/products/spend-management/procure-to-pay/features/guided-buying.html',
  'SAP Ariba Solutions | Guided Buying',
  '2026-05-16', 'bg',
  'Guided buying uses AI to deliver item recommendations that are tailored, cost effective, and compliant. Guides employees to buy from preferred suppliers. Available at no additional cost with SAP Ariba Procurement.'),
((SELECT id FROM heatmap_findings WHERE vendor_id='sap-ariba' AND feature_name='Invoice Anomaly Detection'),
  'tier1', 'vendor_documentation',
  'https://community.sap.com/t5/spend-management-blog-posts-by-sap/introducing-ai-assisted-multi-model-data-extraction-in-sap-ariba-invoicing/ba-p/14318270',
  'AI-Assisted Multi-Model Data Extraction in SAP Ariba Invoicing',
  '2026-05-16', 'bg',
  'Three LLMs (Anthropic Claude, Google Gemini, SAP OpenAI GPT) for extraction with confidence indicators. Routes low-confidence invoices to human reviewers, auto-processes high-confidence. Opt-in pilot approach.');

-- Coupa
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='coupa' AND feature_name LIKE '%Risk Aware%'),
  'tier1', 'vendor_documentation',
  'https://www.coupa.com/products/source-to-contract/supplier-risk-performance/',
  'Supplier Risk & Performance Management | Coupa',
  '2026-05-16', 'bg',
  'Uses AI to flag issues by continuously monitoring outside data sources and community feedback. Prescriptive recommendations include putting high-risk suppliers on hold. Community intelligence from $10T+ transactional data.'),
((SELECT id FROM heatmap_findings WHERE vendor_id='coupa' AND feature_name='AI Spend Classification'),
  'tier1', 'vendor_documentation',
  'https://www.coupa.com/products/spend-analysis/ai-spend-classification',
  'AI Spend Classification | Coupa',
  '2026-05-16', 'bg',
  'AI and ML to standardize, classify, and enrich spend data. Leverages $10 trillion in anonymized community data. Eliminates need for manual classification.'),
((SELECT id FROM heatmap_findings WHERE vendor_id='coupa' AND feature_name LIKE '%Contract Risk%'),
  'tier1', 'vendor_documentation',
  'https://www.coupa.com/newsroom/coupa-rolls-out-ai-driven-features-to-simplify-business-operations/',
  'Coupa Rolls Out AI-Driven Features (Aug 2024)',
  '2026-05-16', 'bg',
  'Contract Intelligence provides risk-informed clause recommendations and GenAI-generated legal agreement summaries. Automatically routes high-risk terms for review.');

-- Oracle Procurement
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='oracle-procurement' AND feature_name='Supplier Qualification Intelligence'),
  'tier1', 'vendor_documentation',
  'https://docs.oracle.com/en/cloud/saas/readiness/scm/24d/proc24d/24D-procurement-wn-f33867.htm',
  'Create Qualification Questions with Generative AI (Oracle 24D)',
  '2026-05-16', 'bg',
  'AI generates question text, suggests attributes, scoring model, recommended acceptable responses and scores. Combined with DataFox risk indicators. Opt-in via privilege and Opt In UI.'),
((SELECT id FROM heatmap_findings WHERE vendor_id='oracle-procurement' AND feature_name='Smart Approvals'),
  'tier1', 'vendor_documentation',
  'https://docs.oracle.com/en/cloud/saas/readiness/scm/26b/proc26b/26B-procurement-wn-f42880.htm',
  'Oracle Fusion Cloud Procurement 26B What''s New',
  '2026-05-16', 'bg',
  'Autonomous Sourcing Assistant automatically creates negotiations, submits for approval, publishes, and invites relevant suppliers based on historical data. Approval rules configurable by administrator.');

-- Ivalua
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='ivalua' AND feature_name='Supplier 360 Risk Analytics'),
  'tier1', 'vendor_documentation',
  'https://www.ivalua.com/solutions/business/supplier-risk-management/',
  'Supplier Risk Management Solutions | Ivalua',
  '2026-05-16', 'bg',
  'Multi-dimensional risk analytics with 360-degree supplier view. Automatic updates of supply chain risk data. Business rules ensure teams contract and award business to low-risk suppliers.'),
((SELECT id FROM heatmap_findings WHERE vendor_id='ivalua' AND feature_name LIKE '%Sourcing Recommendations%'),
  'tier1', 'vendor_documentation',
  'https://www.ivalua.com/blog/ai-in-sourcing-and-procurement/',
  'The Role of AI in Sourcing and Procurement [2026] | Ivalua',
  '2026-05-16', 'bg',
  'AI auto-scores responses, flags noncompliant vendors, and recommends shortlists based on past outcomes. Smart Supplier Selection Model (S3M) uses ML to uncover trade-offs between cost, risk, sustainability.');
