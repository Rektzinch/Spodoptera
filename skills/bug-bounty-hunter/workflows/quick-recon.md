# Quick recon

Use this workflow to convert a broad authorized scope into a small set of evidence-backed next actions. The goal is not maximum enumeration.

## 1. Frame the questions

Confirm authorization, exclusions, rate limits, and test window. Write three to five questions such as:

- Which hosts represent identity, API, administration, files, or integrations?
- Where do versions, legacy routes, or service boundaries appear?
- Which assets combine valuable objects with distinct enforcement layers?

Run `bootstrap.sh` and `check-tools.sh`. Missing tools change the collection method, not the truth of the result.

## 2. Build the minimum live asset set

Use `subfinder` only for approved namespaces, resolve with `dnsx`, and probe resolved names with `httpx`. Deduplicate between stages and preserve aliases, redirects, content types, titles, and stable fingerprints.

Handle wildcard DNS before prioritization. Do not infer scope from ASN, DNS ownership, redirect destinations, or third-party hosting.

## 3. Classify and score

For each live host record function, lifecycle/version, identity mechanism, technology/edge hints, likely data plane, confidence, and boundary intersections. Prioritize using:

`expected information gain × boundary relevance × evidence strength ÷ request cost/risk`

Exact arithmetic is unnecessary; use High/Medium/Low consistently. A versioned API behind an identity gateway or a personalized route behind a CDN normally outranks another generic marketing host.

## 4. Expand only selected branches

- collect `gau`/`waybackurls` evidence to detect route families and legacy surfaces;
- crawl selected web or JavaScript-heavy hosts with `katana` or `hakrawler`;
- inspect unusual services with narrow `naabu`/`nmap` only when the result changes routing;
- use focused `ffuf`, `feroxbuster`, or `arjun` inputs only when observed naming or framework evidence supports them.

For each action record its question and stop condition. Stop a branch when results are duplicates or no longer alter the system model.

## 5. Route the result

Create a short prioritized queue:

`asset | observation | boundary | hypothesis seed | module/workflow | why now | stop condition`

Route API, GraphQL, identity, upload, WebSocket, cache, JavaScript, cloud, or parser signals using `SKILL.md`. Choose the smallest workflow that can confirm or reject the next hypothesis.

## Output and exit criteria

Output `recon/` artifacts, `recon-decisions.md`, a classified host/route inventory, architecture notes, trust boundaries, and prioritized hypothesis seeds. Quick recon ends when the top surfaces have justified next actions and remaining branches are explicitly deferred for low expected signal.

Do not report vulnerabilities from recon alone.
