# Business-logic and state-machine testing

Model the legitimate flow, for example:

`CREATE → VERIFY → PAY → FULFILL → REFUND`

For each transition record actor, preconditions, server-side state, client-controlled fields, idempotency key, and side effects. Ask whether a state can be skipped, repeated, reordered, replayed after expiry, or invoked twice concurrently. Check that price, ownership, quantity, status, and entitlement are derived server-side.

Use harmless synthetic transactions or dry-run paths. Never create real charges, refunds, invitations, or irreversible changes without explicit authorization. Report only demonstrated boundary violations and distinguish business-policy disagreement from a security issue.
