# Authentication hunt

Map login, registration, reset, OTP/MFA, OAuth/OIDC, sessions, refresh, logout, recovery, and account linking with test accounts. Compare state transitions, token rotation, expiry, audience/issuer, revocation, enumeration signals, and authorization after identity changes. Do not brute force or use real-user credentials. Validate only safe, reproducible boundaries.

## 1. Build the identity lifecycle

Using only operator-controlled accounts, map `UNREGISTERED → REGISTERED → VERIFIED → AUTHENTICATED → RECOVERY/STEP-UP → REVOKED`. Add linking, email/phone change, role/tenant change, device/session management, and deletion where present.

Record the actor, proof required, token/session issued, state changed, notification sent, and rollback/recovery path for each transition.

## 2. Inventory trust artifacts

Document cookies, bearer/refresh tokens, OAuth state/nonce/PKCE, issuer, audience, expiry, rotation, binding, storage, and revocation behavior. Decode JWT structure only when relevant; do not forge, guess, or use unrelated tokens.

## 3. Generate targeted hypotheses

Prioritize transition mismatches: recovery bypassing MFA, account linking changing identity without equivalent proof, stale sessions surviving security changes, refresh behavior crossing client/tenant boundaries, or inconsistent enforcement between UI and API versions.

Define baseline, one-variable comparison, control, expected state, actual state, and stop condition. Enumeration observations require a realistic security consequence beyond cosmetic response differences.

## 4. Validate and correlate

After identity changes, route object/function access checks to `authorization.md`. Compare pre-change and post-change sessions with synthetic objects. Correlate email/notification evidence, token timestamps, server responses, and account state.

Stop before brute force, credential stuffing, OTP exhaustion, inbox abuse, real-user interaction, or account lockout. Run `deep-validation.md` for candidates and report prerequisites plus the exact identity boundary crossed.
