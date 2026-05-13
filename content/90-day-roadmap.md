# EU AI Act — 90-Day Implementation Roadmap

**Version:** 1.0  
**Updated:** 2026-05-12  
**Enforcement deadline:** August 2, 2026 (82 days from publication)  
**Purpose:** A sequenced week-by-week action plan for enterprise deployers with Red or Yellow Annex III §4 (employment AI) or §1(c) (biometric/emotion) findings. Turns the Obligation Decoder into an ordered task list.

> **Disclaimer:** This is an operational sequence, not legal advice. Your legal and compliance team should own this process. The sequence below reflects a practical order of dependencies — you cannot issue accurate disclosures (Art.13) before you know which systems are in scope (audit), and you cannot design human oversight (Art.14) before you know what outputs the AI produces.

---

## Before you start: what this roadmap assumes

- You have reviewed your heatmap and identified at least one Red or Yellow §4 or §1(c) finding
- You are a **deployer** — you purchase and configure vendor AI, you do not train or fine-tune models yourself
- Your enforcement date is **August 2, 2026** (Annex III high-risk obligations — Articles 9-15)
- If you have an Article 5(1)(f) concern (employee-facing emotion inference), consult your legal team before anything else — that is a prohibition, not a compliance gap

**If you have zero Red or Yellow findings:** this roadmap does not apply. Monitor the heatmap for quarterly updates.

**If you have 5+ Red findings and fewer than 60 days left:** this roadmap is still the right sequence, but you will need to compress Weeks 1-4 into the first two weeks and may need external support to complete. Contact [Bragi & Co.](https://bragi.co) for assessment support.

---

## Roadmap overview

| Phase | Weeks | Objective | Articles addressed |
|-------|-------|-----------|-------------------|
| **1. Audit** | 1-2 | Know exactly what is active and in scope | Pre-condition for all |
| **2. Register** | 3-4 | Create your AI risk register entries | Art. 9 |
| **3. Vendor engagement** | 5-6 | Obtain vendor compliance documentation | Art. 10, Art. 15 |
| **4. Process design** | 7-8 | Document human oversight and logging | Art. 12, Art. 14 |
| **5. Disclosures** | 9-10 | Issue employee and applicant notices | Art. 13 |
| **6. Readiness** | 11-12 | Final check, governance sign-off | All |

---

## Phase 1 — Audit (Weeks 1-2: May 12-25)

**Objective:** Establish a confirmed list of which AI features are active in your systems, which EU persons are in scope, and who in your organisation is responsible for each system.

This is the foundation. Everything downstream depends on knowing exactly which systems are live — not which systems you purchased, not which systems are in the contract, but which features are actually enabled in your tenant configuration.

### Week 1 tasks

**Task 1.1 — Pull your heatmap Red and Yellow findings**

From the heatmap, list every Red and Yellow row that applies to vendors you have a contract with. For each row, record:
- Vendor name
- Feature name
- Annex III category (§4(a), §4(b), §1(c))
- Default state (on by default / opt-in / add-on module)

**Task 1.2 — Confirm which features are actually active**

For each row from Task 1.1, check your admin configuration. Use the "How to check" field from the heatmap — these are the questions to ask your system administrator, not navigation paths.

| Vendor | Who to ask | What to confirm |
|--------|-----------|----------------|
| Workday | Workday system admin | Is Recruiting Agent active? Is Talent Mobility Agent active? |
| SAP SuccessFactors | SAP SuccessFactors admin | Is Joule enabled? Is AI Candidate Matching active? Is 360 Sentiment Analysis enabled? |
| Oracle HCM | Oracle HCM admin | Is Job Applicant Score enabled? Is Team Talent Calibration using AI scoring? |
| HireVue | HireVue admin | Are AI-scored video interviews in use? Are game-based assessments in use? |
| Greenhouse | Greenhouse admin | Is Talent Rediscovery active? Is Resume Review (AI parsing) enabled? Are AI Scorecard Summaries active? |
| Lattice | Lattice admin | Are AI Performance Review Summaries enabled? Is Team Health AI active? |
| Microsoft Viva | M365 admin | Is Viva Insights licensed separately? Is Productivity Score enabled? Are Manager Effectiveness insights active? |
| NICE CXone | NICE CXone admin | Is Real-Time Analytics with Emotion Detection enabled? Is the CSAT Add-On (agent soft-skill analysis) activated? |

**Output from Task 1.2:** A confirmed list of active features (not just contracted features).

### Week 2 tasks

**Task 2.1 — Determine EU person scope**

For each confirmed active feature, answer:
- Are EU-based employees or job applicants processed by this system?
- Approximately how many EU persons are in scope?
- Which EU countries are represented?

This matters for two reasons: (1) it determines which national authority has jurisdiction, and (2) it calibrates the risk level of each finding.

**Task 2.2 — Assign an internal owner for each system**

Each active AI system must have a named internal owner responsible for compliance for that system. This is typically a shared responsibility:

| Role | Responsibility |
|------|---------------|
| HR Director / CPO | Overall accountability; Art. 14 human oversight process owner |
| System admin / IT | Art. 12 log retention; vendor configuration management |
| Legal / Compliance | Art. 9 risk register; Art. 13 notice review; Art. 26 incident reporting |
| HR Business Partner | Art. 14 day-to-day oversight in hiring and performance processes |

**Output from Week 2:** A one-page inventory: system name, active status confirmed, EU persons in scope, internal owner assigned.

---

## Phase 2 — Register (Weeks 3-4: May 26 - June 8)

**Objective:** Create an Article 9 risk management system entry for each confirmed active system.

Article 9 does not require a sophisticated risk management platform. It requires a documented record that your organisation knows what AI it is running, has assessed the risks of running it, and has assigned responsibility for managing those risks.

### Week 3 tasks

**Task 3.1 — Create your AI register**

Create a register (a spreadsheet is acceptable) with one row per active AI system. Minimum fields per row:

| Field | What to write |
|-------|--------------|
| System name | Exact vendor product name (e.g., "Workday Recruiting Agent") |
| Annex III category | From the heatmap (e.g., "§4(a) — Employment/recruitment") |
| Deployment date | When did you first use this feature for EU persons? |
| EU countries in scope | List countries |
| EU persons in scope | Approximate number |
| Risk assessment summary | 2-3 sentences: what can go wrong, how severe, what mitigates it |
| Internal owner | Name and role |
| Review date | When will you next review this entry? (Annual minimum) |
| Vendor compliance status | Full / Partial / Unknown / None (from heatmap Deployer Gap field) |

**Task 3.2 — Write the risk assessment summary for each system**

For §4(a) employment/recruitment systems, standard risks to assess:
- Algorithmic bias: could the AI score systematically disadvantage candidates from protected groups?
- Transparency gap: can your hiring team explain to a candidate why the AI scored them as it did?
- Over-reliance: are hiring decisions being made based on AI scores without human review of the reasoning?

For §1(c) biometric/emotion systems (NICE CXone):
- Demographic bias in emotion inference: does the system perform equally across accents, genders, language backgrounds?
- False positive routing: what happens when emotion detection is wrong and routes to agent coaching incorrectly?

You do not need to conduct an independent technical audit. At this stage, document what you know and what you are relying on from the vendor.

### Week 4 tasks

**Task 4.1 — Have legal review and sign off the register**

The AI register is a legal document. Your legal or compliance team must review each entry before it is considered complete. Specifically:
- Is the Annex III classification correct for your specific use case?
- Is the risk assessment summary sufficient?
- Are the mitigation measures documented?

**Task 4.2 — Date and version the register**

Version 1.0, dated. Store in a location accessible to your compliance team and retrievable for a market surveillance authority on request.

**Output from Phase 2:** A dated, signed-off AI register with one entry per active system.

---

## Phase 3 — Vendor engagement (Weeks 5-6: June 9-22)

**Objective:** Obtain the vendor documentation you need to complete Articles 10 and 15.

You cannot assess data governance (Art.10) or accuracy benchmarks (Art.15) without vendor documentation. This phase is about getting what you need from your vendors — or documenting that you asked and did not receive it.

### Week 5 tasks

**Task 5.1 — Send vendor compliance questionnaire**

Use the 10-question checklist from `PROVIDER-DEPLOYER-MATRIX.md`. Send to your vendor account team or vendor legal/compliance contact. Flag that you need responses before July 1 to meet your August 2 compliance deadline.

Key questions to prioritise if you cannot send all 10:
1. Is [product] classified as Annex III high-risk under your internal assessment?
2. Do you maintain technical documentation per Annex IV? Can we receive a copy?
3. What bias and demographic testing has been conducted on [feature]?
4. Is any data from our tenant used to train or improve the AI model?

**Known vendor documentation (check these first before contacting account team):**

| Vendor | Where to look first |
|--------|-------------------|
| Workday | AI Fact Sheets — request from account team; available per feature |
| SAP SuccessFactors | EU AI Act FAQ v1.0 — check SAP Trust Center |
| Oracle HCM | AI Terms §4.1-4.2 — review your existing contract addendum |
| Greenhouse | bias-audit-statement at greenhouse.com; Warden AI monthly reports |
| HireVue | Contact account team — no formal statement found as of May 2026 |
| Lattice | AI Use Terms at lattice.com/trust |
| Microsoft Viva | trust.microsoft.com — extensive documentation |
| NICE CXone | Contact compliance team — no EU AI Act statement found as of May 2026 |

### Week 6 tasks

**Task 6.1 — Log vendor responses**

For each vendor, record:
- Date questionnaire sent
- Date response received (or "no response as of [date]")
- Which questions were answered with specific documentation
- Which questions received vague or no response

**Task 6.2 — Update AI register Vendor Coverage field**

Based on responses, update each register entry with what the vendor has provided and what remains your responsibility to build.

**Task 6.3 — Escalate non-responsive vendors**

If a vendor has not responded within 2 weeks: escalate to your account executive or legal contact. Document the escalation. If the vendor cannot demonstrate any EU AI Act compliance posture by late June, treat their Deployer Gap as "None" and plan to build all deployer obligations without vendor support.

**Output from Phase 3:** Vendor compliance documentation on file (or documented absence), AI register updated with Vendor Coverage.

---

## Phase 4 — Process design (Weeks 7-8: June 23 - July 6)

**Objective:** Design and document your human oversight process (Art.14) and confirm log retention is in place (Art.12).

This is the phase most organisations underestimate. Issuing a disclosure notice (Art.13) is straightforward. Having a genuinely functioning human oversight process (Art.14) — where a human actually reviews AI outputs and can meaningfully override them — requires process change, not just documentation.

### Week 7 tasks

**Task 7.1 — Design your Art.14 human oversight process for each system**

For each §4 system in your register, document:

- **Who** reviews AI outputs before employment decisions are made? (Name the role — not "the system" or "the team")
- **What** do they review? (The AI score, the reasoning, the underlying data?)
- **How** do they access the AI output for review? (Which screen in which system?)
- **Can they override?** (Is there a mechanism to proceed differently from the AI recommendation? Is there any penalty — formal or informal — for overriding?)
- **Is override documented?** (If a human reviewer overrides an AI recommendation, is that recorded?)

**Common failure patterns to avoid:**

| Pattern | Why it fails Art.14 |
|---------|-------------------|
| "HR reviews all AI scores" with no documented process | Undocumented oversight is unverifiable oversight |
| AI score is the only criterion for shortlisting | If the AI decides who is reviewed, humans are not in the loop at the decisive step |
| Hiring managers can override but face implicit pressure not to | Human oversight must be genuinely free, not merely technically possible |
| "We'll review if there's a complaint" | Art.14 requires proactive oversight before decisions, not reactive review after |

**Task 7.2 — Check your ATS/HRIS configuration for override mechanisms**

In Workday: confirm that AI recommendations do not auto-advance candidates without human review step. In SAP SuccessFactors: confirm Joule summaries are presented as inputs to human review, not as final ratings. In HireVue: confirm that AI scores are visible to reviewers alongside the underlying video, not just as a numeric output.

### Week 8 tasks

**Task 8.1 — Confirm Art.12 log retention**

For each active system, confirm with your system admin:
- Are AI-generated scores, assessments, and recommendations logged in the system?
- Are those logs exportable?
- Are they retained for at least 6 months? (Check your employment law — some jurisdictions require longer)
- Are they accessible to your compliance team on request?

If logs are not retained by default: check vendor settings. If the vendor does not retain logs: document this as a vendor gap and implement your own logging process (e.g., export AI scores from each cycle into a secured compliance folder).

**Task 8.2 — Document the oversight process**

Write a one-page process document per active system:
- System name
- Art.14 oversight owner
- Process steps (numbered)
- How override is recorded
- Log retention confirmation and location

**Output from Phase 4:** Documented oversight process per system, log retention confirmed.

---

## Phase 5 — Disclosures (Weeks 9-10: July 7-20)

**Objective:** Issue Article 13 notices to affected employees and applicants.

Use the templates from `NOTICE-TEMPLATES.md`. At this point you have everything you need: confirmed active systems (Phase 1), Annex III classification (Phase 2), vendor documentation (Phase 3), and human oversight process (Phase 4) — all of which must be accurately reflected in the notices.

### Week 9 tasks

**Task 9.1 — Draft applicant notices for active §4(a) systems**

Using Template 1 from NOTICE-TEMPLATES.md, draft a notice for each active recruitment AI system (or a combined notice covering all). Fill in:
- Exact tool names
- What each tool analyses (from vendor documentation obtained in Phase 3)
- Human reviewer role (from Art.14 process documented in Phase 4)
- Contact details for rights requests

**Task 9.2 — Legal review of applicant notices**

Have your legal team review the draft notices before issuance. Key review questions:
- Does the notice accurately describe what the AI does based on vendor documentation?
- Does it accurately describe your oversight process?
- Is the rights contact monitored and capable of responding within GDPR timeframes?

### Week 10 tasks

**Task 10.1 — Draft employee notices for active §4(b) systems**

Using Template 2 from NOTICE-TEMPLATES.md, draft a notice for each active performance/workforce AI system. Fill in the same fields as above plus retention period (from Art.12 log retention confirmed in Phase 4).

**Task 10.2 — Issue notices and record issuance**

Issuance channels and record requirements:

| Channel | Record requirement |
|---------|-------------------|
| Email to existing employees | Retain sent email with timestamp and recipient list |
| Onboarding documents for new employees | Signed acknowledgment in onboarding file |
| Application portal for candidates | Screenshot or system log showing notice displayed at application |
| Updated employment contract | Dated contract with notice included |
| HR handbook update | Version-controlled handbook with publish date |

**Task 10.3 — Update Art.13 in your AI register**

For each system, mark Art.13 as complete in your register with the date notice was issued and the channel used.

**Output from Phase 5:** Notices issued, issuance documented, register updated.

---

## Phase 6 — Readiness (Weeks 11-12: July 21 - August 1)

**Objective:** Verify all five obligations are in place for each active system. Get sign-off before August 2.

### Week 11 tasks

**Task 11.1 — Complete readiness checklist (one per active system)**

For each system in your AI register, work through this checklist:

**Article 9 — Risk management system**
- [ ] AI register entry exists, is dated, is named to this specific system
- [ ] Deployment context documented (EU countries, persons in scope)
- [ ] Risk assessment summary written and reviewed by legal
- [ ] Internal owner assigned

**Article 10 — Data governance**
- [ ] Vendor documentation of training data obtained (or absence documented)
- [ ] If you have customised the AI with your own data: that customisation is documented

**Article 12 — Log retention**
- [ ] AI-generated scores and outputs are being logged in your system
- [ ] Logs are retained for minimum 6 months
- [ ] Logs are accessible to compliance team on request

**Article 13 — Transparency**
- [ ] Applicant notice issued for all §4(a) systems (if applicable)
- [ ] Employee notice issued for all §4(b) systems
- [ ] Customer notice updated for NICE CXone emotion detection (if applicable)
- [ ] Issuance documented with date and channel

**Article 14 — Human oversight**
- [ ] Process document exists naming the oversight role
- [ ] Override mechanism confirmed (technically possible, no implicit penalty)
- [ ] Override is logged

### Week 12 tasks

**Task 12.1 — Internal sign-off meeting**

Bring together: Legal, HR Director, system admins. Present the completed readiness checklist per system. Identify any items not yet complete. Assign owners and deadlines for remaining gaps.

**Task 12.2 — Document what remains incomplete**

If any obligation cannot be completed before August 2, document:
- What is incomplete
- Why (vendor non-response, system limitation, resource constraint)
- What you are doing to remediate
- Target completion date

A documented gap with a remediation plan demonstrates good faith to a market surveillance authority. An undocumented gap with no awareness is the worst position.

**Task 12.3 — Establish quarterly review cadence**

The EU AI Act is not a one-time compliance event. Schedule:
- Quarterly: check heatmap for new findings or risk level changes
- Annual: re-verify Art.15 accuracy documentation from vendors
- On system change: re-run the Art.9 risk register entry for any new AI feature activated
- On vendor notification: update AI register and notices if vendor changes the AI system's capabilities

**Output from Phase 6:** Signed-off readiness checklist per system. Gap log for anything not complete. Quarterly review schedule established.

---

## Quick reference: what each Article requires of you

| Article | Your obligation | Minimum evidence |
|---------|----------------|-----------------|
| Art. 9 | Risk register entry per system | Dated spreadsheet row naming the system, deployment context, risk summary, owner |
| Art. 10 | Data governance documented | Vendor training data statement on file, or your own data use documented |
| Art. 12 | Log retention in place | Admin confirmation that logs are retained and accessible |
| Art. 13 | Notice issued to affected persons | Sent email or signed acknowledgment with date |
| Art. 14 | Human oversight process documented | Process document naming oversight role and override mechanism |

---

## If you need help

This roadmap defines the sequence. A BRAGI Assessment defines what specifically applies to your organisation — your vendor stack, your EU employee footprint, your current process gaps — and produces a prioritised remediation plan. If you have three or more Red findings and fewer than 60 days to August 2, the Assessment is the fastest path to defensible compliance posture.

[Contact Bragi & Co.](https://bragi.co) — assessments typically scope and deliver within 2-3 weeks.
