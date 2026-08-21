# Business-logic hunt workflow

## Phase 1 — Domain model

Identify actors, assets, ownership/tenant relationships, legitimate states, negative states, transitions, authoritative values, side effects, retries, and async components. Build the artifacts required by `references/business-logic.md`.

Output: `actors.tsv`, `assets.tsv`, `states.tsv`, `transitions.tsv`, `invariants.tsv`.

## Phase 2 — Oracle design

For every invariant define the smallest server-side oracle: final object state, ledger/entitlement, controlled notification, audit event, or synthetic external side effect. Reject UI messages as sole evidence.

Output: invariant-to-oracle mapping and safe cleanup/reversal plan.

## Phase 3 — Hypothesis generation

Generate candidates for state skipping, replay, reorder, stale state, protected client fields, relationship integrity, boundary/accounting values, expiry, cancellation, retry, rollback, webhook ordering, and duplicate execution. Route object/function policy to `authorization.md` and atomicity to `race-conditions.md`.

Output: prioritized hypothesis ledger with baseline, variant, oracle, and stop condition.

## Phase 4 — Safe differential testing

Use one synthetic object per hypothesis. Record pre-state, one controlled change, immediate response, final state, side effects, and cleanup. Use dry-run, sandbox, zero-value, or reversible flows when available. Never create real charges, refunds, balances, or irreversible changes without explicit authorization.

## Phase 5 — Cross-channel and async parity

Compare only observed web/mobile/API-version/GraphQL/WebSocket/batch/job/webhook paths. Check policy at submission, worker execution, result retrieval, retry, and compensation. Preserve actor/tenant context throughout.

## Phase 6 — Validation

Confirm only a reproducible invariant failure that grants unauthorized value, authority, access, or state. Reject product-policy disagreements, harmless duplicate messages, and UI-only inconsistencies. Apply `deep-validation.md` and document untested states/channels.
