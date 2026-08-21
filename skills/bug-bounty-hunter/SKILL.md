---
name: bug-bounty-hunter
description: Authorized, non-destructive web and API security assessment orchestration for Hermes. Use when an engagement has an explicit target and scope and the agent must perform recon, map attack surface, route to relevant testing modules, correlate scanner output, validate findings, and produce an evidence-backed report.
---

# Bug Bounty Hunter

Use this skill as an orchestration layer for an authorized security engagement. Hermes/Muse remains the reasoning engine; this skill supplies the state machine, evidence discipline, routing rules, tool selection, and report format.

## Non-negotiable engagement boundary

Before any active request, create or read `engagement/authorization.md` (or the equivalent scope supplied by the operator). Record:

- in-scope domains, hosts, paths, APIs, accounts, and test window;
- explicitly excluded assets and actions;
- rate/concurrency limits and contact/escalation details;
- whether authenticated testing is authorized and which test accounts may be used.

If scope is missing, ambiguous, expired, or contradicted by a later instruction, stop active testing and ask for clarification. Never infer ownership from credentials, a hostname, a bug-bounty brand, or a user's claim alone. Keep all requests low-rate and non-destructive. Do not perform DoS/load testing, persistence, destructive changes, spam, real purchases, credential attacks, secret use, data dumping, or testing outside scope.

## Engagement state machine

Progress through these states and record a short status update in the engagement directory:

`SCOPE → RECON → ATTACK_SURFACE_MAP → TECHNOLOGY_ANALYSIS → ENDPOINT_INVENTORY → AUTH_MODEL → AUTHZ_MODEL → HYPOTHESES → TARGETED_TESTING → CORRELATION → ALTERNATIVE_PATHS → REPRODUCTION → IMPACT → REPORT`

Do not skip directly from a scanner alert to a report. A scanner result is an `OBSERVATION`; inspect raw HTTP, create a hypothesis, reproduce independently, compare with a control request, determine prerequisites, identify the violated security boundary, and assess impact. Use `references/validation.md` for status transitions and evidence requirements.

## Start and route an engagement

1. Run `scripts/init-engagement.sh <engagement-dir> <target>` and complete the generated authorization file.
2. Run `scripts/bootstrap.sh` and `scripts/check-tools.sh`. Treat missing tools as a routing constraint, not a reason to invent results.
3. Execute the smallest workflow that answers the current question. Read only the relevant workflow and references; do not preload every module.
4. Preserve raw requests/responses, timestamps, command lines, tool versions, scope decisions, and negative controls under the engagement directory. Redact tokens, cookies, personal data, and secrets before sharing evidence.

### Recon routing

Use the pipeline in `references/recon.md` and `workflows/quick-recon.md`:

`subfinder → dnsx → httpx → interesting hosts`

- web surface → `katana`, `gau`, `waybackurls`, `hakrawler`, then focused `ffuf`/`feroxbuster`;
- API indicators (`/api/`, OpenAPI, JSON, versioned routes) → `workflows/api-hunt.md` and `references/api.md`;
- unusual exposed service → narrow `naabu`/`nmap` inspection within rate limits;
- JavaScript-heavy application → `references/javascript.md` and source-map/route analysis.

Do not run every scanner against every host. Select tools based on observed technology and expected signal. Use passive sources before active enumeration when possible.

### Dynamic module routing

Route observations to modules as soon as they are supported by evidence:

- `/graphql`, GraphQL content type, or GraphQL operation → `references/graphql.md`;
- `Authorization: Bearer eyJ...`, refresh tokens, OAuth/OIDC → `references/authentication.md`;
- `POST`/`PUT` with `multipart/form-data` or upload UI → `references/file-upload.md`;
- WebSocket handshake or `wss://` URL → `references/websocket.md`;
- reflected input or DOM sink → `references/xss.md`;
- SQL error/timing/type differential → `references/sqli.md` and only then consider narrowly scoped `sqlmap`;
- URL-fetch/import/webhook parameter → `references/ssrf.md`;
- `Origin`/CORS behavior → `references/cors.md`;
- cache headers, CDN keys, or personalized responses → `references/cache.md`;
- ambiguous parser/normalization/routing behavior → `references/bypass-techniques.md` and `references/request-smuggling.md`;
- cloud metadata, public bucket, exposed CI/config → `references/cloud.md` and `references/secrets.md`.

When a module is routed, load its reference plus the closest workflow. Record why it was selected and what evidence would falsify the hypothesis.

## Hypothesis-driven testing

For every candidate, create a row in the finding ledger with:

`id | asset | observation | hypothesis | control | test | prerequisite | status | evidence | next action`

Prefer differential tests: same request with one controlled change, two identities, two object IDs, two methods, two content types, or two encodings. Establish a baseline first. Use the least privileged test account and synthetic objects. Avoid brute force; rate-limit observations must remain low-volume and explicitly authorized.

Use tools as evidence producers, not verdicts:

- discovery: `subfinder`, `dnsx`, `httpx`, `asnmap`;
- ports/services: `naabu`, narrow `nmap`;
- crawling/history: `katana`, `gau`, `waybackurls`, `hakrawler`;
- content/parameter discovery: `ffuf`, `feroxbuster`, `arjun`;
- detection: `nuclei`, `dalfox`, `gitleaks`, `trufflehog`;
- request analysis: `curl`, `httpie`, `jq`, `ripgrep`, `unfurl`, `anew`;
- specialized validation: `jwt-tool`, `sqlmap`, `testssl.sh` only after a justified hypothesis and within scope.

Never label a finding High/Critical solely because a template or tool did so. Read the raw evidence and use `references/validation.md`.

## Required finding lifecycle

Use exactly one of these states:

`OBSERVATION → HYPOTHESIS → CANDIDATE → REPRODUCED → CONFIRMED`

or `REJECTED` / `NEEDS-EVIDENCE` when the evidence does not support the claim. A `CONFIRMED` finding must include a control comparison, reproducible steps, prerequisites, a security boundary crossed, and a bounded impact statement. If impact is inferred rather than demonstrated, label it as inference and lower confidence.

## Reporting

Use `templates/finding.md` for each finding and `templates/report.md` for the final report. Include title, severity, confidence, affected asset/endpoint, summary, technical details, prerequisites, steps, expected/actual behavior, redacted request/response evidence, violated boundary, impact/attack scenario, remediation, CWE, and CVSS rationale. Include rejected hypotheses and coverage gaps in an appendix; do not hide uncertainty.

## Reference map

- Recon and mapping: `references/recon.md`, `references/web-mapping.md`.
- Identity and access: `references/authentication.md`, `references/authorization.md`.
- Logic and concurrency: `references/business-logic.md`, `references/race-conditions.md`.
- Input and protocol behavior: `references/xss.md`, `references/sqli.md`, `references/injection.md`, `references/ssrf.md`, `references/file-upload.md`, `references/request-smuggling.md`.
- Specialized surfaces: `references/api.md`, `references/graphql.md`, `references/websocket.md`, `references/javascript.md`, `references/cors.md`, `references/cache.md`, `references/cloud.md`, `references/secrets.md`.
- Differential testing and evidence: `references/bypass-techniques.md`, `references/validation.md`.
- Repeatable procedures: `workflows/quick-recon.md`, `full-hunt.md`, `api-hunt.md`, `auth-hunt.md`, `business-logic-hunt.md`, `deep-validation.md`.

## Completion criteria

An engagement is complete only when scope was recorded, selected surfaces were mapped, hypotheses were either validated or rejected, raw evidence was preserved and redacted, confirmed findings use the required template, and limitations/untested areas are explicit.
