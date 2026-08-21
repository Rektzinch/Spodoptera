# Orchestration Reference

Load this reference when starting an engagement, changing workflow state, choosing the next test, or deciding whether to pivot/stop.

## Hunting philosophy

Spodoptera targets authorized bug-bounty engagements, especially mature organizations where obvious findings are uncommon. Optimize for signal over volume. Valuable weaknesses often survive in assumptions, integrations, system changes, legacy paths, edge cases, inconsistent enforcement, identity lifecycle, and business logic.

Reasoning loop:

`OBSERVE → UNDERSTAND_ARCHITECTURE → IDENTIFY_TRUST_BOUNDARIES → FIND_ASSUMPTIONS_OR_INCONSISTENCIES → FORM_HYPOTHESIS → CHOOSE_MINIMUM_EFFECTIVE_TEST → COMPARE_BEHAVIOR → CORRELATE_EVIDENCE → VALIDATE_IMPACT`

Choose a tool only when it answers a hypothesis or closes a material coverage gap. Prefer one-variable differential comparisons. Rank actions by expected information gain, trust-boundary relevance, evidence strength, request cost, and operational risk. Stop or pivot when repeated work no longer changes architecture, inventory, boundaries, or hypotheses.

For mature targets, prioritize authorization inconsistencies, business/state-machine errors, API/version differences, identity lifecycle, integration gaps, concurrency edge cases, parser/normalization differences, legacy surfaces, and enforcement differences between services.

## Engagement state machine

`SCOPE → RECON → ATTACK_SURFACE_MAP → TECHNOLOGY_ANALYSIS → ENDPOINT_INVENTORY → AUTH_MODEL → AUTHZ_MODEL → HYPOTHESES → TARGETED_TESTING → CORRELATION → ALTERNATIVE_PATHS → REPRODUCTION → IMPACT → REPORT`

Record a short state update in the engagement directory whenever the state changes.

## Start procedure

1. Run `scripts/init-engagement.sh <engagement-dir> <target>` and complete authorization/scope.
2. Run `scripts/bootstrap.sh` and `scripts/check-tools.sh`.
3. Select the smallest workflow capable of answering the current question.
4. Preserve raw requests/responses, timestamps, commands, tool versions, scope decisions, and negative controls. Redact sensitive evidence before sharing.

## Recon routing

Start with `references/recon.md` and `workflows/quick-recon.md`.

Typical pipeline: `subfinder → dnsx → httpx → interesting hosts`.

Route web surfaces toward `katana`, historical URL sources, and focused content discovery. Route API indicators to `workflows/api-hunt.md`. Route unusual services to narrow service inspection. Route JavaScript-heavy applications to `references/javascript.md`.

Before an active recon action, define the question, expected artifact, and stop/pivot condition. Omit work that cannot alter routing, prioritization, or a hypothesis.

## Dynamic routing

- GraphQL evidence → `graphql.md`.
- JWT/OAuth/OIDC/session evidence → `authentication.md`.
- Object/function access boundary → `authorization.md` + API workflow.
- Upload surface → `file-upload.md`.
- WebSocket → `websocket.md`.
- Reflected/DOM input → `xss.md`.
- SQL differential → `sqli.md`.
- URL-fetch/import/webhook → `ssrf.md`.
- CORS behavior → `cors.md`.
- Personalized/cache behavior → `cache.md`.
- Parser/routing disagreement → `bypass-techniques.md` + `request-smuggling.md`.
- Cloud/config/artifact exposure → `cloud.md` + `secrets.md`.
- Stateful workflow → `business-logic.md`; add `race-conditions.md` only when a bounded concurrency hypothesis exists.

## Cross-cutting bundles

- REST/API object or privileged function: `api.md` + `authorization.md` + `api-hunt.md`.
- GraphQL object/field/mutation: `graphql.md` + `authorization.md` + `api-hunt.md`.
- Stateful operation: `business-logic.md` + `business-logic-hunt.md`.
- Personalized CDN/API response: `cache.md` + `authorization.md`.
- Proxy/parser disagreement: `request-smuggling.md` + `bypass-techniques.md`.
- Cloud data plane/artifact: `cloud.md` + `secrets.md` plus the boundary-specific module.

## Hypothesis ledger

Use one canonical ledger:

`id | asset | observation | hypothesis | expected_signal | request_cost | risk | priority | control | test | prerequisite | status | evidence | next_action`

Prefer baseline/control comparisons and one controlled variable. Re-rank after decision-changing evidence and avoid duplicate branches.

## Tool classes

- Discovery: `subfinder`, `dnsx`, `httpx`, `asnmap`.
- Services: `naabu`, narrow `nmap`.
- Crawl/history: `katana`, `gau`, `waybackurls`, `hakrawler`.
- Content/parameters: `ffuf`, `feroxbuster`, `arjun`.
- Detection: `nuclei`, `dalfox`, `gitleaks`, `trufflehog`.
- Request/data analysis: `curl`, `httpie`, `jq`, `ripgrep`, `unfurl`, `anew`.
- Specialized validation: `jwt-tool`, `sqlmap`, `testssl.sh` only when justified.

Tools produce evidence, not verdicts.

## Validation and reporting

A scanner alert begins as `OBSERVATION`. Use `references/validation.md` for evidence transitions and `workflows/deep-validation.md` when a candidate warrants reproduction.

Use `templates/finding.md` for confirmed findings and `templates/report.md` for final reporting. Keep rejected hypotheses and coverage gaps explicit.