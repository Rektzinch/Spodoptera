# Spodoptera

Spodoptera is an orchestration skill for Hermes security engagements. It does not replace Hermes/Muse's reasoning engine and it is not a scanner. It coordinates scope, reconnaissance, attack-surface mapping, technology-aware module routing, hypothesis-driven testing, evidence validation, and reporting.

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
