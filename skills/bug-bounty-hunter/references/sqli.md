# SQL injection testing

Look for parameter-specific type, error, boolean, or timing differentials after establishing a stable baseline. Prefer manual, minimal requests. Use `sqlmap` only when scope, rate limits, endpoint ownership, and an indication are documented; use conservative settings and stop before extraction or destructive actions.

Do not dump databases or enumerate unrelated records. A generic database error, WAF block, or timing fluctuation is not confirmation without a controlled differential and reproducible evidence.
