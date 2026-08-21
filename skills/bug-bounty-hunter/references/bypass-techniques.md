# Differential and alternative-path analysis

Use bypass analysis only after a concrete policy or validation hypothesis exists. Compare normalization, URL/path encoding, Unicode, duplicate parameters, parser types, headers, content types, methods, alternate API versions, route case, proxy rewrites, and frontend/backend validation.

Change one dimension at a time and compare a control request. A different status code is not enough; identify the policy decision that changed and the security boundary crossed. Avoid payload spraying and do not attempt to evade detection or access systems outside scope.

## Build the model first

Write the expected processing chain: client → CDN/WAF → gateway/proxy → router → framework parser → authorization/validation → handler. Record which layer appears to canonicalize the path, select a route, parse the body, or enforce policy. A bypass hypothesis should name two layers expected to disagree.

## Differential dimensions

Select only dimensions relevant to the observation:

- path or host normalization and proxy rewrites;
- method selection, override behavior, or method-specific middleware;
- content type versus actual body parser;
- duplicate key, array/scalar, null, numeric, or boolean interpretation;
- route case, trailing separator, API version, or legacy alias;
- header ownership and trusted forwarding metadata;
- frontend validation versus direct backend enforcement.

For each variant preserve the canonical control, mutate one dimension, and compare routing, authenticated actor, selected object, policy result, and side effect—not status alone.

## Evidence and exit

A credible candidate requires reproducible evidence that the alternate representation reaches a different policy path while representing the same protected action or object. Reject differences caused only by generic WAF challenges, unstable upstreams, redirects, serialization changes, or equivalent error templates.

Stop after the parser/policy hypothesis is confirmed or falsified. Route confirmed intermediary disagreement to `request-smuggling.md` only when explicit authorization and evidence justify that module.
