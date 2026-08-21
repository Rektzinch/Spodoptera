# GraphQL assessment methodology

## Contents

1. Fingerprint the transport
2. Build a minimal schema and operation map
3. Model resolver authorization
4. Assess mutations, batching, and persisted queries
5. Assess subscriptions and federation
6. Validate findings and controls

## Fingerprint the transport

Confirm GraphQL from observed traffic, client code, content type, operation documents, or endpoint behavior. Record:

- endpoint and API version;
- GET/POST and accepted content types;
- authentication and tenant context;
- operation name, variables, extensions, persisted-query fields;
- response/error format;
- gateway, federation, or vendor indicators;
- WebSocket/SSE subscription transport when observed.

Do not assume every `/graphql` path is live or in scope. Preserve the original request used by the application as the baseline.

## Build a minimal schema and operation map

Use the least revealing source available:

1. Application operation documents and client bundles.
2. Public documentation or generated types.
3. Error-guided field/type observations from a known operation.
4. Introspection only when permitted and necessary.

Do not dump the full schema when a focused type/operation suffices. Create:

- `graphql-operations.tsv`: operation, type, actor, root field, variables, object, side effect, source.
- `graphql-types.tsv`: type, sensitive fields, identifiers, ownership/tenant relation, confidence.
- `graphql-resolvers.tsv`: path, expected actor/object/field policy, observed enforcement.

Classify data paths from root to nested fields. Authorization may exist at the root resolver but fail on nested relationships, interfaces/unions, node lookup, search, edges, or computed fields.

## Model resolver authorization

For each sensitive path, apply the policy model from `authorization.md`:

`actor + operation + object + field + tenant + state → allow/deny`

Build a field-aware matrix:

| Actor | Own node | Controlled peer node | Other tenant | Sensitive nested field | Mutation |
|---|---:|---:|---:|---:|---:|
| Anonymous | ? | ? | ? | ? | ? |
| User A | allow | policy | deny | policy | policy |
| User B | policy | allow | deny | policy | policy |

Use two controlled identities and synthetic nodes. Compare:

- direct node lookup vs list/search connection;
- root field vs nested relationship;
- global/node ID vs domain-specific lookup;
- object field vs interface/union fragment;
- query vs mutation return object;
- mutation action vs follow-up object state;
- aliases/fragments only as alternate representations of the same authorized request.

A different GraphQL error path or partial `data` response is an observation. Confirm which field or action crossed the boundary.

## Variables, inputs, and mutations

Model input objects and server-derived fields. For each mutation record actor, current state, target state, protected input fields, side effects, and idempotency behavior.

Compare omitted, null, invalid-type, extra, and protected fields only when the input contract supports the hypothesis. Route mass assignment/field authorization to `api.md` and state-transition logic to `business-logic.md`.

Verify that mutation return fields and generated job/result IDs are authorized independently. A mutation may reject an action but still disclose a protected object in its error or payload.

## Batching, aliases, and persisted queries

Treat batching and aliases as execution shapes, not automatic vulnerabilities. Determine:

- whether each operation/item is authenticated and authorized independently;
- whether limits, errors, and partial results preserve tenant/object boundaries;
- whether persisted-query hashes are bound to an approved operation and variables;
- whether allowlists differ between GET/POST, client versions, or gateways;
- whether cached persisted results vary by identity and tenant.

Keep operation count minimal. Do not use aliases, fragments, or batching for volume amplification or availability testing.

## Complexity and resource controls

Map depth, breadth, pagination, recursive relationships, and expensive computed fields only to understand policy. Do not attempt resource exhaustion. At low volume, record whether limits are present and whether a normal business query can unexpectedly bypass a documented guard. Availability impact requires separate explicit authorization.

## Subscriptions, federation, and gateways

When subscriptions are observed, load `websocket.md`. Check authentication at connection and subscription time, object/channel authorization, token refresh/revocation, and event filtering with synthetic channels.

For federation/gateway surfaces record subgraph/service boundaries, entity references, identity propagation, error-source differences, and policy parity. Do not probe internal subgraph hosts unless separately in scope. A leaked service name is not confirmation of reachability or impact.

## Introspection and error handling

Introspection exposure is context-dependent. Report it only when program policy treats it as sensitive or it materially enables access to protected operations/data. Error messages are evidence when they disclose sensitive schema, object existence, internal service details, or inconsistent authorization—not merely because they are verbose.

## Validation and controls

Reject candidates caused by nullable fields, partial success by design, client-side cache artifacts, stale persisted-query registrations, deliberately public fields, or aliases returning the same authorized object.

Confirm a GraphQL finding only with:

- exact operation and variable set;
- actor, tenant, object owner, and lifecycle state;
- authorized baseline plus unauthorized/negative control;
- field-level response and final mutation state;
- resolver/security boundary crossed;
- minimal reproducible query with secrets redacted;
- bounded impact and remediation at resolver/service policy layer.
