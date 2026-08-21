# Full authorized hunt

Use this workflow when the engagement requires broad reasoning coverage across several connected surfaces. “Full” means the relevant system model and boundaries are covered; it does not mean every tool or payload is run.

## Phase 1 — Scope and decision budget

Record authorization, exclusions, accounts, rate/concurrency limits, and test window. Define high-value business objects and a request budget for each discovery branch. Establish stop conditions before active testing.

## Phase 2 — Architecture-led recon

Run `quick-recon.md`, then expand only branches that change the architecture or trust-boundary model. Record gateways, CDNs, identity providers, API versions, asynchronous workers, storage, callbacks, third parties, administrative planes, and legacy surfaces with confidence labels.

## Phase 3 — Actor, object, and lifecycle models

Build:

- endpoint/parameter inventory grouped by route family and version;
- authentication/session lifecycle including recovery, linking, refresh, and revocation;
- authorization matrix across anonymous, multiple users/tenants, and privileged roles;
- business state machines for valuable objects and irreversible transitions;
- integration map showing which component trusts which identity, object state, header, callback, or client-supplied field.

Unknown cells become hypotheses, not assumptions.

## Phase 4 — Hypothesis queue

Rank each hypothesis by boundary relevance, plausible impact, supporting evidence, minimum test cost, and operational risk. On mature targets, favor inconsistent enforcement across roles, versions, services, transports, lifecycle transitions, queues, caches, and parsers.

For every selected hypothesis define baseline, one-variable mutation, control, success/failure oracle, prerequisites, stop condition, evidence artifact, expected signal, request cost, and operational risk. Allocate the remaining request budget to the highest-priority canonical ledger IDs; module matrices must link back to those IDs. Reject hypotheses quickly when controls explain the behavior.

## Phase 5 — Targeted module execution

Load only the relevant reference bundle and closest workflow. Use the minimum effective test and least-privileged synthetic account/object. Record raw, redacted evidence and negative controls. A tool result may advance an observation to a candidate only when the raw behavior supports it.

Re-rank the queue after each decision-changing result. Correlate apparently separate signals—for example version drift plus object authorization, personalized caching plus tenant identity, or queued state changes plus idempotency.

## Phase 6 — Alternative paths and validation

For credible candidates, examine bounded alternate methods, content types, versions, routing paths, or normalization behavior using the relevant bypass module. Do not broaden into payload spraying.

Run `deep-validation.md` for every candidate. Require independent reproduction, control comparison, prerequisites, boundary crossed, and bounded impact before `CONFIRMED`.

## Completion

Stop when prioritized boundaries have evidence-backed coverage, hypotheses are confirmed/rejected/deferred, additional testing has declining information value, or the engagement window ends. Produce a report containing confirmed findings, rejected and needs-evidence items, coverage gaps, and the rationale for deferred low-signal branches.
