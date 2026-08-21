# Self-Evaluation

Load near the end of a hunt, before reporting, or when progress stalls.

## Goal

Evaluate the quality of reasoning and coverage, not just the number of findings.

## Review questions

### Coverage

- Which important assets, identities, object classes, state transitions, integrations, or trust boundaries remain unmodeled?
- Which areas were intentionally skipped because expected information gain was low?
- Which exclusions came from scope rather than prioritization?

### Reasoning quality

- Did each active branch begin with a falsifiable hypothesis?
- Were controls stable and one-variable differentials used where possible?
- Did any scanner output influence severity before independent validation?
- Were low-signal branches stopped early enough?
- Did the target model change after each major recon/testing phase?

### Evidence quality

- Can each confirmed finding be reproduced from preserved evidence?
- Are prerequisites explicit?
- Is the violated security boundary identified?
- Is demonstrated impact separated from inferred impact?
- Are duplicate manifestations clustered by root cause?

### Efficiency

- Which actions consumed the most requests/time without changing a decision?
- Which tool could have been replaced by a smaller, more precise action?
- Were changed/new surfaces prioritized over unchanged broad coverage where snapshots existed?

## Final scoring

Rate 0-3:

`model_completeness | hypothesis_quality | differential_quality | evidence_quality | correlation_quality | efficiency | uncertainty_honesty`

Low scores should create explicit follow-up actions, not cosmetic prose.

## Required closing output

Before marking an engagement complete, record:

1. strongest confirmed finding or strongest evidence-backed conclusion;
2. top unresolved boundary;
3. top three next-best actions by expected information gain;
4. meaningful coverage gaps;
5. branches intentionally abandoned and why;
6. whether another cycle is likely to produce materially new information.

Completion is justified when additional work is unlikely to change the target model or finding set enough to warrant the cost and risk.