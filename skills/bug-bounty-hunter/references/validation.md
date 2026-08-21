# Validation and evidence discipline

## Finding state machine

| Status | Meaning | Promotion requirement |
|---|---|---|
| OBSERVATION | A tool/request produced an interesting signal. | Preserve raw output, source, scope, timestamp. |
| HYPOTHESIS | A falsifiable security property may be violated. | Define actor, object/action, expected policy, oracle. |
| CANDIDATE | A controlled differential contradicts the expected control. | Redacted baseline/test pair and negative control. |
| REPRODUCED | A fresh independent repetition yields the same boundary behavior. | Second capture with fresh object/session where possible. |
| CONFIRMED | A security boundary is crossed with meaningful bounded impact. | Prerequisites, boundary, impact, reproduction, controls. |
| NEEDS-EVIDENCE | Plausible but missing authorization, control, or impact evidence. | Record gap and safe next step. |
| REJECTED | Evidence falsifies or safely explains the claim. | Preserve falsifying evidence and reason. |

Never skip states because a scanner labels severity or confidence.

## Required hypothesis schema

Write every hypothesis as:

`Given <actor/context>, when <one controlled change> affects <object/action>, the system violates <expected property>, observable as <server-side oracle>.`

Record:

- scope and authorization reference;
- affected asset, route/function, actor, tenant, object, state;
- expected property and evidence source;
- valid baseline and invalid/negative control;
- one-variable test and stop condition;
- immediate response and final server-side state;
- prerequisites, repeatability, and uncertainty.

## Control hierarchy

Prefer controls in this order:

1. Same actor/object with valid input.
2. Same actor with nonexistent/invalid object.
3. Other controlled actor's synthetic object.
4. Fresh object/session/key to exclude cache or stale state.
5. Independent repetition using the smallest request set.

Do not use unrelated real users or records as controls.

## Evidence integrity

Preserve UTC time, exact request method/URL, relevant headers, minimal body, status, response hash, tool version/command, and final state. Separate raw evidence from analyst interpretation.

Redact cookies, bearer tokens, API keys, OTPs, passwords, signed URLs, personal data, account IDs when unnecessary, and cloud credentials. Retain a short fingerprint or hash when correlation is required.

For blind/out-of-band signals, record canary ownership, unique correlation ID, timestamp window, DNS/HTTP evidence, and false-positive controls. A timing change without a stable control is insufficient.

## Correlation rules

Correlate scanner output, raw HTTP, client behavior, application state, worker/job result, and external side effects. Prefer the authoritative server-side state over UI messages or a single status code.

If signals conflict, lower confidence and identify the unresolved layer. Do not average conflicting evidence into a positive finding.

## Common false positives

Reject or retest:

- redirects or generic error pages parsed as success;
- cached/browser/service-worker responses;
- stale sessions, test fixtures, mock/staging behavior;
- object nonexistence or deliberate sharing;
- reflected request data without persistence/execution;
- eventual consistency that converges correctly;
- WAF/challenge differences without application behavior;
- verbose errors or exposed identifiers without a crossed boundary;
- documented public functionality or business policy disagreement.

## Severity and confidence

Determine severity from asset sensitivity, attacker prerequisite, affected population, boundary crossed, action/data obtained, persistence/reversibility, and reproducibility. Use CVSS/CWE as supporting classifications, not evidence.

Set confidence independently:

- **High:** clean controls, independent reproduction, direct final-state evidence.
- **Medium:** reproducible behavior with one bounded inference or environment limitation.
- **Low:** observation/hypothesis lacking a decisive oracle; usually `NEEDS-EVIDENCE`.

## Confirmation gate

Mark `CONFIRMED` only when all are true:

- target/action is authorized and in scope;
- expected property is established;
- baseline, negative control, and test differ for the intended reason;
- a fresh repetition succeeds;
- the violated security boundary is explicit;
- impact is demonstrated safely or clearly labeled as bounded inference;
- evidence is redacted and reproduction does not require destructive activity.
