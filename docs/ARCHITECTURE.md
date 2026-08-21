# Architecture

Spodoptera is a progressive-disclosure skill. `SKILL.md` contains the compact control plane. Hermes loads a workflow and references only after an observed attack-surface signal.

## Decision doctrine

The architecture optimizes for information gain per safe request. Before an active action, Hermes records the question, minimum input, expected artifact, routing consequence, and stop/pivot condition. A result is useful when it changes the architecture model, trust-boundary map, actor/object/state model, or hypothesis queue.

High-security-maturity targets are treated as systems of seams rather than collections of URLs. The orchestrator prioritizes differences across identities, roles, tenants, API versions, transports, services, caches, parsers, integrations, asynchronous transitions, and legacy/current implementations.

## Runtime model

1. `init-engagement.sh` creates authorization, state, evidence, and ledger paths.
2. Recon tools produce timestamped artifacts.
3. Hermes classifies hosts/routes and routes to focused modules.
4. Each module creates hypotheses and selects the least invasive test.
5. The finding ledger records controls, tests, prerequisites, status, evidence, and next actions.
6. `deep-validation.md` promotes, rejects, or parks candidates.
7. Templates turn validated evidence into a report.

After every decision-changing result, Hermes re-ranks the hypothesis queue by boundary relevance, plausible impact, supporting evidence, minimum test cost, and operational risk. Repeated duplicate evidence triggers a pivot instead of more scanning.

## Routing examples

| Signal | Module | Next action |
|---|---|---|
| `/api/v2/graphql` | `graphql.md` | Map operations, types, and authorization. |
| `Authorization: Bearer eyJ...` | `authentication.md` | Analyze token/session lifecycle with a test account. |
| `multipart/form-data` upload | `file-upload.md` | Map storage and retrieval authorization. |
| `wss://` handshake | `websocket.md` | Compare channel/object permissions. |
| URL fetch/import parameter | `ssrf.md` | Use an authorized canary only. |
| Equivalent objects across API versions | `api.md` + `authorization.md` | Compare the same actor/object policy. |
| Personalized response behind a CDN | `cache.md` + `authorization.md` | Model cache key and identity boundary. |
| Queued or repeatable state transition | `business-logic.md` + `race-conditions.md` | Test bounded invariants with synthetic objects. |
| Parser/intermediary disagreement | `request-smuggling.md` + `bypass-techniques.md` | Validate one explicit disagreement safely. |

## Evidence model

Tools are evidence producers, never verdicts. Every candidate has a baseline, one controlled differential, a repeat, a security boundary, and a bounded impact claim. Raw evidence stays local and is redacted before reporting.

The lifecycle is `OBSERVATION → HYPOTHESIS → CANDIDATE → REPRODUCED → CONFIRMED`, with `REJECTED` and `NEEDS-EVIDENCE` available at any evidence gate. Severity never substitutes for confidence.
