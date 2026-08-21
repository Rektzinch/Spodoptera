# General injection and parser boundaries

Classify the interpreter or parser first: shell, template, LDAP, XPath, XML, JSON, command, expression, or header. Use inert markers and one variable at a time. Compare parser errors, normalization, type coercion, and output context.

Do not execute commands, read files, send mail, or invoke external systems merely to prove a hypothesis. Demonstrate the smallest safe boundary crossing in a test environment or mark the result `NEEDS-EVIDENCE`.

## Evidence-led routing

Start from an observed interpreter signal: a structured parser error, template transformation, type-dependent query result, documented expression feature, or consistent output/timing differential. Identify the likely data flow and the security property expected to contain user input.

Define a stable baseline, an inert marker, a syntactically invalid control where safe, and an alternate benign value. Change one field at a time. Compare semantic behavior, not only status, length, or latency.

Route database-specific evidence to `sqli.md`, executable browser sinks to `xss.md`, server-side fetch behavior to `ssrf.md`, and intermediary disagreements to `request-smuggling.md` or `bypass-techniques.md`.

Reject candidates explained by validation errors, reflection without interpretation, generic WAF responses, unstable timing, or ordinary serialization. Specialized automation is justified only after a repeatable interpreter-specific signal exists and its request budget is documented.

Stop before command execution, file access, data extraction, external side effects, or access to unrelated objects. If a harmless proof cannot establish the boundary, preserve the evidence and use `NEEDS-EVIDENCE`.
