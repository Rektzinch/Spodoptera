---
name: bug-bounty-hunter
description: >
  Advanced bug bounty workflow for authorized, security-mature targets.
  Uses professional security tools for attack-surface mapping while
  prioritizing authorization, state-machine, API differential, trust-boundary,
  and business-logic vulnerabilities.
---

# Bug Bounty Hunter

## Philosophy

Do not assume a mature target is free of vulnerabilities.

Mature targets usually already have:
- WAF
- SAST/DAST
- dependency scanning
- conventional vulnerability scanners
- security monitoring
- previous bug bounty coverage

Therefore:

DO NOT optimize for maximum scanner output.

Optimize for:

1. discovering assumptions
2. identifying trust boundaries
3. comparing equivalent operations
4. finding inconsistent validation
5. understanding state transitions
6. testing authorization boundaries
7. investigating newly introduced attack surface

Professional tools are instruments, not decision makers.

Never report scanner output without manual validation.

---

# HARD SAFETY GATE

Before active testing:

1. Read the official bug bounty policy.
2. Create `engagement/authorization.md`.
3. Build explicit ALLOW-LIST.
4. Build explicit DENY-LIST.
5. Determine allowed test accounts.
6. Determine prohibited techniques.

Never send active requests outside the allow-list.

Immediately STOP when testing could:

- cause DoS/service degradation
- affect another user's data
- create financial loss
- modify production data belonging to others
- trigger credential stuffing
- involve social engineering
- attack third-party infrastructure

---

# TOOL STRATEGY

## Surface Mapping

Preferred:

subfinder
dnsx
httpx
naabu
katana
gau
waybackurls

Purpose:

Map the application.

Do NOT blindly scan every discovered host.

Classify:

AUTH
API
PAYMENT
ADMIN
MERCHANT
CUSTOMER
UPLOAD
CALLBACK
LEGACY
STATIC
INTERNAL-LOOKING
UNKNOWN

---

# HTTP / APPLICATION ANALYSIS

Preferred:

Burp Suite
Caido
mitmproxy
curl
browser automation

Capture legitimate application workflows.

Build:

METHOD
PATH
AUTH REQUIRED
ROLE
INPUT
OBJECT
STATE CHANGE
RESPONSE
DEPENDENCY

Example:

POST /order/create
POST /order/confirm
POST /order/pay
POST /order/cancel

Do not immediately fuzz.

Understand the state machine first.

---

# AUTHORIZATION MATRIX

For every important operation build:

| Actor | Object | Read | Modify | Delete | Execute |
|------|------|------|------|------|------|
| User A | A | ? | ? | ? | ? |
| User A | B | ? | ? | ? | ? |
| User B | B | ? | ? | ? | ? |

Test using researcher-controlled accounts only.

Compare:

anonymous vs authenticated

user A vs user B

customer vs merchant

low privilege vs higher privilege

web vs mobile API

old API vs new API

Never access real third-party user data.

---

# DIFFERENTIAL TESTING

High priority.

Search for operations implemented through multiple paths.

Examples:

WEB
    ↓
POST /api/v2/profile

MOBILE
    ↓
PUT /api/profile

LEGACY
    ↓
POST /v1/user/update

Compare:

authentication
authorization
validation
normalization
rate controls
state requirements
response behavior

Ask:

"Why do these equivalent operations behave differently?"

---

# STATE MACHINE ANALYSIS

Identify workflows containing multiple states.

Example:

CREATED
   ↓
VERIFIED
   ↓
APPROVED
   ↓
COMPLETED

Test safe variations:

skip

repeat

reorder

replay

duplicate

stale state

parallel state

Do NOT perform actions capable of causing financial loss or service
degradation.

---

# BUSINESS LOGIC

Do not fuzz randomly.

First define invariant.

Example:

"A coupon should only be consumed once."

"Object owner must be the only actor allowed to modify the object."

"Verification must occur before operation X."

Then search for paths violating the invariant.

Format:

INVARIANT
EXPECTED
ALTERNATIVE PATH
OBSERVED
IMPACT

---

# TRUST BOUNDARIES

Map:

browser → API

mobile → API

API → internal service

merchant → platform

callback → backend

upload → processor

authentication → application

legacy → current API

Ask:

Which component trusts another component?

What assumption makes that trust safe?

Can that assumption be violated safely?

---

# JAVASCRIPT / CLIENT ANALYSIS

Preferred:

ripgrep
Semgrep
AST tools
source-map tools when permitted

Search for:

API versions
hidden routes
feature flags
deprecated functionality
internal object names
authorization assumptions
GraphQL operations
REST endpoints
WebSocket endpoints

Client-side discoveries are leads, not vulnerabilities.

---

# TARGETED SCANNING

Only after attack surface classification.

Use:

nuclei
dalfox
ffuf

against specific hypotheses.

BAD:

nuclei -u everything

GOOD:

Hypothesis:
legacy merchant endpoint may have inconsistent authorization.

Then select tooling required to investigate that hypothesis.

---

# HYPOTHESIS LOOP

Every investigation follows:

OBSERVATION
    ↓
HYPOTHESIS
    ↓
MINIMAL TEST
    ↓
COMPARE
    ↓
VALIDATE
    ↓
IMPACT

Example:

Observation:
Web and mobile use different API versions.

Hypothesis:
Older API may enforce authorization differently.

Minimal test:
Compare equivalent researcher-owned operations.

Result:
Same → discard hypothesis.
Different → investigate.

---

# NOVELTY PRIORITY

Prioritize:

new endpoints
new products
new integrations
new API versions
recent migrations
legacy compatibility layers
mobile/web discrepancies
new authentication mechanisms
new merchant/customer workflows

Reason:

Security maturity is not uniform across time.

New boundaries frequently contain new assumptions.

---

# FINDING CONFIDENCE

Every candidate must be classified:

CONFIRMED
LIKELY
NEEDS_VALIDATION
FALSE_POSITIVE
NOT_APPLICABLE

Only CONFIRMED findings should reach final report.

---

# STOP RULE

Stop investigating when:

impact requires accessing another person's data

impact requires financial abuse

validation could disrupt production

scope becomes ambiguous

third-party infrastructure becomes involved

Further exploitation is unnecessary once impact is demonstrated.

---

# REPORT

For confirmed findings:

# Title

Severity:
Confidence:
Affected asset:
Endpoint:
Component:

## Summary

## Security invariant

## Preconditions

## Steps to reproduce

## Expected behavior

## Actual behavior

## Evidence

## Security impact

## Root-cause hypothesis

## Remediation

## Scope verification

Do not exaggerate severity.

Do not invent evidence.

Do not automatically submit reports.
