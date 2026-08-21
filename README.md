# Spodoptera

Spodoptera is an orchestration skill for Hermes security engagements. It does not replace Hermes/Muse's reasoning engine and it is not a scanner. It coordinates scope, reconnaissance, attack-surface mapping, technology-aware module routing, hypothesis-driven testing, evidence validation, and reporting.

It is optimized for official bug-bounty programs run by organizations with high security maturity. Mature defenses reduce obvious findings but do not eliminate failures in assumptions, integrations, system changes, edge cases, legacy paths, inconsistent enforcement, and business logic.

## Recon & hunting philosophy

Spodoptera follows **signal over volume**. Recon is valuable when it changes the next decision—not when it merely increases host, endpoint, request, tool, alert, or duration counts.

`OBSERVE → UNDERSTAND ARCHITECTURE → IDENTIFY TRUST BOUNDARIES → FIND ASSUMPTIONS/INCONSISTENCIES → FORM HYPOTHESIS → CHOOSE MINIMUM EFFECTIVE TEST → COMPARE → CORRELATE → VALIDATE IMPACT`

Tools are selected to answer recorded hypotheses or close material coverage gaps. Low-yield branches stop or pivot. Priority seams include authorization drift, business state machines, API/version differences, identity lifecycle, integration boundaries, controlled concurrency, parser/normalization differences, legacy surfaces, and cross-service enforcement.

## Core flow

`SCOPE → RECON → ATTACK SURFACE MAP → TECHNOLOGY ANALYSIS → ENDPOINT INVENTORY → AUTH MODEL → AUTHZ MODEL → HYPOTHESES → TARGETED TESTING → CORRELATION → ALTERNATIVE PATHS → REPRODUCTION → IMPACT → REPORT`

Scanner output is treated as an observation. A finding must survive raw HTTP inspection, a control comparison, independent reproduction, prerequisite analysis, and security-boundary/impact validation.

## Layout

- `skills/bug-bounty-hunter/SKILL.md` — orchestration and dynamic routing.
- `skills/bug-bounty-hunter/references/` — focused modules loaded progressively.
- `skills/bug-bounty-hunter/workflows/` — repeatable engagement procedures.
- `skills/bug-bounty-hunter/scripts/` — environment, engagement, and result helpers.
- `skills/bug-bounty-hunter/templates/` — engagement, finding, and report formats.
- `docs/` — installation, tool inventory, and architecture notes.

## Safety boundary

Use only with explicit authorization and a written scope. Testing is low-rate and non-destructive. DoS/load testing, persistence, destructive changes, credential attacks, secret use, real transactions, data dumping, and out-of-scope activity are excluded.
