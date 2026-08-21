# Cloud and infrastructure exposure methodology

## Contents

1. Prove ownership and scope
2. Build the cloud asset graph
3. Assess exposure classes
4. Assess identity and trust relationships
5. Assess storage, compute, and delivery
6. Assess CI/CD and artifacts
7. Validate without using secrets

## Prove ownership and scope

Cloud names, ASN ranges, provider accounts, buckets, registries, and serverless endpoints may be shared or third-party. Do not expand scope from DNS, certificates, account IDs, tags, or provider naming alone.

For each asset record:

- provider, service, region, account/project/subscription identifier when public;
- hostname/resource name and evidence source;
- owner attribution and authorization reference;
- environment (production, staging, development, unknown);
- exposure (public endpoint, authenticated control plane, private name only);
- data/operation sensitivity;
- confidence and unresolved ownership questions.

Only actively validate assets explicitly covered by the engagement.

## Build the cloud asset graph

Model relationships rather than keeping a flat hostname list:

`DNS/CDN → load balancer/API gateway → compute/serverless → storage/database/queue → CI/CD/artifact registry → identity/KMS/logging`

Record trust edges:

- public caller to data plane;
- workload/service identity to resource;
- CI runner to deployment target;
- event source to function/worker;
- CDN origin to storage/compute;
- cross-account/project role or share;
- signed URL/token issuer to object;
- repository/configuration to cloud resource.

Dynamic route to `api.md`, `cache.md`, `secrets.md`, or `authorization.md` when the exposure becomes an application, caching, credential, or tenant-boundary question.

## Exposure classes

Classify before assigning severity:

| Class | Question | Safe evidence |
|---|---|---|
| Public by design | Is the content/action intended for anonymous users? | public documentation and non-sensitive object |
| Public metadata | Does it reveal names/versions/topology only? | minimal headers/listing without enumeration |
| Misconfigured data plane | Can an unauthorized actor read/write a protected test object? | dedicated synthetic object/control |
| Control-plane exposure | Is management API reachable, and is authentication enforced? | authentication response only; no control action |
| Trust misbinding | Can one tenant/workload act as another? | controlled identities and synthetic resource |
| Secret exposure | Is a credential present in public artifact/source? | fingerprint only; never use it |

Reachability, verbose errors, account IDs, or provider banners alone are observations, not confirmed compromise.

## Identity and trust relationships

Map human identity, workload identity, service account/role, API key, signed request, OAuth/OIDC federation, and temporary credential boundaries. Record issuer, audience, subject, resource, expiry, and where policy is enforced using public configuration or test credentials supplied for the engagement.

Assess:

- whether identity is bound to the expected account/project/tenant;
- whether data-plane resource policies and identity policies agree;
- whether event/webhook sources are authenticated and scoped;
- whether role delegation/cross-account access is intended and least-privileged;
- whether signed URLs/tokens are object-, method-, and expiry-bound;
- whether revocation or permission changes affect cached/queued work.

Never use a discovered credential, assume a role, request a token, or invoke a management action unless the owner separately authorizes that exact validation with dedicated test credentials.

## Storage and data services

For object storage, databases, search, queues, and registries, distinguish public listing, object read, object write, overwrite, delete, and policy management. Validate only with a dedicated synthetic object or publicly intended artifact.

Check:

- public-by-default vs explicit sharing;
- object/prefix/tenant authorization;
- listing vs direct-object behavior;
- signed URL scope and expiry;
- CDN/origin policy alignment;
- version/history and delete-marker exposure;
- backup/snapshot/export exposure;
- cross-origin and cache behavior.

Do not list entire containers, access private records, upload executables, overwrite existing objects, or alter policies.

## Compute, serverless, gateways, and metadata

Map public route, gateway policy, function/container identity, event source, environment/config exposure, and downstream resource access. Treat internal hostnames and metadata references as leads only.

Do not query instance/container metadata services, internal admin endpoints, or private network ranges. For SSRF-style server-side fetches, use `ssrf.md` with an operator-controlled canary and stop before internal access.

Compare observed gateway versions/routes, authentication propagation, method/content-type handling, async execution, and error-source differences. Route parser ambiguity to `request-smuggling.md` only under its isolation gate.

## CDN, DNS, and TLS

Record DNS ownership, dangling-reference evidence, CDN origin, certificate scope, TLS policy, and cache variation. Do not claim takeover from an unresolvable or provider-branded target alone; confirmation requires provider-specific proof that the resource is unclaimed and safely claimable under program rules, without actually claiming it unless authorized.

Route private-content caching or origin-key problems to `cache.md`. Treat certificate/name disclosure as recon unless it exposes an in-scope protected service.

## CI/CD, repositories, and artifacts

Map public workflow files, build logs, packages, release archives, source maps, container/package registries, deployment manifests, and generated artifacts. Search for credentials and internal endpoints using `secrets.md`.

Assess whether artifacts contain logs, debug data, environment configuration, stale endpoints, private source, or deployment metadata. Never run downloaded code, pull private images, use tokens, trigger pipelines, or modify workflows merely to prove exposure.

For supply-chain or build-boundary hypotheses, identify who can modify source, dependencies, artifacts, and deployment references; determine whether the deployed artifact is immutably bound to reviewed source. Keep active build/deployment testing out of scope unless explicitly authorized.

## Logging and evidence hygiene

Cloud responses may contain account IDs, request IDs, internal names, signed URLs, and credentials. Redact secrets and personal data; retain short fingerprints, status, headers, resource type, UTC timestamp, and a minimal body excerpt.

## Validation and exit criteria

Reject candidates explained by intentionally public assets, sample/demo data, expired signed URLs, provider default error pages, shared-service hostnames, stale DNS without claimability, or public metadata without a security boundary.

Confirm only when:

- ownership and scope are established;
- resource, identity, policy, and trust edge are documented;
- a baseline and unauthorized control use synthetic/public-safe data;
- protected data or action crosses a defined boundary;
- no discovered secret or control-plane action was used;
- impact, prerequisites, and remediation are bounded at the correct policy layer.
