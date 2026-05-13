# EU AI Act — Obligation Decoder

**Version:** 1.0  
**Updated:** 2026-05-12  
**Purpose:** Translate heatmap Red and Yellow findings into specific deployer obligations under Articles 9-15. Use this alongside the heatmap — the heatmap tells you what you have; this tells you what you must do about it.

> **Disclaimer:** This is an editorial interpretation of the EU AI Act obligations, not legal advice. Consult your legal and compliance team for your specific deployment context, business sector, and national regulatory authority guidance.

---

## How to use this document

1. Find a Red or Yellow row in the heatmap
2. Check the Annex III category (§4, §1, §5, etc.)
3. Find the matching section below
4. For each Article, check "You have this if..." against what you currently have in place
5. Items you cannot answer "yes" to are your compliance gaps — and the input to a BRAGI Assessment

---

## §4(a/b) — Employment, recruitment, and workforce management

**Applies to these heatmap rows:**

| Vendor | Feature | Risk |
|---|---|---|
| Workday | Recruiting Agent | Red |
| Workday | Talent Mobility Agent | Yellow |
| SAP SuccessFactors | AI-Generated Performance Review Summaries (Joule) | Yellow |
| SAP SuccessFactors | Sentiment Analysis in 360-Degree Reviews | Yellow |
| SAP SuccessFactors | Candidate Matching / Job-Candidate Fit Score | Yellow |
| Oracle HCM | Job Applicant Score | Yellow |
| Oracle HCM | Team Talent Calibration and Review Workspace | Yellow |
| HireVue | Game-Based Assessments (AI-Scored) | Yellow |
| HireVue | AI-Scored Video Interviews | Yellow |
| Greenhouse | Talent (Re)Discovery — AI Candidate Filtering | Yellow |
| Greenhouse | Resume Review (AI Parsing + Anonymization) | Yellow |
| Greenhouse | Scorecard Summaries (AI-Generated) | Yellow |
| Lattice | Performance Review Summary (AI-Generated) | Yellow |
| Lattice | Team Health (AI Signals) | Yellow |
| Microsoft Viva Insights | Manager Effectiveness (AI Insights) | Yellow |
| Microsoft Viva Insights | Performance Insights (AI-Generated Summaries) | Yellow |
| Microsoft Viva Insights | Manager Insights on Employee Work Patterns | Yellow |

---

### Article 9 — Risk management system

**What this requires:**
- A documented risk management system covering this specific AI system
- Identification of risks to health, safety, and fundamental rights (bias, discriminatory outcomes)
- Measures to mitigate identified risks
- Records maintained for 10 years after the system ceases to be used

**What to ask your vendor:** Does the vendor provide a technical risk assessment for this feature?
- Workday: AI Fact Sheets are available per feature on request — ask your account team
- Oracle: AI Terms §4.1 states Oracle maintains technical documentation as provider
- SAP: EU AI Act FAQ Q5-Q6 confirms SAP is conducting internal Annex III classification
- Greenhouse: bias audit statement published at greenhouse.com/bias-audit-statement
- HireVue, Lattice, NICE: no formal technical documentation found — ask directly

**What you must build (regardless of what the vendor provides):**
- A named entry in your AI register for this system — "Workday Recruiting Agent — §4(a) high-risk, deployed [date]"
- Documentation of your deployment context: which countries, which roles, whether EU persons are in scope
- A record of who reviewed the deployment decision and on what basis

**You have this if:** A written document or system entry exists that names this AI system, states your deployment context, and is dated. A spreadsheet is acceptable — it does not need to be elaborate.

**Gap indicator:** Most organizations deploying enterprise AI have not created an AI register entry for vendor-supplied features. If you cannot name the person responsible for reviewing this system before deployment, you do not have Article 9 in place.

---

### Article 10 — Data governance and management

**What this requires:**
- Ensure training data used is relevant, representative, and free from errors where you have influence
- Document the characteristics of the training data
- Where you use personal data to fine-tune or customize the AI, document this

**What to ask your vendor:**
- "What training data was used for this feature, and has it been bias-tested?"
- "Is any data from our tenant used to train or improve the model?"
- Workday: AI Fact Sheets describe training data approach per feature
- Greenhouse: Warden AI bias audits (monthly) test model outputs for adverse impact — ask for most recent report

**What you must build:**
- If you have customized the AI using your own employee or applicant data: document what data was used, when, and for what purpose
- If using vendor's standard model: document that you verified the vendor has appropriate data governance in place (citing the vendor's own statement)

**You have this if:** You can produce documentation of the training data basis — either your own (if you customized) or the vendor's (if using standard). If you cannot, flag for the next vendor review cycle.

---

### Article 12 — Record-keeping / Logging

**What this requires:**
- Maintain logs of AI system operation sufficient to reconstruct decisions after the fact
- Logs must be retained for at least 6 months (some national implementations may require longer)
- Logs must be accessible to market surveillance authorities on request

**What to ask your vendor:**
- "What logs does the system maintain of AI-generated outputs and decisions?"
- "Are these logs exportable and retained for at least 6 months?"
- Most HR SaaS platforms maintain audit logs — confirm yours does for AI-generated outputs specifically

**What you must build:**
- A process for retaining AI decision logs — particularly for recruiting and performance management decisions affecting EU persons
- A clear owner for log retention (typically IT/compliance)

**You have this if:** You can confirm that logs of AI-generated assessments, scores, and recommendations are being retained and are accessible. A "yes" from your vendor's trust center is not enough — you need to confirm your specific tenant configuration retains these.

---

### Article 13 — Transparency obligations

**This article has two distinct layers:**

**Layer 1 — Instructions for use (vendor → you):**
The vendor must provide you with adequate instructions describing what the AI does, its capabilities, limitations, and how to use it safely. Vendors meeting this obligation: Workday (AI Fact Sheets), Greenhouse (bias audit statement), Oracle (AI Terms documentation). Vendors with gaps: NICE, Lattice, HireVue (limited formal documentation found).

**Layer 2 — Informing affected individuals (you → employees/applicants):**
You must inform employees and job applicants that AI is being used in decisions about them. This is not optional and cannot be buried in a GDPR privacy notice alone.

**What you must build:**
- A disclosure to job applicants: "Our hiring process uses AI-assisted assessment tools [vendor name]. These tools analyze [what they analyze]. A human reviewer [role] makes all final decisions."
- A disclosure to employees for AI-assisted performance management: included in your employment contract, HR handbook, or a standalone AI use notice

**You have this if:** A documented disclosure exists, has been communicated to relevant persons, and is dated. Verbal assurances do not satisfy this requirement.

**Common gap:** Most enterprises have a GDPR privacy notice that mentions automated processing. This is not sufficient for Article 13 — it must specifically describe the AI system in use and the nature of decisions it influences.

---

### Article 14 — Human oversight

**What this requires:**
- Natural persons must be able to understand and oversee the AI system's operation
- Natural persons must be able to intervene or override the AI's output
- The design must prevent over-reliance on AI recommendations ("automation bias")

**What this means in practice:**
- An HR manager who clicks "approve" on a Workday AI-recommended hire without reading the AI's reasoning is not exercising meaningful human oversight
- If the AI score is the only input to a shortlisting decision, and no human reviews why the score was assigned, Article 14 is not met
- "Human in the loop" is not enough — the human must be able to understand, question, and reject the AI output

**What you must build:**
- A documented process that requires human review of AI outputs before any employment decision is made
- Training for HR users on: what the AI does, what its limitations are, how to override it, and when override is appropriate
- Ideally: a mandatory "AI output reviewed" sign-off step in your ATS or performance management workflow

**You have this if:** You can name the role responsible for reviewing AI outputs, describe how they receive and review them, and confirm they have the ability to override the AI recommendation with no penalty for doing so.

**Gap indicator:** If your Workday or SAP configuration auto-advances candidates above a certain AI score without human review of that score, you do not have Article 14 in place.

---

### Article 15 — Accuracy, robustness, and cybersecurity

**What this requires:**
- The AI system achieves appropriate levels of accuracy and robustness
- Periodic testing for accuracy and resilience
- Protection against adversarial manipulation of inputs or outputs

**What to ask your vendor:**
- "What accuracy benchmarks does this AI meet?"
- "How do you test for bias and adverse impact?"
- "How do you monitor model performance over time?"
- Workday: AI Fact Sheets include accuracy and fairness metrics per feature
- Greenhouse: Warden AI monthly bias audits test for adverse impact

**What you must build:**
- A periodic review process: at minimum, once per year, review the vendor's latest accuracy and bias testing results
- Document this review: who reviewed, what they found, any actions taken

**You have this if:** You have a vendor accuracy review on file dated within 12 months. If you cannot produce this, flag it for the next annual review.

---

## §1(c) — Biometric categorisation / Emotion recognition from biometric data

**Applies to these heatmap rows:**

| Vendor | Feature | Risk |
|---|---|---|
| NICE CXone | Real-Time Voice Emotion Detection — Customer Calls | Red |
| NICE CXone | Facial Expression Analysis — Customer Video Interactions | Red |

**Important note:** The NICE CXone rows in the heatmap are scoped to **customer interactions** (not employees). Employee-facing emotion inference would be an Article 5(1)(f) PROHIBITION (see Art. 5 section below), not Annex III high-risk. Do not conflate these.

**Enforcement date for §1(c):** 2026-08-02 — same as §4 employment AI.

---

### Article 9 (§1(c) version)

The risk management system must specifically address:
- Bias in emotion inference across demographic groups (the same tone of voice may be interpreted differently based on accent, gender, language background)
- False positive rates: what happens when emotion detection is incorrect and how that flows into agent coaching or customer record

**What to ask NICE:** What demographic bias testing has been conducted on the emotion detection model? Are results available?

---

### Article 13 (§1(c) version) — Transparency to affected persons

For customer-facing emotion detection: the persons whose emotions are being inferred are customers, not employees. Your obligation is to inform customers that their voice or video interaction is being analyzed by AI for emotional state.

This is typically done via:
- Call recording notice: "This call is recorded and may be analyzed using AI tools to improve service quality"
- Privacy notice update: specifically mention AI emotion analysis alongside standard recording disclosure

**Gap:** Most call recording disclosures do not specifically mention AI emotion inference. "Calls may be recorded" does not disclose that the recording will be analyzed by AI to infer emotional state.

---

### Article 14 (§1(c) version) — Human oversight

- Human agents and supervisors must be able to override emotion detection outputs
- AI-flagged calls (e.g., "customer shows high frustration") should be reviewed by a supervisor before any consequential action (call escalation, customer account action) is taken automatically
- Emotion scores should not automatically trigger customer service outcomes without human review

---

## Article 5(1)(f) — PROHIBITION: Emotion inference in the workplace

**This is NOT Annex III high-risk. This is a PROHIBITED practice.**

Article 5(1)(f) prohibits AI systems that infer or deduce emotions of natural persons in the workplace and in educational institutions, with narrow exceptions for safety and medical purposes.

**What this means:** If NICE CXone or any other vendor is analyzing the emotional state of your **contact centre agents** from their voice or video, this is potentially prohibited under the EU AI Act — not merely high-risk.

**Current heatmap status:** The employee-facing NICE CXone emotion detection row is Tier 3 internal (not published) because no Tier 1 source has confirmed that NICE applies emotion inference to agent-side data. If your vendor confirms this capability is active on your agents, treat it as an Article 5 issue requiring legal review before any other action.

**Who to consult:** Your legal team + your national DPA (for Denmark: Datatilsynet; for Germany: BNetzA). Do not treat this as a routine compliance gap — it is a potential prohibition.

---

## §4(b) — Employment decisions: NICE CXone Agent CSAT Add-On

**Applies to:**

| Vendor | Feature | Risk |
|---|---|---|
| NICE CXone | Agent Soft-Skill Behavior Analysis (CSAT Add-On) | Yellow |

The CSAT add-on produces AI assessments of agent soft skills (empathy, ownership, questioning technique). Where these assessments influence coaching, performance reviews, or disciplinary decisions for EU-based agents, this is §4(b) employment management AI.

Article 9 through Article 14 apply as described in the §4(a/b) section above, with one additional emphasis:

**Article 14 (§4(b) agent CSAT):** The AI should not be the sole basis for disciplinary action or performance review ratings. Supervisors must be able to review and contest AI-generated soft-skill scores. If an agent disputes an AI-generated score, there must be a human review process.

---

## §5 — Access to essential services (financial services)

**Not yet in heatmap — Q3 2026 expansion.**

This section will cover AI used in credit scoring, insurance underwriting, fraud detection, and other financial services decisions covered by Annex III §5. Relevant enforcement date: **2026-08-02** (same as §4).

Articles 9-15 apply with additional sector-specific considerations:
- Article 10 data governance intersects with financial sector data requirements (GDPR + sector regulation)
- Article 15 accuracy must be benchmarked against regulatory standards for credit decisioning

---

## Provider vs. Deployer: whose obligation is it?

See `PROVIDER-DEPLOYER-MATRIX.md` for the full reference.

**Quick summary for §4(a/b) enterprise HR software:**

| Obligation | Vendor (as Provider) | You (as Deployer) |
|---|---|---|
| Technical documentation | Vendor maintains | You verify it exists and request access |
| Conformity assessment | Vendor's responsibility | Confirm vendor has done this (ask for EU AI Act compliance statement) |
| EU AI Office registration | Vendor's responsibility | Not your obligation for vendor-supplied AI |
| Art. 9 Risk register | Vendor documents the system | YOU document your deployment context |
| Art. 12 Logging | Vendor provides log capability | YOU confirm logs are retained in your tenant |
| Art. 13 Instructions | Vendor must provide | YOU read and act on them; YOU inform your employees/applicants |
| Art. 14 Human oversight | Vendor must design for it | YOU implement the oversight process in your HR workflow |
| Art. 26(5) Incident reporting | Both have obligations | YOU report to your DPA if AI causes a serious incident |

**The items in the "You" column are what a BRAGI Assessment evaluates.** The vendor's documentation exists or it doesn't — you cannot fix it. Your process, your AI register, your employee disclosures, and your oversight design are what you control and what the DPA will ask for.
