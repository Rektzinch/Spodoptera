# Controlled race-condition methodology

## Contents

1. Preconditions and safety envelope
2. Build the concurrency model
3. Establish serial baselines
4. Design bounded experiments
5. Interpret atomicity and idempotency
6. Validate and stop

## Preconditions and safety envelope

Run concurrency testing only when the engagement explicitly authorizes it and provides a maximum request count/concurrency. Use synthetic, reversible, zero-value, or sandbox operations. Do not treat this module as load testing.

Define before testing:

- exact endpoint and invariant;
- synthetic actor/object and starting state;
- maximum parallel requests and total attempts;
- expected serial outcome;
- server-side oracle and cleanup path;
- latency/error stop thresholds;
- contact/escalation path.

If any item is missing, keep the hypothesis at `NEEDS-EVIDENCE`.

## Build the concurrency model

Classify the suspected window:

| Class | Example invariant | Likely enforcement |
|---|---|---|
| Check-then-act | eligibility checked once | transaction/locking/conditional write |
| Read-modify-write | balance/quantity updated | atomic update/version check |
| One-time consumption | token/coupon/claim used once | uniqueness/consumption record |
| Duplicate creation | one logical request creates one resource | idempotency key/deduplication |
| State transition | only one valid next state | compare-and-swap/state guard |
| Async duplication | retries execute effect twice | durable deduplication/outbox |

Draw the lifecycle: submission, gateway, application check, database write, queue, worker, external side effect, result. Record which steps are transactional and which may retry.

## Establish serial baselines

Before any parallel attempt:

1. Execute the valid operation once.
2. Repeat it serially using the same logical request.
3. Record response, final state, side effects, idempotency key behavior, and timing distribution.
4. Reset with a fresh synthetic object.
5. Repeat the serial control to ensure deterministic behavior.

Do not interpret parallel differences if the serial path is already inconsistent.

## Design bounded experiments

Use the smallest experiment capable of falsifying the invariant:

| Experiment | Request A | Request B | Expected outcome |
|---|---|---|---|
| Identical duplicate | same action/key | same action/key | one logical effect |
| Same object, different action | transition X | conflicting transition Y | one valid final state |
| Same entitlement | claim | claim | at most one success/effect |
| Stale update | version N update | different version N update | conflict or deterministic winner |
| Job retry | original submission | authorized retry path | deduplicated side effect |

Coordinate a pair or very small fixed set; do not increase concurrency merely because the first attempt is negative. Keep connection setup effects separate from application concurrency. Record send timing and server timestamps where available.

Use a fresh object for each experiment. Change only the concurrency dimension; identical payloads should remain identical unless the hypothesis requires conflicting transitions.

## Interpret atomicity and idempotency

Evaluate four layers:

1. **Transport outcome:** status, response body, timeout, retry signal.
2. **Application outcome:** accepted/rejected state and error class.
3. **Persistent outcome:** final object, ledger, counter, or uniqueness record.
4. **External side effect:** controlled notification, entitlement, webhook, or sandbox transaction.

Two success responses are not automatically a vulnerability if one persistent effect exists. One success response is not proof of safety if two side effects occur. The persistent invariant is the primary oracle.

For idempotency, record key scope (actor/route/object), retention window, payload binding, replay response, and behavior across API versions or worker retries. Do not reuse keys against unrelated users or production transactions.

## Sources of false positives

Reject or retest candidates caused by:

- client retries or proxy-generated duplicates;
- eventual consistency that converges to a valid state;
- two response messages for one durable effect;
- test object reset/cleanup lag;
- different logical requests accidentally sharing a label;
- clock skew or network scheduling without invariant failure;
- documented at-least-once delivery with correct downstream deduplication.

## Validate and stop

Confirm a race only when the same bounded experiment independently reproduces a security-relevant invariant failure, with serial controls and persistent state evidence. Record prerequisites, concurrency used, total attempts, before/after state, duplicate side effects, and recovery.

Stop immediately if:

- latency or error rate materially increases;
- the target shows instability or protective throttling;
- effects are not reversible;
- unrelated users or shared resources could be affected;
- the authorized request/concurrency budget is reached.

Never escalate to load, resource exhaustion, queue saturation, or availability testing.
