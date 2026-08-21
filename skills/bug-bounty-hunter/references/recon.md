# Recon pipeline

Recon builds a decision-quality model of an authorized target. Use passive sources first, deduplicate every output, and keep active requests in scope and below the engagement rate limit. Do not measure progress by raw host, URL, request, or alert count.

## Decision loop

For each recon action, record:

1. **Question** — what uncertainty about the architecture, asset, trust boundary, or route should this action reduce?
2. **Minimum input** — the smallest host set, path set, wordlist, or request sample likely to answer it.
3. **Expected artifact** — the field or comparison that will be added to the attack-surface map.
4. **Routing consequence** — which module or hypothesis becomes more or less likely.
5. **Stop/pivot condition** — when further enumeration has declining value.

Skip an action when its output cannot change a decision. Source diversity is useful; redundant tool volume is not.

## Core pipeline

`subfinder → dnsx → httpx → classify → prioritize → route`

- `subfinder`: enumerate program-approved subdomains and retain the source/confidence.
- `dnsx`: resolve relevant records, identify aliases and wildcard DNS, and distinguish infrastructure evidence from scope authorization.
- `httpx`: record status, title, redirects, content type, TLS, technology hints, and stable response fingerprints.
- `asnmap`: use only when ASN ownership is explicitly in scope; never expand scope from ASN data alone.
- `naabu`/`nmap`: confirm a specific service hypothesis on approved hosts with narrow ports and conservative timing.
- `katana`, `gau`, `waybackurls`, `hakrawler`: collect complementary route evidence; historical URLs remain hypotheses until live behavior is confirmed.
- `ffuf`, `feroxbuster`, `arjun`: use targeted low-rate inputs derived from observed naming, framework, versioning, or documentation—not generic exhaustive lists.

## Classification model

Classify each live asset by function and boundary, not only technology:

| Dimension | Examples | Why it matters |
|---|---|---|
| Role | public site, identity, API, admin, webhook, upload, static assets | selects the next workflow |
| Data plane | user data, billing, files, telemetry, configuration | reveals likely impact boundaries |
| Identity | anonymous, session, bearer token, service credential | routes authentication/authorization analysis |
| Architecture | monolith, gateway, CDN, microservice, third-party integration | suggests enforcement and parser differences |
| Lifecycle | current, beta, versioned, deprecated, historical | prioritizes legacy and version drift |
| Confidence | observed, inferred, historical-only | prevents assumptions becoming facts |

Prioritize assets where multiple boundaries meet: identity plus API gateway, personalized content plus cache, upload plus asynchronous processing, billing plus webhooks, or old and new API versions sharing objects.

## High-maturity target priorities

Assume common paths may be heavily tested. Seek evidence of seams and inconsistent assumptions:

- different authorization behavior across API versions, transports, or services;
- lifecycle transitions that cross identity, account recovery, payment, or fulfillment systems;
- legacy routes, source maps, feature flags, alternate hosts, and partially retired integrations;
- edge/CDN behavior that differs from origin behavior;
- asynchronous jobs, retries, callbacks, and race windows;
- client/server or proxy/backend normalization differences;
- administrative or partner functions exposed through ordinary object models.

This is a prioritization rule, not permission to bypass scope or increase test intensity.

## Artifacts

Store `subdomains.txt`, `resolved.jsonl`, `http.jsonl`, `urls.txt`, `services.txt`, and `recon-decisions.md`. The route inventory should include source, first-seen time, live confirmation, function, status, content type, auth requirement, version, observed objects, likely boundary, confidence, and routed module.

Do not treat a `200` response, scanner label, historical URL, exposed name, or technology fingerprint as proof of sensitive access or vulnerability.

## Routing signals

- `/api`, JSON, OpenAPI, Swagger, or versioned routes → API and authorization bundle.
- GraphQL route or operation envelope → GraphQL and authorization bundle.
- WebSocket upgrade or `wss://` URL → WebSocket module.
- upload UI or multipart request → file-upload module.
- OAuth/OIDC, JWT, recovery, account linking → authentication workflow.
- CDN/cache headers with personalized responses → cache and authorization modules.
- webhook, import, preview, or URL-fetch feature → SSRF/trust-boundary analysis.
- source map, client config, internal hostname, feature flag → JavaScript and secrets analysis.
- ambiguous method, path, encoding, or intermediary behavior → bypass/request-parsing analysis.

Read `web-mapping.md` before active crawling.

## Effectiveness and exit criteria

Evaluate a recon branch by decision-changing outputs: newly confirmed architecture relationships, trust boundaries, object/actor models, route families, or testable hypotheses. Raw counts are context only.

Stop or pivot when:

- additional sources produce only duplicates;
- active discovery repeats known route patterns without changing classification;
- a host class has enough evidence to route into a focused workflow;
- the next step would cost many requests but answer no specific question;
- the engagement limit, rate ceiling, or scope boundary is approached.

Recon is complete enough when every prioritized asset has a function, confidence, likely trust boundary, and justified next action—or an explicit reason for no further testing.
