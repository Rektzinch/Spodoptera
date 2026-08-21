# Finding Correlation and Deduplication

Load when multiple observations or candidates may share one root cause.

## Goal

Report security boundaries and root causes, not scanner alert counts. Correlate evidence before opening separate findings.

## Correlation keys

Compare candidates by:

- same object or backing resource;
- same authorization policy or role check;
- same state transition/invariant;
- same gateway/backend discrepancy;
- same parser/normalization behavior;
- same cache-key omission;
- same identity/session lifecycle defect;
- same deployment/configuration source;
- same legacy/new-version drift;
- same vulnerable component with different entry points.

## Root-cause record

`cluster_id | candidates | shared_boundary | shared_root_cause | distinct_impact | evidence_overlap | disposition`

Disposition values:

- `MERGE`: one root cause and materially same impact;
- `PARENT_CHILD`: one root cause with meaningful secondary manifestations;
- `SEPARATE`: different security assumptions or remediation;
- `UNCERTAIN`: insufficient evidence.

## Rules

1. Do not merge solely because endpoints look similar.
2. Merge when one remediation would reasonably fix all manifestations and the violated boundary is the same.
3. Keep findings separate when impacts, affected principals, trust boundaries, or remediation differ materially.
4. Preserve every reproduction path as evidence even when reports are merged.
5. Prefer the simplest explanation that accounts for all observed behavior.
6. Link clusters back to `target-model.md` so repeated boundary failures increase priority elsewhere in the same policy domain.

## Example patterns

- multiple IDOR endpoints backed by one missing tenant check → likely one root cause cluster;
- v1 and v2 authorization drift with different policy implementations → may remain separate;
- several cache leaks caused by one missing identity dimension in the cache key → merge if impact is equivalent;
- multiple token symptoms caused by one revocation lifecycle defect → parent/child or merge depending on impact.

## Reporting

A merged report should enumerate affected paths, explain the shared root cause, show representative reproductions, and avoid inflating severity by counting duplicate manifestations.