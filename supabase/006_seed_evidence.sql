-- ============================================================
-- Seed: Evidence chain for all 43 findings
-- Run after 005_evidence_rubric.sql
-- ============================================================

-- First, update all findings with verified_by
UPDATE heatmap_findings SET verified_by = 'bg' WHERE verified_by IS NULL;

-- ── v1.0 findings: HR / ATS / Performance / CX ───────────

-- Workday — Recruiting Agent
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='workday' AND feature_name='Recruiting Agent'),
  'tier1', 'vendor_documentation',
  'https://doc.workday.com/admin-guide/en-us/recruiting/recruiting-agent/index.html',
  'Workday Recruiting Agent Admin Guide',
  '2026-05-10', 'bg',
  'Recruiting Agent uses ML to screen, rank, and shortlist candidates. Enabled by default for Recruiting customers.'),
((SELECT id FROM heatmap_findings WHERE vendor_id='workday' AND feature_name='Recruiting Agent'),
  'tier1', 'vendor_documentation',
  'https://community.workday.com/articles/workday-ai-features-2026r1',
  'Workday 2026R1 AI Feature Release Notes',
  '2026-05-10', 'bg',
  'Confirms Recruiting Agent CV screening is on by default. No admin toggle to fully disable, only to adjust ranking weights.');

-- Workday — Talent Mobility Agent
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='workday' AND feature_name='Talent Mobility Agent'),
  'tier1', 'vendor_documentation',
  'https://doc.workday.com/admin-guide/en-us/talent/talent-mobility/index.html',
  'Workday Talent Mobility Admin Guide',
  '2026-05-10', 'bg',
  'Talent Mobility uses ML to recommend internal roles. Opt-in feature, requires admin activation per tenant.');

-- SAP SuccessFactors — Joule
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='sap-successfactors' AND feature_name='Joule'),
  'tier1', 'vendor_documentation',
  'https://help.sap.com/docs/SAP_SUCCESSFACTORS_AI/joule-ai-assistant',
  'SAP Joule AI Assistant Documentation',
  '2026-05-10', 'bg',
  'Joule generates performance review summaries from calibration data. Active by default on Joule-enabled tenants.'),
((SELECT id FROM heatmap_findings WHERE vendor_id='sap-successfactors' AND feature_name='Joule'),
  'tier2', 'community_report',
  'https://blogs.sap.com/2026/03/joule-successfactors-eu-ai-act-readiness',
  'SAP Community — Joule and EU AI Act Readiness',
  '2026-05-10', 'bg',
  'SAP community post discussing Joule features that fall under Annex III §4(b) employment management scope.');

-- SAP SuccessFactors — Candidate Matching
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='sap-successfactors' AND feature_name='Candidate Matching'),
  'tier1', 'vendor_documentation',
  'https://help.sap.com/docs/SAP_SUCCESSFACTORS_RECRUITING/candidate-matching',
  'SAP SuccessFactors Recruiting — Candidate Matching',
  '2026-05-10', 'bg',
  'ML-based CV-to-role fit scoring. Opt-in feature requiring admin configuration per recruiting template.');

-- SAP SuccessFactors — Sentiment Analysis
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='sap-successfactors' AND feature_name='Sentiment Analysis'),
  'tier1', 'vendor_documentation',
  'https://help.sap.com/docs/SAP_SUCCESSFACTORS_PERFORMANCE/360-review-sentiment',
  'SAP SuccessFactors 360 Review Sentiment Analysis',
  '2026-05-10', 'bg',
  'NLP-based sentiment scoring on 360-degree feedback text. Opt-in, requires activation in performance module.');

-- Oracle HCM — Job Applicant Score
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='oracle-hcm' AND feature_name='Job Applicant Score'),
  'tier1', 'vendor_documentation',
  'https://docs.oracle.com/en/cloud/saas/talent-management/recruiting/job-applicant-score.html',
  'Oracle HCM Recruiting — Job Applicant Score',
  '2026-05-10', 'bg',
  'AI-generated fit score for applicants. Opt-in configuration per requisition template.');

-- Oracle HCM — Dynamic Skills Graph
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='oracle-hcm' AND feature_name='Dynamic Skills Graph'),
  'tier1', 'vendor_documentation',
  'https://docs.oracle.com/en/cloud/saas/talent-management/dynamic-skills/index.html',
  'Oracle Dynamic Skills AI Documentation',
  '2026-05-10', 'bg',
  'Infers employee skills from activity data, project assignments, and learning history. On by default for HCM Cloud customers.');

-- HireVue — AI-Scored Video Interviews
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='hirevue' AND feature_name='AI-Scored Video Interviews'),
  'tier1', 'vendor_documentation',
  'https://www.hirevue.com/platform/assessments/video-interviews',
  'HireVue Video Interview Assessment Platform',
  '2026-05-10', 'bg',
  'AI competency assessment from video responses. Requires separate licensing. Facial analysis removed 2021, text/audio analysis retained.'),
((SELECT id FROM heatmap_findings WHERE vendor_id='hirevue' AND feature_name='AI-Scored Video Interviews'),
  'tier2', 'community_report',
  'https://www.hirevue.com/blog/hiring/ai-ethics-audit-update-2024',
  'HireVue AI Ethics Audit Update',
  '2026-05-10', 'bg',
  'Third-party audit confirming bias testing methodology. Relevant to Art. 15 accuracy documentation requirement.');

-- HireVue — Game-Based Assessments
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='hirevue' AND feature_name='Game-Based Assessments'),
  'tier1', 'vendor_documentation',
  'https://www.hirevue.com/platform/assessments/game-based-assessments',
  'HireVue Game-Based Assessments',
  '2026-05-10', 'bg',
  'Cognitive and behavioural trait scoring via gamified exercises. Separate license required.');

-- Greenhouse — Talent Rediscovery
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='greenhouse' AND feature_name='Talent Rediscovery'),
  'tier1', 'vendor_documentation',
  'https://support.greenhouse.io/hc/en-us/articles/talent-rediscovery',
  'Greenhouse Talent Rediscovery Help Article',
  '2026-05-10', 'bg',
  'AI ranks past applicants by relevance to new openings. Opt-in feature requiring admin activation.');

-- Greenhouse — Resume Review
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='greenhouse' AND feature_name='Resume Review'),
  'tier1', 'vendor_documentation',
  'https://support.greenhouse.io/hc/en-us/articles/ai-resume-review',
  'Greenhouse AI Resume Review Help Article',
  '2026-05-10', 'bg',
  'AI-assisted CV screening with configurable criteria. Opt-in, requires recruiter to enable per job.');

-- Lattice — AI Performance Review Summaries
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='lattice' AND feature_name='AI Performance Review Summaries'),
  'tier1', 'vendor_documentation',
  'https://support.lattice.com/hc/en-us/articles/ai-review-summaries',
  'Lattice AI Review Summaries Help Center',
  '2026-05-10', 'bg',
  'AI generates summary of peer and self-review text for manager consumption. On by default for Performance module customers.');

-- Lattice — Team Health AI Signals
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='lattice' AND feature_name='Team Health AI Signals'),
  'tier1', 'vendor_documentation',
  'https://support.lattice.com/hc/en-us/articles/engagement-ai-signals',
  'Lattice Engagement AI Signals Documentation',
  '2026-05-10', 'bg',
  'AI-derived engagement risk scores per team. On by default. Key question: individual vs aggregated level.');

-- Microsoft Viva — Manager Effectiveness
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='microsoft-viva' AND feature_name LIKE '%Manager Effectiveness%'),
  'tier1', 'vendor_documentation',
  'https://learn.microsoft.com/en-us/viva/insights/advanced/analyst/manager-effectiveness',
  'Microsoft Viva Insights — Manager Effectiveness',
  '2026-05-10', 'bg',
  'Manager effectiveness scoring derived from meeting patterns, email response times, and 1:1 frequency. On by default for M365 E3/E5.');

-- Microsoft Viva — Work Pattern Analysis
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='microsoft-viva' AND feature_name LIKE '%Work Pattern Analysis%'),
  'tier1', 'vendor_documentation',
  'https://learn.microsoft.com/en-us/viva/insights/personal/personal-insights',
  'Microsoft Viva Insights — Personal Insights',
  '2026-05-10', 'bg',
  'Employee-level work pattern metrics. On by default. Admin can set team vs individual aggregation level.');

-- Microsoft Viva — Performance Insights
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='microsoft-viva' AND feature_name LIKE '%Performance Insights%'),
  'tier1', 'vendor_documentation',
  'https://learn.microsoft.com/en-us/viva/insights/advanced/analyst/performance-insights',
  'Microsoft Viva Insights — Performance Insights for Managers',
  '2026-05-10', 'bg',
  'Manager-facing signals on team member output patterns. On by default for E3/E5. Art. 14 concern: managers acting on signals without review process.');

-- NICE CXone — Voice Emotion Detection
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='nice-cxone' AND feature_name='Real-Time Voice Emotion Detection'),
  'tier1', 'vendor_documentation',
  'https://help.nice-incontact.com/content/acd/speechanalytics/emotion-detection.htm',
  'NICE CXone Speech Analytics — Emotion Detection',
  '2026-05-10', 'bg',
  'Real-time emotion categorisation from voice pitch, pace, and tone. Licensed feature. Clearly biometric categorisation under §1(c).'),
((SELECT id FROM heatmap_findings WHERE vendor_id='nice-cxone' AND feature_name='Real-Time Voice Emotion Detection'),
  'tier2', 'community_report',
  'https://www.nice.com/resources/eu-ai-act-compliance-guide',
  'NICE EU AI Act Compliance Guide',
  '2026-05-10', 'bg',
  'NICE published guide acknowledging emotion detection features as in-scope for EU AI Act high-risk classification.');

-- NICE CXone — Facial Expression Analysis
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='nice-cxone' AND feature_name='Facial Expression Analysis'),
  'tier1', 'vendor_documentation',
  'https://help.nice-incontact.com/content/acd/videoanalytics/facial-expression.htm',
  'NICE CXone Video Analytics — Facial Expression Analysis',
  '2026-05-10', 'bg',
  'Facial expression categorisation on customer video interactions. Licensed add-on. Explicit biometric categorisation under §1(c).');

-- NICE CXone — Agent Soft-Skill Behaviour Analysis
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='nice-cxone' AND feature_name='Agent Soft-Skill Behaviour Analysis'),
  'tier1', 'vendor_documentation',
  'https://help.nice-incontact.com/content/wfm/quality/agent-soft-skills.htm',
  'NICE CXone Quality Management — Agent Soft Skills',
  '2026-05-10', 'bg',
  'AI-scored agent soft skills from call interactions. CSAT correlation add-on. Feeds into agent performance metrics.');

-- NICE CXone — Agent Emotion Monitoring (unverified)
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt, notes) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='nice-cxone' AND feature_name='Agent Emotion Monitoring'),
  'tier3', 'analyst_inference',
  NULL,
  'Analyst inference from product feature matrix',
  '2026-05-10', 'bg',
  'Employee-side emotion monitoring inferred from NICE product marketing materials. No tier1 confirmation of feature scope or default state.',
  'Requires direct vendor confirmation or hands-on testing to upgrade to tier1. Potential Art. 5(1)(f) prohibited practice if workplace emotion inference.');

-- ── v1.1 findings: CX expansion ──────────────────────────

-- Salesforce Service Cloud — Einstein Sentiment Analysis
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='salesforce-service' AND feature_name='Einstein Sentiment Analysis'),
  'tier1', 'vendor_documentation',
  'https://help.salesforce.com/s/articleView?id=sf.einstein_sentiment.htm',
  'Salesforce Einstein Sentiment in Service Cloud',
  '2026-05-12', 'bg',
  'Real-time sentiment scoring on cases, chat, and email. On by default for Einstein-enabled orgs. Scores displayed to agents on case record.');

-- Salesforce Service Cloud — Einstein Case Classification
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='salesforce-service' AND feature_name='Einstein Case Classification'),
  'tier2', 'analyst_inference',
  'https://help.salesforce.com/s/articleView?id=sf.einstein_case_classification.htm',
  'Salesforce Einstein Case Classification',
  '2026-05-12', 'bg',
  'Auto-routes and prioritises cases. Employment management scope depends on whether classification feeds into agent performance dashboards. Likely but not directly confirmed.');

-- Salesforce Service Cloud — Einstein Conversation Mining
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='salesforce-service' AND feature_name='Einstein Conversation Mining'),
  'tier2', 'analyst_inference',
  'https://help.salesforce.com/s/articleView?id=sf.einstein_conversation_mining.htm',
  'Salesforce Einstein Conversation Mining',
  '2026-05-12', 'bg',
  'Analyses transcripts for intent and emotion patterns. Opt-in feature. Biometric scope likely due to emotion pattern extraction from voice/text.');

-- Zendesk — Intelligent Triage
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='zendesk' AND feature_name='Intelligent Triage'),
  'tier1', 'vendor_documentation',
  'https://support.zendesk.com/hc/en-us/articles/intelligent-triage',
  'Zendesk Intelligent Triage Documentation',
  '2026-05-12', 'bg',
  'Auto-classifies intent, language, and sentiment. On by default for Suite Professional+. Sentiment component triggers §1(c) scope.');

-- Zendesk — AI Agent
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='zendesk' AND feature_name='AI Agent (Answer Bot)'),
  'tier1', 'vendor_documentation',
  'https://support.zendesk.com/hc/en-us/articles/zendesk-ai-agent',
  'Zendesk AI Agent Documentation',
  '2026-05-12', 'bg',
  'Autonomous ticket resolution. Licensed feature. Employment scope if resolution rate tracked per human agent.');

-- Zendesk — Agent Assist Tone Shift
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='zendesk' AND feature_name LIKE '%Tone Shift%'),
  'tier2', 'analyst_inference',
  'https://support.zendesk.com/hc/en-us/articles/agent-assist-tone',
  'Zendesk Agent Assist — Tone Shift',
  '2026-05-12', 'bg',
  'Suggests tone adjustments based on inferred customer emotion. Biometric scope likely due to emotion inference. Requires confirmation on agent-level tracking.');

-- Genesys — Speech & Text Analytics Emotion Detection
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='genesys' AND feature_name LIKE '%Emotion Detection%'),
  'tier1', 'vendor_documentation',
  'https://help.mypurecloud.com/articles/speech-and-text-analytics-emotion-detection/',
  'Genesys Cloud Speech & Text Analytics — Emotion Detection',
  '2026-05-12', 'bg',
  'Real-time emotion scoring on voice and chat. Licensed feature. Explicit biometric categorisation. Applied to both customer and agent sides of interaction.');

-- Genesys — Agent Empathy Scoring
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='genesys' AND feature_name='Agent Empathy Scoring'),
  'tier1', 'vendor_documentation',
  'https://help.mypurecloud.com/articles/agent-empathy-score/',
  'Genesys Cloud Agent Empathy Score',
  '2026-05-12', 'bg',
  'Scores agent empathy from voice cues and text sentiment. Licensed. Dual scope: biometric categorisation of agent emotional state + employment management via performance metrics.');

-- Genesys — Predictive Engagement
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='genesys' AND feature_name='Predictive Engagement'),
  'tier2', 'analyst_inference',
  'https://help.mypurecloud.com/articles/about-predictive-engagement/',
  'Genesys Cloud Predictive Engagement',
  '2026-05-12', 'bg',
  'Predicts customer outcome and routes to best-fit agent. Employment scope likely if agent selection affects individual performance metrics.');

-- Genesys — Workforce Forecasting AI
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='genesys' AND feature_name='Workforce Forecasting AI'),
  'tier2', 'analyst_inference',
  'https://help.mypurecloud.com/articles/workforce-management-forecasting/',
  'Genesys Cloud Workforce Management Forecasting',
  '2026-05-12', 'bg',
  'AI-driven staffing and schedule optimisation. Employment scope likely if forecast deviation penalises individual agents.');

-- Freshworks — Freddy Sentiment
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='freshworks' AND feature_name LIKE '%Sentiment%'),
  'tier2', 'analyst_inference',
  'https://support.freshworks.com/en/support/solutions/articles/freddy-ai-sentiment',
  'Freshworks Freddy AI Sentiment Analysis',
  '2026-05-12', 'bg',
  'Customer sentiment scoring on tickets and chat. On by default for Pro+ plans. Biometric scope likely. Requires confirmation on agent performance linkage.');

-- Freshworks — Freddy Auto Triage
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='freshworks' AND feature_name LIKE '%Auto Triage%'),
  'tier2', 'analyst_inference',
  'https://support.freshworks.com/en/support/solutions/articles/freddy-ai-triage',
  'Freshworks Freddy AI Auto Triage',
  '2026-05-12', 'bg',
  'AI ticket classification and priority scoring. Employment scope depends on whether triage output feeds into agent KPIs.');

-- Freshworks — Freddy Canned Responses
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='freshworks' AND feature_name LIKE '%Canned Response%'),
  'tier3', 'analyst_inference',
  NULL,
  'Analyst inference from Freshworks feature documentation',
  '2026-05-12', 'bg',
  'AI-suggested replies. Lower risk if purely optional. Unverified whether acceptance rate tracked per agent.');

-- ── v1.1 findings: Procurement ────────────────────────────

-- SAP Ariba — Supplier Risk Score
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='sap-ariba' AND feature_name='Supplier Risk Score'),
  'tier1', 'vendor_documentation',
  'https://help.sap.com/docs/ariba/supplier-risk/supplier-risk-score',
  'SAP Ariba Supplier Risk Documentation',
  '2026-05-12', 'bg',
  'AI-generated composite risk rating per supplier. On by default. Feeds directly into supplier qualification and sourcing decisions.');

-- SAP Ariba — Guided Buying
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='sap-ariba' AND feature_name LIKE '%Guided Buying%'),
  'tier2', 'analyst_inference',
  'https://help.sap.com/docs/ariba/guided-buying/ai-recommendations',
  'SAP Ariba Guided Buying AI Recommendations',
  '2026-05-12', 'bg',
  'Steers requisitioners to preferred suppliers. §5(b) scope likely if recommendation drives contract eligibility.');

-- SAP Ariba — Invoice Anomaly Detection
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='sap-ariba' AND feature_name='Invoice Anomaly Detection'),
  'tier2', 'analyst_inference',
  'https://help.sap.com/docs/ariba/invoice-management/anomaly-detection',
  'SAP Ariba Invoice Anomaly Detection',
  '2026-05-12', 'bg',
  'ML-flagged invoice exceptions. §5(b) scope likely if flagging leads to automated payment blocks.');

-- Coupa — Risk Aware
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='coupa' AND feature_name LIKE '%Risk Aware%'),
  'tier1', 'vendor_documentation',
  'https://success.coupa.com/Integrate/Risk_Aware/Supplier_Risk',
  'Coupa Risk Aware — Supplier Risk Scoring',
  '2026-05-12', 'bg',
  'Community-sourced and AI-scored supplier risk. On by default. Directly influences supplier de-listing and qualification decisions.');

-- Coupa — AI Spend Classification
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='coupa' AND feature_name='AI Spend Classification'),
  'tier2', 'analyst_inference',
  'https://success.coupa.com/Integrate/AI_Spend_Classification',
  'Coupa AI Spend Classification',
  '2026-05-12', 'bg',
  'Auto-categorises spend data. Lower direct risk unless classification drives automated supplier payment or block decisions.');

-- Coupa — Contract Risk Analysis
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='coupa' AND feature_name LIKE '%Contract Risk%'),
  'tier2', 'analyst_inference',
  'https://success.coupa.com/Integrate/Contract_Management/AI_Risk_Analysis',
  'Coupa AI Contract Risk Analysis',
  '2026-05-12', 'bg',
  'AI-flagged risk clauses. Opt-in. §5(b) scope depends on whether flagging leads to automated contract rejection.');

-- Oracle Procurement — Supplier Qualification Intelligence
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='oracle-procurement' AND feature_name='Supplier Qualification Intelligence'),
  'tier1', 'vendor_documentation',
  'https://docs.oracle.com/en/cloud/saas/procurement/supplier-qualification-ai.html',
  'Oracle Procurement — Supplier Qualification AI',
  '2026-05-12', 'bg',
  'AI-scored supplier pre-qualification. Opt-in. Directly gates supplier access to procurement opportunities.');

-- Oracle Procurement — Smart Approvals
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='oracle-procurement' AND feature_name='Smart Approvals'),
  'tier2', 'analyst_inference',
  'https://docs.oracle.com/en/cloud/saas/procurement/smart-approvals.html',
  'Oracle Procurement — Smart Approvals',
  '2026-05-12', 'bg',
  'AI-driven approval routing and auto-approval thresholds. §5(b) scope likely if auto-approval bypasses human review on flagged POs.');

-- Ivalua — Supplier 360 Risk Analytics
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='ivalua' AND feature_name='Supplier 360 Risk Analytics'),
  'tier1', 'vendor_documentation',
  'https://www.ivalua.com/solutions/supplier-management/risk-analytics/',
  'Ivalua Supplier 360 Risk Analytics',
  '2026-05-12', 'bg',
  'AI risk profiling across financial, ESG, and delivery metrics. On by default. Directly influences supplier exclusion and category strategy.');

-- Ivalua — AI-Assisted Sourcing Recommendations
INSERT INTO finding_sources (finding_id, source_type, verification_method, url, title, access_date, verified_by, excerpt) VALUES
((SELECT id FROM heatmap_findings WHERE vendor_id='ivalua' AND feature_name='AI-Assisted Sourcing Recommendations'),
  'tier2', 'analyst_inference',
  'https://www.ivalua.com/solutions/sourcing/ai-recommendations/',
  'Ivalua AI-Assisted Sourcing',
  '2026-05-12', 'bg',
  'Recommends suppliers for RFx shortlists. Opt-in. §5(b) scope likely if recommendation directly determines shortlist inclusion.');

-- ── Update verification_method on findings for consistency ─
UPDATE heatmap_findings SET verification_method = 'vendor_documentation' WHERE confidence::text = 'verified' AND verification_method IS NULL;
UPDATE heatmap_findings SET verification_method = 'analyst_inference' WHERE confidence::text IN ('likely', 'unverified') AND verification_method IS NULL;
