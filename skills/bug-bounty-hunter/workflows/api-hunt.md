# API hunt workflow

## Phase 1 — Scope and sources

Confirm API hosts, versions, authenticated roles, synthetic accounts/objects, request budget, and excluded actions. Collect routes from observed traffic, OpenAPI/Swagger, client code, public documentation, and historical sources without merging provenance.

Output: `api-sources.tsv` and a list of unresolved ownership/scope questions.

## Phase 2 — Inventory and contracts

Normalize routes while preserving originals. Record method, content type, parameters, actor, object, side effect, and execution model. Build the contract and trust-boundary artifacts required by `references/api.md`.

Output: `api-routes.tsv`, `api-contracts.tsv`, `api-boundaries.tsv`.

## Phase 3 — Identity, object, and function model

For each high-value route identify identity source, owner/tenant, privileged functions, field sensitivity, lifecycle state, and async result path. Load `references/authorization.md` for object/function routes and `references/authentication.md` for token/session lifecycle.

Output: actor-object/function matrices with missing cells explicitly marked.

## Phase 4 — Hypothesis generation

Prioritize reads/mutations involving protected objects, server-derived fields, version parity, batch/async execution, export/search, pagination/filtering, uploads/imports, GraphQL, cache, and state transitions. Give every hypothesis a baseline, one-variable test, oracle, and stop condition.

Output: `api-hypotheses.tsv` ordered by signal, impact, safety, and evidence cost.

## Phase 5 — Targeted testing

Execute the smallest differential set from `references/api.md`. Use synthetic objects and two controlled identities. Route specialized signals to GraphQL, upload, SSRF, business logic, race, cache, or parser modules. Do not run broad fuzzers or `sqlmap` without a parameter-specific indication.

Output: redacted request/response controls and updated finding ledger.

## Phase 6 — Correlation and validation

Correlate scanner, client, gateway, application, worker, and final-state evidence. Reject differences without a security boundary. Apply `workflows/deep-validation.md` to every candidate.

Exit only when confirmed/rejected/needs-evidence status, coverage gaps, missing roles, untested versions, and rate/scope limitations are recorded.
