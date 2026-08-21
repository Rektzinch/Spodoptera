# General injection and parser boundaries

Classify the interpreter or parser first: shell, template, LDAP, XPath, XML, JSON, command, expression, or header. Use inert markers and one variable at a time. Compare parser errors, normalization, type coercion, and output context.

Do not execute commands, read files, send mail, or invoke external systems merely to prove a hypothesis. Demonstrate the smallest safe boundary crossing in a test environment or mark the result `NEEDS-EVIDENCE`.
