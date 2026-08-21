# Web mapping

Build a map before testing. Inventory hosts, paths, methods, parameters, cookies, auth requirements, content types, redirects, roles, and state transitions.

For each route record: `method | URL pattern | parameters | actor | object | state | expected policy | observed response | source | confidence`.

Use browser/HTTP captures, crawler output, JavaScript references, OpenAPI documents, and historical URLs as separate sources. Normalize URLs without losing the original form. Mark paths that are only client-side, stale, or blocked.

Prioritize routes that mutate state, access objects by identifier, handle uploads/imports, proxy URLs, change roles, expose administrative functions, or return data for a different actor. Keep crawl depth and request rate bounded. Avoid submitting forms or replaying sensitive actions unless the engagement explicitly permits it and a synthetic test object is ready.
