# XSS testing

Classify reflected, stored, DOM, template, and postMessage-related candidates. Trace input to an executable sink and identify the output context and encoding. A scanner match is only an observation.

Use harmless marker values and controlled test accounts. Prove execution only in an authorized sandbox or with a non-sensitive marker; do not exfiltrate cookies, tokens, or user data. Check CSP and sanitizer behavior as defense-in-depth, not as the sole finding.

## Source-to-sink model

Record the input source, transformations, storage boundary, rendering component, output context, executable sink, affected actor, and protections. For DOM candidates, trace runtime data flow rather than relying only on string matches.

Use unique inert markers to determine reflection and encoding in HTML text, attribute, URL, script, style, JSON, or template contexts. Change one syntax property at a time only after the context is understood. For stored paths, use an operator-controlled object and viewing account.

Correlate server response, DOM mutation, browser console/runtime behavior, sanitizer output, and CSP. CSP absence is not XSS; CSP presence does not excuse an executable sink.

## Validation

Confirm only the smallest harmless execution marker in an authorized context. Never read or transmit cookies, tokens, DOM data, keystrokes, or another user's content. Record prerequisites and the actor who must view or trigger the content.

Reject simple reflection, safely encoded output, dead code, non-executable sinks, scanner heuristics, or behavior requiring self-modification with no credible victim boundary. Route cross-window messaging issues to the same source/trust-boundary analysis and document origin validation explicitly.
