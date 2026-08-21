# Authorization, BOLA, and BFLA

Construct a matrix before swapping identifiers:

| Actor | Own object | Other user's object | Privileged function |
|---|---:|---:|---:|
| Anonymous | ? | ? | ? |
| User A | ✓ | ? | ? |
| User B | ? | ✓ | ? |
| Admin/test operator | ✓ | ✓ | ✓ |

Fill cells using synthetic objects and explicit controls. Compare status, body shape, side effects, and downstream state—not just HTTP status. Test direct API, alternate version, method override, mobile/web route, batch endpoint, export, and background-job path only when those paths are observed in scope.

A finding requires proving the expected policy, the actor used, the object/function affected, and the boundary crossed. A different error page or predictable ID alone is not a vulnerability.
