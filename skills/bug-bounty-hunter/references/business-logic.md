# Business-logic and state-machine methodology

## Contents

1. Build the domain model
2. Define invariants and oracles
3. Generate hypotheses
4. Execute safe differential tests
5. Analyze cross-channel and asynchronous paths
6. Validate business impact

## Build the domain model

Model the application before testing transitions. Create:

- `actors.tsv`: actor, role, tenant, prerequisites, allowed capabilities.
- `assets.tsv`: object, owner, value/sensitivity, lifecycle, parent relationships.
- `states.tsv`: state, entry condition, allowed actors, allowed exits, terminal/ reversible.
- `transitions.tsv`: action, from-state, to-state, preconditions, server-derived values, side effects, idempotency.
- `invariants.tsv`: invariant, assets protected, enforcement point, observable oracle.

Represent the legitimate workflow, including failure and cancellation paths:

`CREATE → VERIFY → APPROVE → PAY → FULFILL → REFUND`

Also map `REJECT`, `EXPIRE`, `CANCEL`, `RETRY`, `ROLLBACK`, and `ARCHIVE`. Security bugs often live in negative or recovery paths rather than the happy path.

For each transition record:

- actor and role;
- object owner and tenant;
- required previous state;
- values expected to be server-derived;
- time/expiry requirements;
- one-time tokens or idempotency keys;
- monetary, entitlement, inventory, notification, and audit side effects;
- whether execution is synchronous, queued, webhook-driven, or manually approved.

## Define invariants and oracles

An invariant is a property that must remain true across every valid transition. Examples:

- only the owner or authorized role can mutate an object;
- a one-time benefit can be consumed at most once;
- total/price/discount is calculated from authoritative server data;
- a terminal state cannot return to an active state without an authorized reversal;
- child and parent objects remain in the same tenant;
- fulfillment cannot precede required verification/payment;
- retries do not duplicate side effects;
- expired invitations/tokens cannot create new authority.

For each invariant define an oracle: the smallest observable evidence that it held or failed. Use server-side object state, ledger entry, entitlement, audit event, or controlled notification. A success message from the client is not a sufficient oracle.

## Generate hypotheses

Generate hypotheses from the model, not from random parameter changes:

### State skipping

Ask whether a later transition accepts an object that has not completed a mandatory earlier state. Compare valid previous state, invalid previous state, terminal state, and nonexistent object.

### Replay and duplicate use

Ask whether a one-time transition, token, invitation, coupon, claim, or confirmation can be reused after success, expiry, cancellation, or role change. Keep attempts low and use synthetic benefits.

### Reordering and stale state

Ask whether transitions can execute in a different order, whether stale clients overwrite newer state, or whether a canceled/expired object is still actionable through an observed alternate path.

### Client-trusted authority

Identify client-supplied owner, tenant, role, price, quantity, currency, limit, status, approval, or entitlement fields. Compare them with the server's authoritative source. Route protected-field writes to `authorization.md`.

### Relationship integrity

Test whether valid controlled objects from different parents, actors, or tenants can be combined. Confirm both child and parent authorization and lifecycle compatibility.

### Boundary values and accounting

Test documented minimum/maximum, zero/empty, rounding boundary, currency/unit conversion, and quantity relationships using harmless values. Do not create real charges, refunds, or financial loss.

### Time and expiry

Record server time source, validity interval, grace period, and refresh behavior. Compare just-before/after states only when naturally reachable; do not manipulate system clocks or flood retries.

### Recovery and exception paths

Map retry, resume, support override, webhook retry, manual approval, partial failure, cancellation, and rollback. Confirm these paths enforce the same identity, object, and invariant rules.

## Execute safe differential tests

Use one synthetic object per hypothesis and change one dimension at a time:

| Control | Variant | Oracle |
|---|---|---|
| Valid state + authorized actor | invalid prior state | transition must fail without side effect |
| Fresh one-time token | same token after successful use | no duplicate benefit/action |
| Server-derived value omitted | client-supplied protected value | server ignores/recomputes/rejects |
| Same-tenant parent/child | controlled cross-tenant combination | relationship rejected |
| Serial valid actions | bounded concurrent pair | invariant remains true |

Record pre-state, request, immediate response, final state, side effects, and cleanup/reversal. Use dry-run, sandbox, zero-value, or reversible flows where supplied. Stop before real-world impact.

## Analyze cross-channel and asynchronous paths

Compare only observed channels: web, mobile, API version, GraphQL, WebSocket, webhook, batch, export, background job, and support/admin tool. A transition may validate policy on submission but not in the worker, or protect the action but expose the result.

For asynchronous operations record:

- authorization at job creation and result retrieval;
- snapshot vs execution-time state;
- retry/deduplication behavior;
- partial success and compensation;
- webhook authenticity and event ordering;
- whether role/tenant changes after enqueue are respected.

Route atomicity questions to `race-conditions.md` and object/function checks to `authorization.md`.

## Validate business impact

Reject candidates that are UI inconsistencies, harmless duplicate messages, documented business policy, test fixtures, or state changes that the same actor is already permitted to perform.

Confirm only when:

- the intended invariant and policy are documented;
- a baseline and one-variable control exist;
- final server-side state or side effect proves failure;
- the actor gains value, authority, access, or an unauthorized state transition;
- prerequisites and repeatability are bounded;
- impact is demonstrated with synthetic data or explicitly labeled as inferred.

Report the failed invariant, transition path, pre/post state, actor/object/tenant, alternative paths checked, and remediation at the authoritative enforcement point.
