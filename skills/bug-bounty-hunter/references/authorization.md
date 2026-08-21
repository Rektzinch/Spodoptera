# Authorization, BOLA, BFLA, and tenant isolation

## Contents

1. Authorization model
2. Required matrices
3. Object-level testing
4. Function- and field-level testing
5. Context and tenant binding
6. Alternate enforcement paths
7. Validation and evidence

## Authorization model

Model authorization as a five-part policy:

`actor + action + object + context + state → allow/deny`

- **Actor:** anonymous, user A, user B, tenant admin, support role, service identity.
- **Action:** list, read, create, update, delete, export, approve, impersonate, assign, share.
- **Object:** resource type, owner, tenant, parent, sensitivity, lifecycle state.
- **Context:** channel, token/session, tenant selection, device, delegated role, API version.
- **State:** draft, active, locked, paid, refunded, archived, expired.

Do not reduce authorization testing to changing numeric IDs. First document the expected policy using product behavior, documentation, role descriptions, and controlled object ownership.

## Required matrices

Create an actor-object matrix for each sensitive resource:

| Actor | Own object | Same-tenant peer | Other tenant | Privileged object | Nonexistent object |
|---|---:|---:|---:|---:|---:|
| Anonymous | ? | ? | ? | ? | ? |
| User A | allow | ? | deny | deny | not found |
| User B | ? | allow | deny | deny | not found |
| Tenant admin | policy | policy | deny | policy | not found |

Create a function matrix:

| Function | Anonymous | User | Manager | Admin | Service | Expected server check |
|---|---:|---:|---:|---:|---:|---|
| Read | | | | | | identity + object scope |
| Update | | | | | | role + ownership + state |
| Export | | | | | | role + tenant + sensitivity |
| Approve | | | | | | role + separation of duties |

Create a field matrix for mixed-sensitivity objects:

| Field | Owner can read | Peer can read | Admin can read | Owner can write | Server-derived |
|---|---:|---:|---:|---:|---:|

Use synthetic objects owned by two controlled identities. Never test against an unrelated real user's identifier.

## Object-level testing (BOLA/IDOR)

For each object route, test the smallest safe set:

1. Valid own object (positive control).
2. Other controlled user's object (authorization control).
3. Nonexistent object (not-found control).
4. Invalid identifier (validation control).
5. Privileged or parent-scoped object only when a controlled fixture exists.

Compare more than the status code:

- response schema and sensitive fields;
- content length/hash and error class;
- object state before/after;
- audit/event side effects;
- linked download/export/result URLs;
- async job creation and result retrieval.

Repeat the matrix across observed operations: list, detail, update, delete, share, export, batch, attachment, history, and nested child routes. An object may be protected on detail but exposed in list, export, search, attachment, or job-result surfaces.

An identifier being guessable, sequential, UUID-based, or disclosed is not itself BOLA. Confirm that an unauthorized actor can read or change a protected object or relationship.

## Function- and field-level testing (BFLA)

Map privileged functions from navigation, client code, API descriptions, mobile routes, error messages, and observed traffic. For each function:

1. Establish the intended role and state precondition.
2. Capture an authorized baseline with a dedicated privileged test account if supplied.
3. Replay the same semantic action with a lower-privilege controlled identity.
4. Check server-side outcome and downstream state, not UI visibility.
5. Compare direct, batch, async, export, and alternate-version paths only when observed.

For field-level authorization, compare response/write behavior field by field. Look for protected flags, tenant IDs, owner IDs, role fields, approval state, price/limit fields, or server-derived attributes. Confirmation requires a protected field disclosure or mutation, not merely acceptance of extra JSON.

## Context and tenant binding

Track where tenant and role context comes from:

- session or token claims;
- path/query/header selector;
- object parent relationship;
- user-controlled organization switcher;
- gateway-injected identity headers;
- service-to-service context.

Test whether the server binds client-supplied tenant/role selectors to the authenticated actor. Use two controlled tenants only when the engagement provides them. Check nested objects and cross-tenant parent/child combinations; authorization may validate the child but not its parent, or vice versa.

Record delegation, invitation, sharing, impersonation, and support-access semantics separately. These are context transitions, not ordinary object reads.

## Alternate enforcement paths

Compare policy parity across observed paths:

- web vs mobile API;
- old vs current version;
- single vs batch operation;
- synchronous response vs queued job/result;
- direct object route vs search/export/attachment;
- REST vs GraphQL/WebSocket;
- create-time relationship vs update-time reassignment.

Do not invent alternate routes or spray method overrides. Route GraphQL to `graphql.md`, WebSocket to `websocket.md`, and state-dependent access to `business-logic.md`.

## Validation and evidence

Classify outcomes:

| Outcome | Meaning |
|---|---|
| Clean deny | No protected data/action; deterministic policy response. |
| Existence oracle | Distinguishes object existence without content; assess sensitivity and practicality. |
| Partial disclosure | Some protected field or metadata crosses boundary. |
| Unauthorized action | Protected state changes or job is accepted and completes. |
| UI-only difference | No server-side boundary crossed; reject as authorization finding. |

Reject candidates caused by cached test data, stale tokens, role misconfiguration in test accounts, object sharing that was intentionally enabled, nonexistent objects, or responses that echo request data without persistence.

A confirmed authorization finding must record actor A/B, roles, tenants, object ownership, expected policy, baseline, unauthorized request, negative control, server-side result, boundary crossed, and minimal impact. If the expected policy cannot be established, mark `NEEDS-EVIDENCE`.
