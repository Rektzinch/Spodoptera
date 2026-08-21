# Controlled concurrency

Use only explicitly authorized, bounded concurrency against synthetic operations such as redeem, coupon, invitation, claim, idempotent resource creation, or a test balance/state transition. Start with one request, then a small fixed burst within the stated limit; stop immediately if latency, errors, or side effects increase.

Compare serial and concurrent results, idempotency keys, final state, and duplicate side effects. Never conduct load testing, resource exhaustion, or high-rate replay. Confirm a race only when the concurrency changes a security-relevant invariant and the result is reproducible.
