# Attack-Surface Scoring

Load when several plausible next actions compete for limited attention or request budget.

## Goal

Rank the next action by expected information gain and security relevance rather than severity guesses or scanner volume.

## Score dimensions

Score each candidate action from 0-3:

- `novelty`: does it explore a new boundary, service, identity, version, or state?
- `boundary_value`: how important is the trust boundary involved?
- `business_criticality`: does it affect valuable objects or state transitions?
- `complexity_signal`: does the surface involve integrations, legacy paths, queues, multiple parsers, or cross-service policy?
- `evidence_strength`: is there concrete behavior supporting the hypothesis?
- `differential_quality`: is there a clean control or comparison available?
- `change_signal`: is the surface newly deployed, modified, or divergent from a prior snapshot?
- `cost_efficiency`: can the question be answered with few, low-risk requests?

Subtract 0-3 for:

- `operational_risk`;
- `duplication`: already-tested equivalent branch;
- `ambiguity`: poor control or weak interpretability.

Suggested priority:

`priority = novelty + boundary_value + business_criticality + complexity_signal + evidence_strength + differential_quality + change_signal + cost_efficiency - operational_risk - duplication - ambiguity`

Use the number only as a tie-breaker; document why a high score matters.

## Queue format

`id | hypothesis | surface | expected_signal | score | request_cost | stop_condition | next_action`

Re-score after every decision-changing result. New evidence should be able to demote old branches.

## Bias controls

Do not over-prioritize:

- scanner severity alone;
- large endpoint counts;
- visually complex pages without a boundary hypothesis;
- repeated fuzzing on low-signal parameters;
- novelty with no plausible impact path.

Prefer seams where the target model shows policy duplication, state transitions, multiple identities, version drift, integrations, or newly changed components.