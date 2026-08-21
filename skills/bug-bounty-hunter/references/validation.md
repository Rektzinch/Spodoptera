# Validation and evidence discipline

## Status model

| Status | Meaning | Minimum evidence |
|---|---|---|
| OBSERVATION | A tool or request produced an interesting signal. | Raw output and timestamp. |
| HYPOTHESIS | A specific security property may be violated. | Baseline plus falsifiable statement. |
| CANDIDATE | A controlled test differs from the expected control. | Redacted request/response pair and comparison. |
| REPRODUCED | An independent repeat obtains the same behavior. | Repeatable steps and second capture. |
| CONFIRMED | A security boundary is crossed with meaningful impact. | Reproduction, control, prerequisite, boundary, impact. |
| NEEDS-EVIDENCE | Plausible but blocked by missing authorization, control, or impact evidence. | Gap and safe next step. |
| REJECTED | The control or expected behavior explains the signal. | Falsifying evidence. |

## Validation loop

1. Preserve the original observation without editing it.
2. Form one narrow hypothesis: actor, object, action, expected policy, actual behavior.
3. Establish a baseline/control using the same method, headers, and test account.
4. Change one variable: identity, object, method, content type, encoding, state, or timing.
5. Repeat once independently at low rate. Do not escalate to destructive impact.
6. Record prerequisites and whether the result crosses confidentiality, integrity, or availability boundaries.
7. Reject false positives from redirects, cached responses, UI-only checks, test fixtures, authorization failures, or scanner parsing errors.

## Evidence hygiene

- Redact cookies, bearer tokens, API keys, OTPs, passwords, email/phone numbers, and personal data.
- Keep status codes, relevant headers, response hashes, and minimal body excerpts.
- Use synthetic objects and test accounts; never dump unrelated records.
- Record UTC timestamp, tool version, command, target, and scope decision.
- Never claim a blind SSRF, account takeover, data access, or code execution without direct evidence.

## Severity reasoning

Describe affected asset, attacker prerequisite, boundary crossed, impact, and reproducibility. Use CVSS/CWE as supporting classifications, not as substitutes for evidence. State when severity is provisional or program-dependent.
