# EU AI Act — Provider vs. Deployer Obligation Reference

**Version:** 1.0  
**Updated:** 2026-05-12  
**Purpose:** Two-page reference. Answer: "Is this my obligation or the vendor's?" Use alongside the Obligation Decoder and heatmap.

> **Disclaimer:** This is an editorial interpretation, not legal advice. The provider/deployer classification in your specific situation depends on your contracts, customization level, and how your DPA interprets the Act. Consult your legal team.

---

## Quick classification

| You are a... | If you... |
|---|---|
| **Deployer** | Purchase and configure vendor AI; do not retrain the model; do not sell the AI to others |
| **Provider** | Train or fine-tune an AI model yourself; place an AI system on the EU market; substantially change an AI system's intended purpose |
| **Both** | Purchase vendor AI AND integrate it into a product you sell to your own customers |

**Most enterprises buying Workday, SAP, Oracle, Greenhouse, or NICE CXone are deployers.** The vendor is the provider.

---

## What deployers must do (Annex III high-risk)

These are YOUR obligations. The vendor cannot discharge them for you.

| Article | Obligation | What it means in practice |
|---|---|---|
| **Art. 9** | Risk management system | Create and maintain a risk register entry for each high-risk AI system you deploy. Document deployment context (which countries, which persons in scope, who reviewed deployment). |
| **Art. 12** | Record-keeping | Ensure logs of AI outputs are retained in your systems. For HR AI: retain AI assessment scores, recommendations, and decisions for at least 6 months — longer if your employment law requires it. |
| **Art. 13(deployer)** | Inform affected persons | Actively inform employees and job applicants that AI is used in decisions about them. This must be specific — name the system and describe what it analyzes. |
| **Art. 14** | Human oversight | Design your HR/business processes so humans can understand, review, and override AI outputs before consequential decisions are made. Document who is responsible for oversight. |
| **Art. 26(5)** | Incident reporting | If the AI system causes a serious incident (harm to persons, significant rights violation), report to your national market surveillance authority. For Denmark: Datatilsynet. Germany: BNetzA. |
| **Art. 26(6)** | Cooperate with authorities | Provide documentation, logs, and access to market surveillance authorities on request. Maintain records sufficient to support this. |

---

## What vendors must do (as provider)

These are obligations the vendor bears. You cannot be held responsible for the vendor's non-compliance — but you can and should ask for evidence that the vendor is meeting them. Non-compliant vendors increase your exposure and are a vendor risk issue.

| Article | Vendor obligation | How to verify |
|---|---|---|
| **Art. 11** | Technical documentation | Ask: "Does your EU AI Act compliance documentation include technical documentation as required by Annex IV?" |
| **Art. 16** | Register with EU AI Office | From August 2026, high-risk AI providers must register in the EU database. Check: ec.europa.eu/growth/ai-act-database (when live) |
| **Art. 17** | Quality management system | Ask: "Do you have a quality management system for AI lifecycle — design, testing, deployment, monitoring?" |
| **Art. 18** | Automatic logging | The system must have technical capability to log operation automatically — not just if the customer enables it |
| **Art. 72** | Post-market monitoring | Ask: "Do you monitor your AI systems in production for accuracy degradation, bias drift, and adverse outcomes?" |

---

## Vendor compliance status (as of 2026-05-12)

| Vendor | EU AI Act statement | ISO 42001 | Bias audit | Deployer Gap rating |
|---|---|---|---|---|
| **Workday** | Confirmed (blog — FY27 Q1, "EU AI Act Stalls, Workday Leads") | Certified | AI Fact Sheets per feature | Partial |
| **SAP SuccessFactors** | EU AI Act FAQ v1.0 (Dec 2025) — Art.5 analysis done, Annex III classification underway | "Based on" not certified | Not found | Partial |
| **Oracle HCM** | AI Terms §4.2 — explicit Art.5 commitment; technical documentation maintained | "Aligned with" not certified | Not found | Partial |
| **Greenhouse** | AI Principles page | **Certified (ISO 42001:2023)** | **Warden AI monthly** | Full |
| **HireVue** | Blog (2026) — discusses compliance, no formal statement | Not confirmed | Not found | Unknown |
| **NICE CXone** | Not found | Not confirmed | Not found | None |
| **Lattice** | AI Use Terms (lattice.com/trust) | Not confirmed | Not found | Unknown |
| **Microsoft Viva** | trust.microsoft.com (extensive) | Not confirmed | Not found | Partial |

**Deployer Gap ratings:**
- **Full**: Vendor provides enough documentation that deployer obligations are straightforward to document
- **Partial**: Some vendor documentation exists; deployer must still build own risk register, oversight process, and employee notices
- **Unknown**: Insufficient vendor documentation found; deployer cannot confirm what the vendor is or is not doing
- **None**: No compliance documentation found; deployer must treat all obligations as starting from zero

---

## Trigger conditions: when a deployer becomes a provider

You become a **provider** — with full provider obligations — if any of these apply:

| Condition | Example | Implication |
|---|---|---|
| **Fine-tune the model on your own data** | Using your historical hire outcomes to re-train HireVue's assessment model | You are now a provider for the fine-tuned model — even if the base model is HireVue's |
| **Build a product using vendor AI and sell it to others** | Building a "talent analytics" product for clients using Workday APIs | You are a provider for the downstream product |
| **Substantially change the AI's intended purpose** | Deploying a customer sentiment tool on employee video calls instead of customer calls | The new purpose (employee monitoring) creates provider obligations for that use case |
| **Develop your own AI using vendor infrastructure** | Training your own neural network on Azure ML for internal use | You are a provider for your own model, regardless of the infrastructure vendor |

---

## Common enterprise scenarios

**Scenario 1: Standard Workday ATS deployment**
- You use Workday's Recruiting Agent in its standard configuration
- You have not customized the underlying model
- **You are: Deployer only**
- Workday is the provider. Your obligations: Art. 9 risk register entry, Art. 12 log retention, Art. 13 applicant notice, Art. 14 human oversight process.

**Scenario 2: SAP SuccessFactors with custom scoring**
- You use SAP SuccessFactors and have configured custom weighting for AI candidate scores using your historical hiring data
- **You are: Deployer for SAP's standard model; potentially Provider for your custom weighting layer**
- Consult your legal team. The custom weighting layer may constitute a material modification that creates provider obligations for the combined output.

**Scenario 3: NICE CXone contact centre analytics**
- You use NICE CXone's real-time voice emotion detection for customer calls
- You have not customized the model
- **You are: Deployer only for customer-facing emotion detection**
- But: if your configuration routes emotion scores to agent coaching workflows — AI scores influencing employment decisions — you are using NICE as both a §1(c) and §4(b) system in the same deployment. Both sets of obligations apply.

**Scenario 4: Microsoft M365 Copilot and Viva Insights**
- You use Microsoft 365 Copilot in your standard M365 subscription
- You have not customized the models
- Viva Insights is available on a separate $4/user/month license (not bundled M365 E3/E5)
- **You are: Deployer only**
- Microsoft is the provider. Important: if Viva Insights Productivity Score is enabled in your tenant, and EU-based employees are in scope, §4(b) obligations apply even if the license is just one module in a larger Microsoft subscription.

---

## What to ask your vendor (checklist)

Send this to your vendor account team or vendor legal/compliance contact. Their answers determine whether your Deployer Gap is Full, Partial, Unknown, or None.

**For all Annex III vendors:**
1. "Does your company have a published EU AI Act compliance statement for [product name]? If yes, please share the URL."
2. "Is [product name] classified as Annex III high-risk under your internal assessment? If formal classification is pending, when do you expect to complete it?"
3. "Do you maintain technical documentation as required by EU AI Act Annex IV? Can we receive a copy under our enterprise agreement?"
4. "Are you registered or planning to register in the EU AI Act database as a high-risk AI provider?"

**For bias and accuracy (Article 10 and 15):**
5. "What training data was used for [specific feature]? Has it been tested for demographic bias and adverse impact?"
6. "What third-party audits, if any, have been conducted on [specific feature]?"
7. "How do you monitor the model's accuracy and fairness in production? What is your process if performance degrades?"

**For data processing (Article 10, GDPR):**
8. "Is any data from our tenant used to train, improve, or fine-tune the AI model? If yes, under what terms?"
9. "Where is our data processed — EU or non-EU?"
10. "What is your data retention policy for AI-generated assessments and scores?"

---

## Questions that have no good answer = Assessment triggers

If you send this checklist to your vendor and receive vague, non-specific, or unanswered responses, you cannot confirm that your deployer obligations are covered by the vendor's provider documentation. This is precisely the gap a BRAGI Assessment identifies and maps.

For a structured review of how your vendor stack maps to your specific deployer obligations, [contact Bragi & Co.](https://bragi.co).
