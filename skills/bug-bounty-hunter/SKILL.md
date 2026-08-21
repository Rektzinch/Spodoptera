---
name: bug-bounty-hunter
description: Authorized, non-destructive web and API security assessment orchestration for Hermes. Use for scoped bug-bounty engagements requiring signal-driven recon, attack-surface reasoning, focused module routing, evidence validation, and reporting.
---

# Bug Bounty Hunter

Spodoptera is the control plane. Hermes/Muse is the reasoning engine. Keep this file in context; load detailed references and workflows only when observations require them.

## Prime directive

Optimize for **signal over volume**. Recon is valuable when it changes the next decision. Prefer understanding architecture, trust boundaries, assumptions, and inconsistencies over maximizing hosts, endpoints, requests, scanners, or runtime.

Reasoning loop:

`OBSERVE → UNDERSTAND → MODEL → BOUNDARY → HYPOTHESIS → SCORE → MINIMUM_EFFECTIVE_TEST → COMPARE → CORRELATE → VALIDATE`

For mature bug-bounty targets, prioritize authorization drift, business/state-machine errors, API/version differences, identity lifecycle, integration gaps, concurrency edge cases, parser/normalization differences, legacy surfaces, change signals, and cross-service enforcement.

## Boundary

Before active testing, read or create `engagement/authorization.md`. Active work requires explicit target/scope, exclusions, applicable rate/concurrency limits, and authorized accounts where relevant.

Stop when scope is missing, ambiguous, expired, or contradicted. Stay low-rate and non-destructive. Exclude DoS/load testing, persistence, destructive changes, spam, real purchases, credential attacks, unauthorized secret use, indiscriminate data collection, and out-of-scope activity.

## Control loop

Use this state machine:

`SCOPE → RECON → MAP → MODEL → HYPOTHESES → PRIORITIZE → TARGETED_TESTING → CORRELATE → REPRODUCE → IMPACT → REPORT → SELF_EVALUATE`

At each state:

1. Record what is known and the highest-value unanswered question.
2. Update the adaptive target model when a new relationship, boundary, object, identity, service, or state is learned.
3. Score competing next actions by information gain, boundary value, evidence quality, request cost, and operational risk.
4. Choose the smallest action capable of answering the top question.
5. Define expected signal, control, request cost, risk, and stop condition.
6. Execute within scope and preserve evidence.
7. Update the system model, correlate related candidates, and re-rank hypotheses.
8. Pivot when an action stops producing decision-changing information.

Load `references/orchestration.md` when starting an engagement, changing state, selecting tools, building the hypothesis ledger, or deciding whether to stop/pivot.

## Progressive routing

Load only what the current evidence justifies:

| Evidence / surface | Load |
| --- | --- |
| Initial asset discovery | `references/recon.md` + `workflows/quick-recon.md` |
| Existing prior snapshot / recent deployment signal | `references/change-driven-recon.md` |
| Multiple services/objects/identities need relationship modeling | `references/target-model.md` |
| Several plausible next actions compete | `references/scoring.md` |
| Two identities/versions/clients/routes can be compared | `references/differential-analysis.md` |
| Multiple candidates may share one root cause | `references/correlation.md` |
| Tool selection or escalation decision | `references/tool-registry.md` + `data/tools.json` |
| Pause/resume/handoff | `references/checkpoint-resume.md` |
| Progress stalls or engagement nears completion | `references/self-evaluation.md` |
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

## Adaptive model

When the engagement moves beyond simple discovery, maintain relationships among:

`asset → service → endpoint → identity/role → object → state → trust boundary → evidence → hypothesis`

Load `references/target-model.md` for the schema and update rules. Prefer testing seams where the same object, role, state, or policy appears through multiple services, versions, clients, or execution paths.

## Prioritization

When more than one useful action exists, load `references/scoring.md`. Favor novelty, boundary value, business criticality, complexity/change signals, evidence strength, clean differential controls, and low request cost. Re-score after decision-changing evidence.

## Evidence lifecycle

Scanner/tool output is never a finding by itself. Use:

`OBSERVATION → HYPOTHESIS → CANDIDATE → REPRODUCED → CONFIRMED`

Alternative terminal states: `REJECTED` or `NEEDS-EVIDENCE`.

A confirmed finding requires reproducible evidence, an appropriate control comparison, understood prerequisites, an identified security boundary, and bounded impact. Use `references/validation.md` for the complete rules. Before reporting multiple related candidates, load `references/correlation.md` and decide whether they are one root cause, parent/child manifestations, or separate findings.

## Engagement bootstrap and continuity

Run as applicable:

```bash
scripts/init-engagement.sh <engagement-dir> <target>
scripts/bootstrap.sh
scripts/check-tools.sh
```

Missing tooling is a routing constraint, never a reason to invent evidence. Preserve raw requests/responses, timestamps, commands, tool versions, scope decisions, negative controls, current model, hypothesis queue, and snapshots in the engagement directory; redact sensitive material before sharing.

Before pausing or handing off, load `references/checkpoint-resume.md` and save a checkpoint. On resume, read the checkpoint before running recon again.

## Output

Use `templates/finding.md` for findings and `templates/report.md` for final reporting. Report uncertainty, rejected hypotheses, root-cause correlation decisions, and meaningful coverage gaps explicitly.

## Completion

Before marking an engagement complete, load `references/self-evaluation.md`. Finish when the authorized surfaces selected for the engagement have been modeled sufficiently to answer the active hypotheses, candidates have been confirmed/rejected/marked needs-evidence, duplicate manifestations are correlated, evidence is preserved, findings are reproducible, limitations are explicit, and another cycle is unlikely to produce enough new information to justify its cost and risk.
