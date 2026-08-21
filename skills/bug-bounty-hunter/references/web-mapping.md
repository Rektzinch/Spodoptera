# Web mapping

Build a map before testing. Inventory hosts, paths, methods, parameters, cookies, auth requirements, content types, redirects, roles, and state transitions.

For each route record: `method | URL pattern | parameters | actor | object | state | expected policy | observed response | source | confidence`.

Use browser/HTTP captures, crawler output, JavaScript references, OpenAPI documents, and historical URLs as separate sources. Normalize URLs without losing the original form. Mark paths that are only client-side, stale, or blocked.

Prioritize routes that mutate state, access objects by identifier, handle uploads/imports, proxy URLs, change roles, expose administrative functions, or return data for a different actor. Keep crawl depth and request rate bounded. Avoid submitting forms or replaying sensitive actions unless the engagement explicitly permits it and a synthetic test object is ready.

## Architecture relationships

Add edges between browser/client, CDN, gateway, identity provider, API service, worker/queue, storage, webhook, and third party when supported by evidence. Label each edge with the identity or data it trusts. Mark inferred edges separately from observed ones.

Group routes into families rather than treating every URL as unique. Record version, object type, actor, operation, lifecycle state, and equivalent routes in other transports/services. This exposes enforcement drift more efficiently than indiscriminate path enumeration.

## Mapping controls

- Preserve the raw URL before normalization and retain discovery source/confidence.
- Distinguish navigation, API calls, static assets, client-only routes, and redirects.
- Do not replay mutation requests until the object, side effect, and cleanup are understood.
- Use synthetic objects and least-privileged identities for stateful mapping.
- Stop crawling a branch when it yields duplicate route families and no new boundary.

## Output

Produce a route-family inventory, actor/object matrix, state-transition notes, technology/edge map, and a prioritized list of unknown policy cells. Every routed test should point back to one of these artifacts and state what new information it seeks.
