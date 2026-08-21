# SSRF and server-side fetches

Identify URL, webhook, import, preview, image, PDF, callback, and integration parameters. Determine whether the server fetches, resolves, redirects, or validates the destination. Use an operator-controlled canary endpoint when authorized; do not access cloud metadata, internal services, credentials, or third-party networks.

Separate client-side navigation, open redirect, blind callback, and server-side fetch. Record DNS/redirect behavior, egress identity, timing, and response exposure. Confirm the security boundary without turning the test into internal network scanning.

## Fetch pipeline model

Map input source → parser/canonicalizer → allow/deny policy → DNS resolution → redirect handling → outbound client → response processing/storage. Record which component performs each step and whether validation occurs before or after resolution/redirects.

Start with an HTTPS endpoint controlled by the operator that returns a unique inert marker. Compare a normal permitted URL, an invalid destination, and the canary while changing one field at a time. Use callback timestamps and unique identifiers to distinguish server-side retrieval from browser activity or unrelated scanners.

Hypotheses may cover inconsistent policy across preview/import/webhook paths, redirect revalidation, URL-parser disagreement, or unexpected response exposure. Do not probe private ranges, link-local or metadata addresses, loopback, internal hostnames, alternate ports, or third-party systems.

## Validation

A callback proves outbound interaction, not automatically sensitive reachability or high impact. Establish the intended trust boundary, attacker control, prerequisites, redirect/DNS assumptions, and whether response data or a privileged side effect crosses that boundary.

Reject candidates explained by client navigation, validation-only DNS queries, prefetching unrelated to the feature, or non-reproducible callbacks. Stop after confirming the minimum server-side fetch behavior; do not turn validation into network discovery.
