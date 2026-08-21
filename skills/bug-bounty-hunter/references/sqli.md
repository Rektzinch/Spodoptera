# SQL injection testing

Look for parameter-specific type, error, boolean, or timing differentials after establishing a stable baseline. Prefer manual, minimal requests. Use `sqlmap` only when scope, rate limits, endpoint ownership, and an indication are documented; use conservative settings and stop before extraction or destructive actions.

Do not dump databases or enumerate unrelated records. A generic database error, WAF block, or timing fluctuation is not confirmation without a controlled differential and reproducible evidence.

## Qualification gate

Record the parameter location, expected type, endpoint behavior, authentication context, baseline stability, and database-specific evidence. Prefer candidates where a single parameter produces repeatable semantic differences consistent with query construction.

Use paired benign controls and one-variable tests. Repeat timing comparisons enough to distinguish normal variance without becoming load testing. Compare application semantics, error structure, and response consistency; do not rely on one slow response or one database-looking string.

Consider alternate explanations: validation branches, cache variation, rate limiting, WAF challenges, downstream timeouts, and ordinary not-found behavior. Route generic parser evidence back to `injection.md` if the interpreter is uncertain.

## Automation gate

`sqlmap` is optional and never the first step. Before use, document the manual signal, exact endpoint/parameter, allowed rate, safe technique subset, and stop condition. Restrict it to confirming the suspected parameter; disable enumeration, extraction, file, OS, and destructive capabilities.

A confirmed result requires a reproducible database-controlled differential and a clearly described boundary. Preserve minimal redacted requests/responses. If safe proof would require accessing data or causing a side effect, mark `NEEDS-EVIDENCE` and stop.
