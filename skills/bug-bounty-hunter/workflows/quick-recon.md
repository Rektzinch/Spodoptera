# Quick recon

1. Confirm authorization and rate limits.
2. Run `bootstrap.sh` and `check-tools.sh`.
3. Enumerate in-scope names with `subfinder`; resolve with `dnsx`; probe with `httpx`.
4. Classify web, API, JavaScript-heavy, and unusual-service hosts.
5. Collect passive URLs with `gau`/`waybackurls`; crawl only selected web hosts with `katana` or `hakrawler`.
6. Write a host/route inventory and route to the smallest next workflow.

Output: `recon/` artifacts, scope decisions, technology notes, and prioritized hypotheses. Do not report vulnerabilities from recon alone.
