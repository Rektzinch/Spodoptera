# Change-Driven Recon

Load when a previous engagement snapshot exists or when the target changes frequently.

## Goal

Prefer newly changed attack surface over repeatedly scanning an unchanged estate. Mature programs often yield more signal at deployment seams, migrations, new API versions, fresh integrations, and recently altered client bundles.

## Snapshot candidates

Track normalized snapshots of:

- DNS/subdomains and live hosts;
- HTTP status, title, technology and selected headers;
- routes/endpoints and methods;
- OpenAPI/Swagger schema and API versions;
- JavaScript bundle names/hashes, source maps and extracted routes;
- authentication endpoints and token/session behavior;
- GraphQL schema/operation inventory when authorized;
- CDN/cache behavior indicators;
- public configuration and deployment artifacts;
- service fingerprints and certificate metadata.

## Diff categories

Classify each change as:

- `NEW`: previously unseen surface;
- `REMOVED`: surface disappeared;
- `MODIFIED`: same surface, changed behavior/schema/technology;
- `MOVED`: equivalent function exposed through a new route/service;
- `POLICY_DRIFT`: same object/action with changed authorization or validation behavior;
- `NOISE`: cosmetic or non-security-relevant variation.

## Workflow

1. Normalize old and new snapshots before comparing.
2. Rank changed items using `scoring.md`.
3. Map the change into `target-model.md`.
4. Ask which trust boundary or invariant could have changed.
5. Use `differential-analysis.md` to compare old/new or parallel paths when reproducible.
6. Test only the changed seam necessary to answer the hypothesis.
7. Save the new snapshot and rationale for future comparison.

## High-value change signals

Prioritize new API versions, new authentication/recovery paths, newly split microservices, changed object schemas, new upload/import/webhook features, added mobile-only endpoints, legacy route reactivation, newly exposed source maps/configuration, and cache/gateway changes.

## Stop condition

If a changed item does not alter a boundary, inventory, identity model, object model, state machine, or plausible hypothesis, mark it low priority rather than expanding scans around it.