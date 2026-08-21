# Cache and CDN security methodology

## Contents

1. Map cache layers and eligibility
2. Model cache keys and variation
3. Assess privacy boundaries
4. Assess attacker-controlled cache influence safely
5. Assess invalidation and revalidation
6. Validate and reject false positives

## Map cache layers and eligibility

Identify observed layers:

`browser/service worker → CDN/reverse proxy → gateway → application cache → datastore/materialized result`

For each response record:

- URL, method, status, content type, and redirect chain;
- `Cache-Control`, `Age`, `Expires`, `ETag`, `Last-Modified`, `Vary`, and provider cache headers;
- authentication, cookies, tenant, locale, device, and experiment state;
- whether the body is public, personalized, sensitive, or attacker-influenced;
- cache hit/miss/revalidated evidence and time;
- purge/invalidation trigger if observed.

Do not infer a shared cache from headers alone. Establish repeatable hit/miss behavior using controlled identities and an approved isolated fixture.

## Model cache keys and variation

Build a cache-key matrix:

| Input dimension | Response varies? | Cache key varies? | Security expectation |
|---|---:|---:|---|
| Host/scheme | | | distinct authority and protocol |
| Path/query | | | semantic parameters included/normalized safely |
| Method/body | | | unsafe methods not shared as GET equivalents |
| Authorization/cookie | | | personalized content private or identity-keyed |
| Tenant/role | | | strict tenant/privilege separation |
| Origin/CORS | | | `Vary: Origin` or non-cacheable where needed |
| Encoding/language/device | | | content variance matches key |
| Feature flag/experiment | | | no privilege or sensitive cross-contamination |

Change one dimension at a time. Record response hash and a non-sensitive marker. Normalize neither the request nor the result in a way that hides the exact cache key candidate.

## Assess privacy boundaries

Use two controlled identities and synthetic content:

1. Request as identity A and record cache evidence.
2. Request the same semantic resource as anonymous or identity B.
3. Compare body, sensitive fields, headers, age, and server-side object ownership.
4. Repeat with a fresh unique object/key to exclude stale shared test data.

Check list/detail, export/download, redirect, error, GraphQL persisted query, and async-result surfaces only when observed. Private content crossing to another controlled identity is stronger evidence than a missing `private` directive alone.

Do not request unrelated users' cached data or enumerate keys.

### Safe fixture preflight

Before a cross-identity cache comparison, verify that the test resource is an operator-created object, is visible only to the two approved test identities, has a unique inert marker in its body/metadata, has a known TTL or purge path, and can be removed safely. Do not add an arbitrary query parameter merely to make a URL unique: it may become part of the cache key and invalidate the hypothesis.

Prefer a dedicated synthetic object identifier in the normal supported route. Confirm the marker is absent from a fresh control object and that the intended semantic URL is stable before comparing identities. If the resource is not isolatable, or cache expiry/purge is unknown, record `NEEDS-EVIDENCE` instead of attempting any cache-influence test.

## Assess attacker-controlled cache influence safely

Only use a dedicated synthetic path/object and a harmless marker. Identify inputs that affect the response but may be absent from the cache key: query, header, locale, origin, host-related routing, content negotiation, or client hint.

Required controls:

- marker appears only in the controlled response;
- a fresh key is unaffected before the test;
- the marker persists only through the suspected cache layer;
- the test does not alter a shared production page or another user's response;
- cleanup/purge or natural expiry is known.

If isolation is not possible, do not attempt cache poisoning. Record `NEEDS-EVIDENCE` and recommend a staging reproduction.

For cache-deception hypotheses, map routing and cache eligibility of public vs authenticated paths without constructing paths that could expose another user's data. Demonstrate only with a dedicated synthetic account/resource.

## Invalidation and revalidation

Model events that should invalidate or change cache policy:

- login/logout and privilege/tenant switch;
- object update/delete/archive;
- password/MFA/session change;
- publication/unpublication;
- authorization/share change;
- file replacement and signed-URL expiry.

Compare pre-event, immediate post-event, and revalidated state. Distinguish acceptable eventual propagation from continued unauthorized access. Record documented TTL/grace behavior and whether stale directives are intentional.

For validators (`ETag`, `Last-Modified`), verify that conditional responses preserve authorization and do not reveal protected existence or reuse a validator across identities where that matters.

## Cross-module routing

- Personalized GraphQL or persisted-query cache → `graphql.md`.
- Origin-dependent cached response → `cors.md`.
- Tenant/object leak → `authorization.md`.
- Path/parser disagreement at multiple proxies → `request-smuggling.md` or `bypass-techniques.md`.
- Signed URL or cloud CDN/object storage → `cloud.md`.

## Validate and reject false positives

Reject candidates caused by browser cache, service worker state, client-side data stores, application sessions, naturally changing content, missing headers without an actual shared cache, or public data intentionally shared.

Confirm only when:

- cache layer and key/variation hypothesis are identified;
- controlled hit/miss or revalidation evidence exists;
- baseline and fresh-key controls rule out client/application state;
- protected or attacker-influenced content crosses a defined boundary;
- reproduction uses synthetic isolated data and does not affect others;
- TTL, prerequisites, impact, and remediation are documented.
