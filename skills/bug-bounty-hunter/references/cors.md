# CORS

Compare preflight and actual responses for trusted, untrusted, null, absent, and credentialed origins using harmless requests. Record `Access-Control-Allow-Origin`, credentials, methods, headers, Vary behavior, and whether sensitive authenticated data is exposed.

An origin reflection without credentials or sensitive readable data may be informational. Confirm browser-readable impact with a test account and synthetic data; do not target another user's account.

## Model the browser boundary

Record the requesting origin, target origin, credential mode, authentication mechanism, endpoint sensitivity, preflight requirement, and whether the browser can read the response. Separate “request can be sent” from “response can be read.”

Build a small matrix across trusted, unrelated, sibling, `null`, and absent origins. Change only the origin/credential condition and compare allow-origin, allow-credentials, allowed headers/methods, redirects, and `Vary: Origin`.

Prioritize endpoints returning account, tenant, token, or administrative data. Add `cache.md` when origin-dependent headers or bodies may be cached. Add `authentication.md` when cookies, bearer tokens, or session lifecycle materially affect exploitability.

## Validation

Use a controlled browser proof with the operator's test account and synthetic data only when raw header evidence supports a hypothesis. Confirm that the response is readable from the untrusted origin under realistic credential behavior.

Reject or downgrade cases limited to public data, non-credentialed wildcard access, blocked browser reads, failed preflight, or harmless metadata. Document browser assumptions and any inference.
