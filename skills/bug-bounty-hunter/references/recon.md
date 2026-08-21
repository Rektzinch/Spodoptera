# Recon pipeline

Use passive sources first, deduplicate every output, and keep active requests in scope and below the engagement rate limit.

## Pipeline

`subfinder → dnsx → httpx → classify → route`

- `subfinder`: enumerate program-approved subdomains.
- `dnsx`: resolve and retain only relevant records; note wildcard DNS.
- `httpx`: record status, title, technology hints, redirects, TLS, and content type.
- `asnmap`: use only when ASN ownership is explicitly in scope; do not expand scope from ASN results alone.
- `naabu`/`nmap`: narrow service confirmation on approved hosts, with conservative ports and timing.
- `katana`, `gau`, `waybackurls`, `hakrawler`: collect routes and parameters; mark historical URLs as hypotheses until live behavior is confirmed.
- `ffuf`, `feroxbuster`, `arjun`: use targeted, low-rate wordlists and narrow path/parameter hypotheses.

## Artifacts

Store `subdomains.txt`, `resolved.jsonl`, `http.jsonl`, `urls.txt`, `services.txt`, and a route inventory with source, first-seen time, status, content type, auth requirement, and confidence. Do not treat a 200 response as proof of sensitive access.

## Routing signals

`/api`, JSON, OpenAPI, Swagger, GraphQL, WebSocket, upload, OAuth, JWT, admin, staging, debug, source map, and cloud-provider hostnames each route to a focused module. Read `web-mapping.md` before active crawling.
