# Checkpoint and Resume

Load when pausing, resuming, handing off, or recovering an engagement.

## Goal

Resume from the current model instead of repeating reconnaissance. A checkpoint must preserve what is known, what was rejected, what remains uncertain, and what should happen next.

## Checkpoint contents

Persist:

- current state in the engagement state machine;
- target/scope fingerprint and authorization timestamp;
- target-model summary and unresolved boundaries;
- endpoint/asset inventories with snapshot timestamps;
- finding ledger including rejected and needs-evidence items;
- active hypothesis queue with scores;
- consumed/remaining request and concurrency budget where tracked;
- recent commands/tool versions relevant to reproducibility;
- evidence index and redaction status;
- last decision-changing result;
- top next-best actions with stop conditions;
- known dead ends so they are not repeated.

## Suggested layout

```text
engagement/
├── authorization.md
├── state/
│   ├── checkpoint.md
│   ├── target-model.md
│   ├── hypotheses.md
│   └── snapshots/
├── evidence/
└── reports/
```

## Resume procedure

1. Re-read authorization and confirm it is still current.
2. Load the latest checkpoint before any recon.
3. Verify only volatile assumptions that could have changed.
4. Re-score active hypotheses if new time/change context exists.
5. Continue from the top next-best action rather than rebuilding inventories.
6. Create a new checkpoint after a state transition, major discovery, or before stopping.

## Checkpoint quality test

A fresh agent should be able to answer in under a minute:

- What is this target?
- What are the important boundaries?
- What has already been tested?
- Which hypotheses were rejected and why?
- What evidence is strongest?
- What are the three highest-value next actions?

If not, the checkpoint is incomplete.