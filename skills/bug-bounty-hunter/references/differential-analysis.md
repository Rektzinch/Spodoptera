# Differential Analysis

Load when two identities, versions, clients, methods, encodings, gateways, or execution paths can be compared.

## Principle

Change one variable at a time. A differential is useful only when the control and test differ in a way that can be attributed to a specific security assumption.

## Comparison axes

Prioritize:

- anonymous vs authenticated;
- user A vs user B;
- user vs privileged role;
- same object owner vs non-owner;
- tenant A vs tenant B;
- API v1 vs v2/v3;
- web client vs mobile client;
- documented endpoint vs legacy/undocumented equivalent;
- gateway route vs alternate backend path when both are in scope;
- GET vs POST/PUT/PATCH/DELETE behavior;
- JSON vs form vs multipart content type;
- canonical path vs normalized/encoded equivalent;
- synchronous action vs queued/worker result;
- cache miss vs cache hit with controlled identities.

## Differential record

`id | invariant | baseline | changed_variable | test | expected_same_or_different | observed_difference | alternative_explanations | confidence`

## Method

1. State the invariant that should hold.
2. Capture a stable baseline.
3. Modify exactly one meaningful variable.
4. Repeat when timing or cache effects can confound results.
5. Compare status, headers, body shape, object ownership, side effects, state transitions, and downstream evidence.
6. Rule out benign explanations before promotion.
7. Link the differential to `target-model.md` and the finding ledger.

## High-value differentials

- authorization decision differs by route/version for the same object;
- fields hidden by one client are accepted by another API path;
- gateway blocks a function but a legacy route reaches the same backing service;
- logout/password reset invalidates one token family but not another;
- mobile and web use different policy enforcement for the same account action;
- cache varies on fewer identity dimensions than the origin response;
- queued processing skips a validation performed synchronously.

## Stop condition

Stop when repeated comparisons no longer isolate a variable, when controls are unstable, or when the test cannot remain within the engagement boundary.