---
name: bug-bounty-hunter
description: Authorized, non-destructive web and API security assessment orchestration for Hermes. Use for scoped bug-bounty engagements requiring signal-driven recon, attack-surface reasoning, focused module routing, evidence validation, and reporting.
---

# Bug Bounty Hunter

Spodoptera is the control plane. Hermes/Muse is the reasoning engine. Keep this file in context; load detailed references and workflows only when observations require them.

## Prime directive

Optimize for **signal over volume**. Recon is valuable when it changes the next decision. Prefer understanding architecture, trust boundaries, assumptions, and inconsistencies over maximizing hosts, endpoints, requests, scanners, or runtime.

Reasoning loop:

`OBSERVE → UNDERSTAND → BOUNDARY → HYPOTHESIS → MINIMUM_EFFECTIVE_TEST → COMPARE → CORRELATE → VALIDATE`

For mature bug-bounty targets, prioritize authorization drift, business/state-machine errors, API/version differences, identity lifecycle, integration gaps, concurrency edge cases, parser/normalization differences, legacy surfaces, and cross-service enforcement.

## Boundary

Before active testing, read or create `engagement/authorization.md`. Active work requires explicit target/scope, exclusions, applicable rate/concurrency limits, and authorized accounts where relevant.

Stop when scope is missing, ambiguous, expired, or contradicted. Stay low-rate and non-destructive. Exclude DoS/load testing, persistence, destructive changes, spam, real purchases, credential attacks, unauthorized secret use, indiscriminate data collection, and out-of-scope activity.

## Control loop

Use this state machine:

`SCOPE → RECON → MAP → MODEL → HYPOTHESES → TARGETED_TESTING → CORRELATE → REPRODUCE → IMPACT → REPORT`

At each state:

1. Record what is known and the highest-value unanswered question.
2. Choose the smallest action capable of answering it.
3. Define expected signal, control, request cost, risk, and stop condition.
4. Execute within scope and preserve evidence.
5. Update the system model and re-rank hypotheses.
6. Pivot when an action stops producing decision-changing information.

Load `references/orchestration.md` when starting an engagement, changing state, selecting tools, building the hypothesis ledger, or deciding whether to stop/pivot.

## Progressive routing

Load only what the current evidence justifies:

| Evidence / surface | Load |
| --- | --- |
| Initial asset discovery | `references/recon.md` + `workflows/quick-recon.md` |
| Web routes/content | `references/web-mapping.md` |
| REST/OpenAPI/versioned API | `references/api.md` + `workflows/api-hunt.md` |
| Login/session/JWT/OAuth/OIDC | `references/authentication.md` + `workflows/auth-hunt.md` |
| Object/role/function boundary | `references/authorization.md` |
| Stateful workflow/invariant | `references/business-logic.md` + `workflows/business-logic-hunt.md` |
| Bounded concurrency hypothesis | `references/race-conditions.md` |
| GraphQL | `references/graphql.md` + `references/authorization.md` |
| WebSocket | `references/websocket.md` |
| JavaScript/source maps | `references/javascript.md` |
| Reflected/DOM input | `references/xss.md` |
| SQL differential | `references/sqli.md` |
| Generic injection behavior | `references/injection.md` |
| URL fetch/import/webhook | `references/ssrf.md` |
| File upload | `references/file-upload.md` |
| CORS behavior | `references/cors.md` |
| Cache/CDN behavior | `references/cache.md` |
| Parser/routing disagreement | `references/bypass-techniques.md` + `references/request-smuggling.md` |
| Cloud/config/artifact exposure | `references/cloud.md` + `references/secrets.md` |
| Candidate finding | `references/validation.md` + `workflows/deep-validation.md` |

Do not preload every reference.

## Evidence lifecycle

Scanner/tool output is never a finding by itself. Use:

`OBSERVATION → HYPOTHESIS → CANDIDATE → REPRODUCED → CONFIRMED`

Alternative terminal states: `REJECTED` or `NEEDS-EVIDENCE`.

A confirmed finding requires reproducible evidence, an appropriate control comparison, understood prerequisites, an identified security boundary, and bounded impact. Use `references/validation.md` for the complete rules.

## Engagement bootstrap

Run as applicable:

```bash
scripts/init-engagement.sh <engagement-dir> <target>
scripts/bootstrap.sh
scripts/check-tools.sh
```

Missing tooling is a routing constraint, never a reason to invent evidence. Preserve raw requests/responses, timestamps, commands, tool versions, scope decisions, and negative controls in the engagement directory; redact sensitive material before sharing.

## Output

Use `templates/finding.md` for findings and `templates/report.md` for final reporting. Report uncertainty, rejected hypotheses, and meaningful coverage gaps explicitly.

## Completion

Finish when the authorized surfaces selected for the engagement have been modeled sufficiently to answer the active hypotheses, candidates have been confirmed/rejected/marked needs-evidence, evidence is preserved, findings are reproducible, and limitations are explicit.
