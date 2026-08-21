# Deep validation

For each ledger candidate: capture the original observation, write a falsifiable hypothesis, establish a control, change one variable, reproduce independently, redact evidence, determine prerequisites, map the violated boundary, and bound impact. Mark `CONFIRMED`, `REJECTED`, or `NEEDS-EVIDENCE`; never upgrade a finding because a scanner labels it High.

## Validation packet

Create one packet per candidate containing:

- original observation and raw source;
- explicit expected policy and falsifiable hypothesis;
- asset, endpoint, actor, object, state, and prerequisites;
- stable baseline and negative/positive controls where safe;
- one-variable test request and timestamped response;
- independent reproduction instructions and result;
- alternative explanations considered;
- violated boundary, bounded impact, confidence, and status.

## Reproduction sequence

1. Re-establish the baseline with a fresh synthetic object/session when relevant.
2. Run the control and candidate under equivalent conditions.
3. Confirm the meaningful semantic difference, not status/length alone.
4. Repeat once independently without expanding scope or impact.
5. Verify cleanup, revocation, or return to a safe state.

Account for cache, eventual consistency, queue timing, rate limiting, WAF behavior, localization, and unstable upstreams. Add the relevant reference module when one of these could explain the result.

## Decision gate

Use `CONFIRMED` only when evidence establishes reproducibility, prerequisites, attacker control, a security boundary crossed, and bounded impact. Use `REJECTED` when controls or an alternative explanation falsify the claim. Use `NEEDS-EVIDENCE` when safe testing cannot resolve a material gap.

Severity follows demonstrated impact and required conditions, not scanner metadata or theoretical maximums. Redact authentication material and personal data while retaining enough structure for the program to reproduce the issue.
