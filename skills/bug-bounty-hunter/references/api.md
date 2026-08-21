# API assessment methodology

## Contents

1. Required artifacts
2. Surface classification
3. Contract and parameter model
4. Trust-boundary model
5. Differential test families
6. Dynamic routing
7. Validation and exit criteria

## Required artifacts

Create these before targeted testing:

- `api-sources.tsv`: source, base URL, version, confidence, first-seen timestamp.
- `api-routes.tsv`: method, normalized route, parameters, content types, authentication, actor, object, side effect, source.
- `api-contracts.tsv`: input field, location, type, required, client-controlled, server-derived, accepted variants.
- `api-boundaries.tsv`: client, edge/gateway, service, data store, async worker, external integration, expected enforcement.
- `api-hypotheses.tsv`: route, property, baseline, one-variable test, oracle, stop condition, status.

Do not test a route until its host and route are confirmed in scope. Preserve original and normalized route forms.

## Surface classification

Classify each surface before selecting tests:

| Dimension | Values to record | Why it matters |
|---|---|---|
| Protocol | REST, JSON-RPC, XML/SOAP, GraphQL, WebSocket, event/callback | Determines transport and parser model. |
| Exposure | public, authenticated, partner, admin, internal-name-only | Establishes expected caller boundary. |
| Operation | read, create, update, delete, action, export, batch, async | Predicts side effects and authorization checks. |
| Object | user, tenant, order, file, entitlement, payment, configuration | Defines ownership and sensitivity. |
| Identity | anonymous, session, API key, bearer token, service credential | Defines authentication context. |
| Execution | synchronous, queued, webhook, scheduled, fan-out | Reveals alternate enforcement points. |

Discover routes from OpenAPI/Swagger, client code, traffic captures, public documentation, error messages, historical URLs, and observed links. Keep sources separate: a client reference or historical URL is a hypothesis until live behavior confirms it.

## Contract and parameter model

For every route, model the server contract rather than fuzzing arbitrary fields:

1. Establish a valid baseline using a synthetic object.
2. Identify path, query, header, cookie, and body inputs.
3. Record type, cardinality, default, allowed range, ownership meaning, and whether the value should be server-derived.
4. Record output fields, redaction rules, pagination metadata, and object relationships.
5. Create an invalid control and a nonexistent-object control.

Use a field-behavior matrix:

| Field class | Baseline | Omitted | Type-changed | Extra field | Other actor's value | Expected property |
|---|---|---|---|---|---|---|
| Server-derived | accepted | server computes | rejected | ignored/rejected | ignored/rejected | Client cannot set it. |
| User input | accepted | documented default/error | deterministic validation | ignored/rejected | policy-dependent | Contract is consistent. |
| Object reference | accepted | deterministic error | rejected | n/a | authorization control | Reference is scoped to actor/tenant. |

Treat mass assignment, type coercion, and excessive data exposure as separate hypotheses. Confirmation requires demonstrating a protected field or relationship crossed—not merely that an undocumented field is accepted.

## Trust-boundary model

Draw the observed request path:

`client → CDN/WAF → API gateway → application → worker/service → datastore/integration`

For each hop record transformations to path, method, headers, identity, body, and error. Ask where authentication, object authorization, field allowlisting, idempotency, and rate control are expected. Compare only observed alternate paths: web/mobile API, old/new version, direct/queued operation, single/batch route, synchronous/webhook result.

Do not assume an `internal` route is vulnerable because its name is internal. Prove reachability, missing enforcement, and a security-relevant action or disclosure with a safe test object.

## Differential test families

Run only families justified by the route model, one variable at a time:

### Method and transport

- Compare documented method with server-advertised/observed alternatives.
- Compare JSON, form, and multipart only when the route or client supports them.
- Record redirects and method preservation; do not infer behavior from status alone.
- Compare gateway and application errors to locate enforcement.

### Version and route parity

- Compare observed versions for authentication, authorization, fields, and state semantics.
- Check whether deprecated routes remain live and whether the same object policy applies.
- Treat response-shape differences as observations until protected data or action is shown.

### Object and function authorization

- Load `authorization.md` for any object identifier or privileged action.
- Compare own synthetic object, another controlled account's object, nonexistent object, and invalid identifier.
- Compare list, detail, mutation, export, batch, and async result surfaces when observed.

### Pagination, filtering, and projection

- Verify tenant/owner filters remain applied across page, cursor, sort, filter, search, and sparse-field options.
- Confirm totals and metadata do not disclose cross-boundary counts or identifiers.
- Avoid bulk enumeration; use two controlled objects and the smallest page.

### Batch and asynchronous behavior

- Determine whether each item is authorized independently.
- Record partial-success semantics, retries, deduplication, and result retrieval controls.
- Route duplicate/atomicity signals to `race-conditions.md` or `business-logic.md`.

### Error and rate-control observations

- Compare stable controls before interpreting timing or error wording.
- Separate authentication, authorization, validation, not-found, and gateway errors.
- Rate-control testing must remain low-volume and explicitly authorized; do not attempt exhaustion.

## Dynamic routing

| Signal | Load next | Question to answer |
|---|---|---|
| Object ID or tenant key | `authorization.md` | Is the object scoped to actor and tenant? |
| Privileged action | `authorization.md` | Is function-level authorization enforced server-side? |
| JWT/OAuth/session token | `authentication.md` | Is identity context bound and lifecycle-correct? |
| GraphQL transport | `graphql.md` | Are resolver and field policies consistent? |
| Upload/import/URL | `file-upload.md` / `ssrf.md` | Where does untrusted content cross a boundary? |
| State-changing workflow | `business-logic.md` | Which invariant or transition can fail? |
| Duplicate/queued behavior | `race-conditions.md` | Are atomicity and idempotency enforced? |
| Cache/CDN behavior | `cache.md` | Does private state enter a shared cache key? |

## Validation and exit criteria

Reject candidates explained by redirects, stale documentation, mock/test routes, harmless unknown fields, object-nonexistence, WAF differences, or inconsistent but non-security-relevant errors.

Complete API coverage when:

- route, contract, actor/object, and trust-boundary inventories exist;
- high-value reads and mutations have positive, negative, and cross-identity controls;
- alternate observed versions/transports are compared where relevant;
- every candidate is `CONFIRMED`, `REJECTED`, or `NEEDS-EVIDENCE` under `validation.md`;
- untested routes and missing identities are explicitly listed.
