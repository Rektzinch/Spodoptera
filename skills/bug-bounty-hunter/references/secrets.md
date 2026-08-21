# Secrets and repository exposure

Triage public source, bundles, archives, logs, debug artifacts, source maps, and repository history with `gitleaks`/`trufflehog` where authorized. Classify secret type, validity, scope, and exposure without using it.

Redact values immediately, preserve a fingerprint, notify the owner through the approved channel, and recommend revocation/rotation. Never authenticate with a discovered secret or retrieve unrelated data to prove validity.

## Triage model

For each candidate record source, artifact visibility, secret class, apparent environment, likely privilege, age/version, confidence, and owner notification requirement. Distinguish public identifiers and client configuration from authentication material.

Correlate the format with official documentation, adjacent configuration, commit/build time, and non-authenticating metadata. Do not call protected APIs, log in, sign requests, enumerate permissions, or test access with the value.

Use a one-way fingerprint or short redacted prefix/suffix in the evidence. Restrict raw-value handling to the approved disclosure channel and do not place it in shared logs, shell history, reports, or screenshots.

## Status and impact

- `OBSERVATION`: credential-like pattern without semantic context.
- `CANDIDATE`: context indicates an authentication or signing role.
- `CONFIRMED`: exposure and secret function are established without use, or the program owner validates it.

Bound impact by the evidenced role and exposure, not imagined maximum permissions. Recommend revocation/rotation, history cleanup where applicable, downstream audit, and prevention controls. Escalate promptly under the program rules when the material appears live or highly privileged.
