# EU AI Act — Enforcement Calendar

**Version:** 1.0  
**Updated:** 2026-05-12  
**Purpose:** Single-page reference for enforcement dates, applicable obligations, and national enforcement authorities. Use this to assess urgency when interpreting heatmap findings.

---

## Enforcement timeline

| Date | What becomes enforceable | Annex III categories affected | Penalties |
|---|---|---|---|
| **Feb 2, 2025** | Article 5 PROHIBITIONS | Biometric mass surveillance in public spaces, social scoring, real-time remote biometric ID in public spaces, emotion inference in the workplace (§5(1)(f)) | Up to €35M or 7% global turnover |
| **Aug 2, 2025** | GPAI transparency rules + general obligations for GPAI models | General purpose AI models (GPT, Claude, Gemini equivalents) | Up to €15M or 3% global turnover |
| **Aug 2, 2026** | **Annex III HIGH-RISK obligations (Articles 9-15)** | §1 biometrics, §2 critical infrastructure, §3 education, **§4 employment**, **§5 financial/essential services**, §6 law enforcement, §7 migration, §8 justice | Up to €15M or 3% global turnover |
| **Dec 2, 2027** | Stricter obligations for biometric identification and education AI | §1 biometrics, §3 education — these categories face additional requirements from this date | Same as above |
| **Aug 2, 2028** | AI systems embedded in regulated products (medical devices, aviation, automotive) | AI covered by existing product safety directives (MDR, IVDR, NLF) | Sector-specific authorities |

**Today's date: 2026-05-12. Days until Aug 2, 2026: 82 days.**

---

## What August 2, 2026 means for EAU subscribers

If your heatmap shows Red or Yellow findings in §4 (employment and recruitment) or §5 (financial services), your obligations under Articles 9-15 become legally enforceable in **82 days**.

This is not a planning deadline. It is an enforcement date. From August 3, 2026, national market surveillance authorities can:
- Investigate your AI deployment on receipt of a complaint or on their own initiative
- Request your technical documentation and risk management records
- Order suspension of a non-compliant AI system
- Issue fines of up to €15M or 3% of global annual turnover

**Five obligations you must have in place by August 2, 2026 (for each Red/Yellow §4 or §5 finding):**
1. AI register entry for the system (Art. 9)
2. Log retention confirmed in your tenant (Art. 12)
3. Employee/applicant disclosure notice issued (Art. 13)
4. Human oversight process documented and in operation (Art. 14)
5. Vendor accuracy and bias documentation on file (Art. 15)

See `OBLIGATION-DECODER.md` for detailed guidance on each.

---

## National enforcement authorities

Enforcement of the EU AI Act is delegated to national market surveillance authorities. Different countries have different enforcement emphases.

| Country | Authority | Known enforcement focus | Contact |
|---|---|---|---|
| **Germany** | Bundesnetzagentur (BNetzA) | All sectors; expected to be most aggressive enforcer in early years | bundesnetzagentur.de |
| **France** | CNIL + ANSSI | Biometrics, workplace AI, data protection intersections | cnil.fr |
| **Spain** | AEPD + AESIA | Worker rights, biometric monitoring, employment AI | aepd.es |
| **Denmark** | Datatilsynet | HR AI focus; coordinates with CNIL on cross-border cases | datatilsynet.dk |
| **Netherlands** | Autoriteit Persoonsgegevens (AP) | GDPR alignment, employment AI | autoriteitpersoonsgegevens.nl |
| **Sweden** | IMY + MSB | AI in public sector and employment | imy.se |
| **EU-wide** | EU AI Office | GPAI models, cross-border enforcement, coordinating national authorities | digital-strategy.ec.europa.eu |

**For Danish operators:** Datatilsynet is your primary contact. Datatilsynet has historically coordinated closely with the CNIL and applies a GDPR-informed interpretation to workplace AI. HR AI deployments are a known enforcement priority.

**For Nordic/DACH operators with Germany exposure:** BNetzA is expected to be the most aggressive enforcement authority in 2026-2027. If your company has a German subsidiary or German employees in scope of your AI deployment, BNetzA can investigate regardless of where your company is headquartered.

---

## Enforcement risk by heatmap finding

| Finding | Enforcement date | National authority most likely to act | Risk level |
|---|---|---|---|
| §1(c) Emotion recognition — customer calls (NICE CXone) | Aug 2, 2026 | CNIL (France), AEPD (Spain), Datatilsynet (Denmark) | High — biometrics are priority enforcement area |
| §4(a) Recruitment AI — Red (Workday Recruiting Agent) | Aug 2, 2026 | All national authorities | High — employment AI is broadest exposure |
| §4(a/b) HR AI — Yellow (most other rows) | Aug 2, 2026 | All national authorities | Medium — Yellow requires config audit to confirm scope |
| Art. 5(1)(f) Emotion detection on employees (any vendor) | **Feb 2, 2025 — already in force** | All DPAs — treat as urgent | Critical — this is a prohibition, not high-risk |

---

## DPA enforcement tracker (as of 2026-05-12)

No Annex III enforcement actions have been publicly reported as of May 2026 (August 2026 enforcement date has not yet passed). The following Art. 5 prohibition enforcement actions are relevant precedent:

- **Feb 2025:** Art. 5 prohibited practices took effect. No formal enforcement actions publicly confirmed as of May 2026 — DPAs are in observation and preparation phase.
- **EU AI Office:** Published AI Office Q&A on prohibited practices (Feb 2025). Confirmed that emotion inference in workplace contexts is covered by Art. 5(1)(f) regardless of whether the vendor markets it as "coaching" or "sentiment analysis."

This section will be updated at each quarterly update cycle with new enforcement actions.

---

## How enforcement date intersects with quarterly re-verification

The re-verification script (`tools/re-verification.py`) checks source URLs every 90 days and flags changed vendor documentation. The Enforcement Date field in the heatmap enables a new use case: **urgency-based subscriber communication**.

When a subscriber's vendor findings have Enforcement Date = 2026-08-02, and their subscription renewal or the quarterly update falls within 90 days of that date, the email to that subscriber should reference the enforcement proximity explicitly:

> "Your [Vendor] finding in §4 employment AI is subject to enforceable obligations beginning August 2, 2026 — 82 days from today. If you have not yet reviewed your Article 9-14 obligations for this system, this is the quarter to act."

This is not manufactured urgency. It is accurate, dated, specific, and actionable.
