# Tool routing

| Capability | Preferred tools | Use when |
|---|---|---|
| Subdomain/DNS/HTTP | `subfinder`, `dnsx`, `httpx`, `asnmap` | Asset discovery is authorized. |
| Services | `naabu`, narrow `nmap` | An unusual service needs confirmation. |
| Crawl/history | `katana`, `gau`, `waybackurls`, `hakrawler` | A web host is selected for mapping. |
| Content/parameters | `ffuf`, `feroxbuster`, `arjun` | A narrow path or parameter hypothesis exists. |
| Detection | `nuclei`, `dalfox` | A technology/surface-specific check is justified. |
| Source/secrets triage | `rg`, LinkFinder, SecretFinder, `gitleaks`, `trufflehog` | Code or bundles are in scope. |
| Request analysis | `curl`, `httpie`, `jq`, `unfurl`, `anew` | A raw request/response needs inspection. |
| Specialized | `jwt-tool`, `sqlmap`, `testssl.sh` | A documented hypothesis and safe constraints exist. |

Tool output must be correlated with raw evidence and controls. Never run the complete list blindly, and never treat a template severity as confirmation.

## Selection gate

Before invoking a tool, record:

- the hypothesis or coverage question it answers;
- the smallest asset/input set required;
- the artifact and comparison it should produce;
- the request/rate risk and program constraints;
- the stop condition and next route for either outcome.

Prefer the tool that answers the question with the least traffic and ambiguity. Additional tools are justified only when they provide an independent source, a control, or a materially different view of the boundary.
