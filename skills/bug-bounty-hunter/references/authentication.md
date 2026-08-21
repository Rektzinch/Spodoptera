# Authentication, recovery, and session methodology

## Build the identity model

Map registration, verification, login, logout, password reset, OTP, MFA, recovery, OAuth/OIDC, account linking, session refresh, device management, and revocation. Create:

- `auth-states.tsv`: state, actor, entry condition, credential/token, expiry, allowed exits.
- `auth-tokens.tsv`: artifact, issuer, audience, subject, scope, storage, rotation, revocation.
- `auth-flows.tsv`: flow, step, input, server-side binding, side effect, error class.
- `auth-hypotheses.tsv`: property, baseline, differential, oracle, stop condition, status.

Use synthetic identities and addresses supplied for testing. Never attempt credential stuffing, password spraying, OTP brute force, or use credentials/secrets from unrelated users.

## Enrollment and verification

Determine which identifier is being proven, how challenges bind to account/session/device/purpose, expiry, retry limits, and whether completing one flow grants authority in another. Compare valid, expired, already-used, wrong-purpose, and wrong-controlled-account artifacts at low volume.

An account-existence difference is not automatically reportable. Establish whether it materially enables a realistic attack under program policy and whether normalization, rate controls, and generic responses are consistent.

## Login and session lifecycle

Record cookie/token attributes, privilege/tenant context, renewal, idle/absolute expiry, concurrent sessions, remember-me behavior, device recognition, and logout semantics. Verify final server-side session state rather than UI redirect.

Check whether password, MFA, email/phone, role, tenant, or recovery changes invalidate the sessions/tokens that policy says they should. Use only controlled sessions; do not hijack or replay real-user sessions.

## Reset, recovery, and MFA

Model the flow as a state machine. For each transition identify actor, account binding, channel, challenge purpose, attempt counter, expiry, final credential change, and session invalidation. Test one controlled variable at a time and stop before lockout or service impact.

For MFA, separate enrollment, challenge, recovery codes, trusted device, step-up, disable/reset, and fallback support paths. A weaker fallback is relevant only if it bypasses an intended assurance boundary.

## JWT and bearer tokens

Decode locally and redact values. Record algorithm, issuer, audience, subject, expiry/not-before, key ID, token type, scopes/roles, and tenant context. Confirm that the service validates the expected token class and lifecycle.

Use `jwt-tool` only for a documented, low-volume hypothesis with dedicated test tokens. Local decoding is permitted. A mutation of a token issued to the same controlled account is permitted only when it is non-destructive, stays within the authorized test account, has a stated validation oracle, and cannot create access to another account, tenant, role, or resource. Do not try unrelated keys, production signing material, or token forgery for privilege escalation. Treat decodeable claims, `alg` choice, or missing cosmetic fields as observations until validation behavior and impact are shown.

## OAuth/OIDC and account linking

Map client, redirect URI, response mode, state/nonce/PKCE, issuer, audience, subject mapping, consent, callback session, and linking/unlinking rules. Use test clients/accounts already provided by the program. Do not register attacker infrastructure or intercept third-party accounts without explicit authorization.

Focus on identity misbinding: one provider identity linked to the wrong local account, callback state bound to the wrong browser/session, or issuer/audience accepted outside the intended client. Confirm final controlled account identity.

## Validation

Reject candidates explained by expired test artifacts, expected concurrent sessions, UI-only logout, documented public enumeration, test-email latency, or client-side state.

Confirm only with an authenticated/unauthenticated baseline, one controlled differential, final server-side identity/session state, violated assurance boundary, prerequisites, and bounded impact. Route object/function access after identity changes to `authorization.md` and state/replay behavior to `business-logic.md` or `race-conditions.md`.
