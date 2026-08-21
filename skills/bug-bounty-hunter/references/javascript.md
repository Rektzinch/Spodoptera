# JavaScript and client-side exposure

Search downloaded JavaScript and source maps for route patterns, API base URLs, GraphQL/WebSocket URLs, feature flags, environment configuration, legacy endpoints, internal hostnames, and accidental secrets. Use `ripgrep`, LinkFinder/SecretFinder where available, `gitleaks`, and `trufflehog` for source/history triage.

Treat every match as a lead. Verify whether the route is live, in scope, authenticated, and security-relevant. Never use discovered credentials or tokens; redact them, recommend rotation, and preserve only a hash or short prefix in evidence.

## Collection and inventory

Collect only assets referenced by in-scope pages or approved historical sources. Preserve source URL, hash, build/version hint, source-map relation, and first-seen time. Deduplicate formatted and minified copies before analysis.

Extract and classify:

- route families, methods, parameter names, and API versions;
- REST, GraphQL, WebSocket, upload, webhook, and identity endpoints;
- object names, roles, feature flags, environment selectors, and client state transitions;
- internal/legacy hostnames, source-map paths, debug routes, and third-party integrations;
- credential-like material and configuration values.

## Correlation and routing

Correlate strings with runtime requests, documentation, historical URLs, and live behavior. A dormant code path or internal hostname is not proof of reachability. Record whether a route is referenced, live, in scope, authenticated, and tied to an object or trust boundary.

Route GraphQL/WebSocket/API/identity/upload signals to their dedicated modules. Route source-to-sink browser data flows to `xss.md`. Route credential-like strings to `secrets.md` without attempting authentication.

## Effectiveness

Prefer queries derived from observed namespaces, route prefixes, build metadata, and domain names over broad regex noise. Stop when additional bundles produce duplicate route families or no new boundary/hypothesis information.

Evidence should include the redacted source location, surrounding semantic context, correlation result, confidence, and next action. Never publish full bundles or proprietary source unnecessarily.
