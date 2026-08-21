# Tool Capability Registry

Load when selecting a tool. Choose tools by expected signal, not availability.

## Registry fields

For every tool, reason with:

`tool | capability | active/passive | prerequisites | expected_signal | request_cost | operational_risk | output | avoid_when`

## Core registry

| Tool | Capability | Mode | Use when | Cost | Avoid when |
| --- | --- | --- | --- | --- | --- |
| `subfinder` | subdomain discovery | mostly passive | scope permits asset discovery | low | target is path-only scoped |
| `dnsx` | DNS resolution/enrichment | active DNS | candidate hosts need validation | low | DNS probing is excluded |
| `httpx` | HTTP probing/fingerprinting | active | known hosts need HTTP classification | low-medium | broad probing exceeds limits |
| `asnmap` | ASN/network context | passive/lookup | network ownership helps scope modeling | low | ASN expansion is out of scope |
| `naabu` | port discovery | active | service exposure is a recorded question | medium | web-only scope or tight rate limits |
| `nmap` | service confirmation | active | narrow host/port validation is justified | medium | broad network scanning is unnecessary |
| `katana` | crawler | active | application routes/client links need mapping | medium | crawl cannot change the model |
| `gau` | historical URLs | passive/remote | legacy routes matter | low | no domain-level scope |
| `waybackurls` | historical URLs | passive/remote | old paths/versions may reveal drift | low | historical data is irrelevant |
| `hakrawler` | crawler | active | lightweight route discovery is useful | medium | duplicates existing crawl coverage |
| `ffuf` | focused content discovery | active | narrow wordlist/path hypothesis exists | medium-high | blind directory spraying |
| `feroxbuster` | recursive content discovery | active | bounded content tree needs mapping | high | mature target with no path hypothesis |
| `arjun` | parameter discovery | active | endpoint behavior suggests hidden parameters | medium | endpoint has no parameter hypothesis |
| `nuclei` | template detection | active | technology-specific candidate checks | variable | used as blanket verdict engine |
| `dalfox` | XSS-oriented testing | active | reflected/DOM evidence justifies it | variable | no XSS signal exists |
| `gitleaks` | secret/source triage | local | in-scope source/artifacts are available | low | scanning unrelated repositories |
| `trufflehog` | secret/source triage | local/remote | scoped repositories/artifacts justify it | variable | unrelated public history |
| `curl` | raw HTTP control | active | precise reproducible request needed | low | never; prefer it for minimal tests |
| `httpie` | HTTP inspection | active | readable manual comparison helps | low | automation requires exact raw fidelity |
| `jq` | JSON analysis | local | normalize/compare API evidence | none | not applicable |
| `ripgrep` | source/text analysis | local | scoped bundles/source/artifacts exist | none | not applicable |
| `unfurl` | URL decomposition | local | normalize endpoint inventories | none | not applicable |
| `anew` | deduplication | local | incremental inventories need delta tracking | none | not applicable |
| `jwt-tool` | JWT analysis | local/active | a justified token-validation hypothesis exists | low-variable | blind mutation against unrelated accounts |
| `sqlmap` | SQLi validation | active | a parameter-specific SQL differential exists | high | generic first-line fuzzing |
| `testssl.sh` | TLS analysis | active | transport/TLS posture is relevant to scope | medium | app-layer hypothesis has higher value |

## Selection rule

Choose the least expensive tool that can falsify or strengthen the current hypothesis. Prefer local normalization and manual raw HTTP controls before broad active automation.

## Escalation rule

Escalate from passive → low-cost active → focused specialized tooling only when earlier evidence justifies it. Record the reason for escalation and a stop condition.