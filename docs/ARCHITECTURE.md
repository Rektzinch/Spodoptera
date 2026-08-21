# Architecture

Spodoptera is a progressive-disclosure skill. `SKILL.md` contains the compact control plane. Hermes loads a workflow and references only after an observed attack-surface signal.

## Runtime model

1. `init-engagement.sh` creates authorization, state, evidence, and ledger paths.
2. Recon tools produce timestamped artifacts.
3. Hermes classifies hosts/routes and routes to focused modules.
4. Each module creates hypotheses and selects the least invasive test.
5. The finding ledger records controls, tests, prerequisites, status, evidence, and next actions.
6. `deep-validation.md` promotes, rejects, or parks candidates.
7. Templates turn validated evidence into a report.

## Routing examples

| Signal | Module | Next action |
|---|---|---|
| `/api/v2/graphql` | `graphql.md` | Map operations, types, and authorization. |
| `Authorization: Bearer eyJ...` | `authentication.md` | Analyze token/session lifecycle with a test account. |
| `multipart/form-data` upload | `file-upload.md` | Map storage and retrieval authorization. |
| `wss://` handshake | `websocket.md` | Compare channel/object permissions. |
| URL fetch/import parameter | `ssrf.md` | Use an authorized canary only. |

## Evidence model

Tools are evidence producers, never verdicts. Every candidate has a baseline, one controlled differential, a repeat, a security boundary, and a bounded impact claim. Raw evidence stays local and is redacted before reporting.
