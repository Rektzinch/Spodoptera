# Authentication and session model

Map registration, login, logout, password reset, OTP, MFA, recovery, OAuth/OIDC, account linking, session refresh, device management, and session revocation. Record states, tokens, cookies, expiry, rotation, audience/issuer, and error differences.

Use test accounts and synthetic addresses. Check whether state transitions enforce the intended actor and whether logout, password change, MFA change, and reset invalidate relevant sessions. Treat enumeration, replay, token confusion, and recovery weaknesses as hypotheses; do not attempt credential stuffing or use secrets from unrelated users.

When a JWT is observed, decode locally without publishing it, document algorithm/issuer/audience/expiry/key-id claims, and test only the authorized lifecycle and validation properties. Use `jwt-tool` only for a justified, low-volume hypothesis. Never forge or submit tokens to access another account.
