# JavaScript and client-side exposure

Search downloaded JavaScript and source maps for route patterns, API base URLs, GraphQL/WebSocket URLs, feature flags, environment configuration, legacy endpoints, internal hostnames, and accidental secrets. Use `ripgrep`, LinkFinder/SecretFinder where available, `gitleaks`, and `trufflehog` for source/history triage.

Treat every match as a lead. Verify whether the route is live, in scope, authenticated, and security-relevant. Never use discovered credentials or tokens; redact them, recommend rotation, and preserve only a hash or short prefix in evidence.
