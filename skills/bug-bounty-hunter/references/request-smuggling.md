# HTTP request parsing and smuggling methodology

## Contents

1. Authorization and isolation gate
2. Map the HTTP topology
3. Model parser agreement
4. Run safe diagnostics
5. Interpret evidence
6. Stop and validation criteria

## Authorization and isolation gate

Request-smuggling tests can affect other connections and caches. Run active desynchronization testing only in an isolated staging environment or when the engagement explicitly authorizes the exact proxy path, technique class, request budget, and stop conditions.

Before any active diagnostic, record:

- target host and exact front-end/back-end path;
- protocol negotiated by the client and upstream hop;
- whether connections/queues are isolated;
- maximum requests/connections;
- harmless canary route owned by the operator;
- latency/error stop thresholds;
- cache and other-user impact controls.

If isolation cannot be established, limit work to passive topology evidence and mark the hypothesis `NEEDS-EVIDENCE`. Do not send desynchronizing payloads to shared production connections.

## Map the HTTP topology

Build an observed hop map:

`client → CDN/WAF → load balancer → reverse proxy/API gateway → application server`

For each hop record evidence for:

- HTTP/1.1, HTTP/2, HTTP/3 on ingress;
- upstream translation protocol where observable;
- connection reuse and multiplexing;
- normalization of method, path, host, headers, and body;
- timeout and size limits;
- cache behavior;
- provider/server fingerprints and error-source differences.

Do not infer a vulnerable topology from product names or version banners alone.

## Model parser agreement

The hypothesis is that adjacent hops disagree on request boundaries or semantics. Model dimensions without jumping to exploit payloads:

| Dimension | Front-end interpretation | Back-end interpretation | Required evidence |
|---|---|---|---|
| Message length | | | controlled body boundary difference |
| Transfer coding | | | deterministic parsing/error difference |
| Duplicate/conflicting headers | | | hop-specific normalization |
| Header whitespace/casing | | | different accepted canonical form |
| Method/body semantics | | | body forwarded/ignored disagreement |
| HTTP/2 translation | | | pseudo-header or length translation difference |
| Path/authority | | | routing disagreement, not just redirect |

Load `bypass-techniques.md` for normalization analysis. Change one dimension at a time and use a unique harmless canary.

## Run safe diagnostics

Use a progressive evidence ladder:

1. **Passive evidence:** compare protocol negotiation, response headers, server errors, and documented proxy chain.
2. **Single-request differential:** send isolated well-formed variants that should be semantically equivalent; compare deterministic handling.
3. **Connection-local canary:** only when isolation is proven, determine whether a follow-up canary on the same controlled connection is affected.
4. **Staging reproduction:** reproduce the exact topology with operator-owned routes and logs.

Do not use another user's request as a victim, poison a shared queue/cache, target administrative paths, bypass authentication, or chain to credential/data capture. Never increase volume to compensate for ambiguous evidence.

Use a fresh connection and canary for controls. Repeat an anomalous result on a new isolated connection to distinguish parser state from ordinary backend variance.

## HTTP/2 and translation analysis

When ingress uses HTTP/2 or HTTP/3, determine whether a gateway translates to HTTP/1 upstream. Record handling of content length, pseudo-headers, authority/path, forbidden connection-specific headers, and request body framing through safe well-formed comparisons.

An HTTP/2 error, downgrade, or different status is not confirmation. Evidence must connect the translation disagreement to a changed boundary or security-relevant routing effect in the isolated canary environment.

## Interpret evidence

Separate these outcomes:

| Outcome | Interpretation |
|---|---|
| Consistent rejection | Parsers/edge enforce a common rule; reject hypothesis. |
| Hop-specific error | Topology/normalization observation; not yet smuggling. |
| Timeout only | Ambiguous; could be buffering/network/backend load. |
| Same-connection canary affected | Candidate parser-state disagreement; reproduce in isolation. |
| Cross-request routing/cache effect | Security-relevant only if safely isolated and bounded. |

Rule out load balancing, retries, health checks, cache hits, sticky sessions, WAF challenges, application latency, and malformed-request rejection before promoting a candidate.

## Cross-module routing

- Cache-key/routing effects → `cache.md`.
- Authentication or tenant-context loss → `authorization.md`.
- Method/path/content-type normalization → `bypass-techniques.md` and `api.md`.
- Front-end/back-end evidence from cloud gateways → `cloud.md`.

## Stop and validation criteria

Stop immediately on increased latency/errors, connection instability, unexpected shared-cache changes, unrelated response content, or exhaustion of the authorized request budget.

Confirm only when an isolated, low-volume experiment independently demonstrates parser disagreement, connection/request boundary effect, security boundary crossed, and a safe bounded impact. Otherwise report topology evidence and a staging reproduction plan as `NEEDS-EVIDENCE`.
