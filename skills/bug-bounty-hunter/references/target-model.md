# Adaptive Target Model

Load this reference when the engagement has enough observations to connect assets, identities, objects, services, or workflows.

## Purpose

Maintain one evolving model of the target instead of treating endpoints as isolated findings. The model should explain how an external actor reaches a service, which identity is accepted, which object or state is affected, and which trust boundary is crossed.

## Core entities

Track these entity classes:

- `asset`: domain, host, application, mobile backend, admin surface;
- `service`: gateway, auth service, API, worker, storage, queue, CDN, third-party integration;
- `endpoint`: method + route + version + content type;
- `identity`: anonymous, user, staff, partner, service account, device;
- `role`: normal, privileged, organization-scoped, tenant-scoped;
- `object`: account, order, file, message, payment intent, report, token, configuration;
- `state`: lifecycle state relevant to business logic;
- `boundary`: authentication, authorization, tenancy, service-to-service, cache, storage, parser, integration;
- `evidence`: request/response, source reference, observed behavior, control;
- `hypothesis`: security assumption that may be false.

## Relationship grammar

Represent important edges explicitly:

`asset → exposes → service`

`service → serves → endpoint`

`identity → holds → role`

`endpoint → reads/writes → object`

`object → belongs_to → identity/tenant`

`endpoint → transitions → state`

`service → trusts → service/integration`

`request → crosses → boundary`

`hypothesis → concerns → boundary/object/state`

## Minimal record

For each modeled node or edge record:

`id | type | name | source | confidence | first_seen | last_seen | notes`

For each relation:

`from | relation | to | evidence | confidence`

## Modeling rules

1. Add only relationships supported by evidence or clearly mark them as inferred.
2. Promote repeated observations into stable architecture facts.
3. Link every active hypothesis to at least one boundary or invariant.
4. When two endpoints operate on the same object or state, compare their enforcement model.
5. When two services implement the same policy, look for drift in gateway vs backend, v1 vs v2, web vs mobile, and synchronous vs queued paths.
6. Prefer graph updates that materially change testing priority.

## High-value graph patterns

Prioritize hypotheses when the model shows:

- one object reachable through multiple services or API versions;
- one role interpreted differently by multiple services;
- a privileged state transition exposed through both UI and direct API;
- cached personalized data with weak identity-key separation;
- a queue/worker performing actions that the front door validates more strictly;
- old and new endpoints touching the same backing object;
- multiple identity systems converging on one resource;
- third-party integrations crossing an internal trust boundary.

## Output

Persist the current model under the engagement directory, e.g. `state/target-model.md` or a machine-readable equivalent. Summaries should emphasize relationships and unresolved boundaries, not raw endpoint counts.