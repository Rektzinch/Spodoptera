<div align="center">

# SPODOPTERA

### Signal-driven bug bounty orchestration for Hermes Agent

**Understand the system. Find the assumption. Validate the boundary.**

[![Hermes Agent](https://img.shields.io/badge/Hermes-Agent-111111?style=flat-square)](https://github.com/NousResearch/hermes-agent)
![Focus](https://img.shields.io/badge/Focus-Web%20%26%20API-111111?style=flat-square)
![Method](https://img.shields.io/badge/Method-Signal%20over%20Volume-111111?style=flat-square)
![Status](https://img.shields.io/badge/Status-Active-111111?style=flat-square)

</div>

---

## What is Spodoptera?

Spodoptera is a security-research orchestration skill built for **Hermes Agent**. It turns an LLM agent into a structured bug-bounty research workflow by providing a control plane for reconnaissance, attack-surface modeling, technology-aware routing, hypothesis generation, targeted testing, evidence correlation, validation, and reporting.

Spodoptera is **not another vulnerability scanner**. Existing tools remain specialized sensors. Hermes/Muse remains the reasoning engine. Spodoptera connects both through a repeatable methodology designed to answer one question continuously:

> **What is the highest-value thing to learn or test next?**

The project is optimized for official bug-bounty programs operated by organizations with mature security programs. Strong defenses remove much of the obvious noise, but complexity still creates seams: assumptions between services, authorization drift, legacy behavior, API-version differences, state-machine mistakes, identity lifecycle edge cases, parser disagreements, integrations, and changes that no individual component fully understands.

## Philosophy: signal over volume

More reconnaissance does not automatically produce better reconnaissance.

Spodoptera optimizes for **information gained per action**. A small number of deliberate requests backed by an accurate system model can be more useful than thousands of undirected requests or a wall of scanner output.

```text
OBSERVE
   ↓
UNDERSTAND ARCHITECTURE
   ↓
IDENTIFY TRUST BOUNDARIES
   ↓
FIND ASSUMPTIONS / INCONSISTENCIES
   ↓
FORM A HYPOTHESIS
   ↓
CHOOSE THE MINIMUM EFFECTIVE TEST
   ↓
COMPARE BEHAVIOR
   ↓
CORRELATE EVIDENCE
   ↓
VALIDATE IMPACT
```

A tool is selected because it answers a question or closes a meaningful coverage gap—not merely because it is installed. Low-yield branches are stopped or deprioritized as soon as they stop changing the model of the target.

## How it works

The engagement is modeled as a state machine rather than a sequence of scanners:

```text
SCOPE
  → RECON
  → ATTACK SURFACE MAP
  → TECHNOLOGY ANALYSIS
  → ENDPOINT INVENTORY
  → AUTH MODEL
  → AUTHORIZATION MODEL
  → HYPOTHESES
  → TARGETED TESTING
  → CORRELATION
  → ALTERNATIVE PATHS
  → REPRODUCTION
  → IMPACT
  → REPORT
```

Scanner output starts as an **observation**, not a vulnerability. Findings move through an evidence lifecycle:

```text
OBSERVATION → HYPOTHESIS → CANDIDATE → REPRODUCED → CONFIRMED
                         ↘ REJECTED
                         ↘ NEEDS-EVIDENCE
```

Confirmation requires reproducibility, a meaningful control comparison, understood prerequisites, an identifiable security boundary, and an impact statement supported by the evidence.

## High-value surfaces

Spodoptera deliberately emphasizes areas where mature applications can still develop inconsistencies:

| Surface | Research focus |
| --- | --- |
| Authorization | BOLA/IDOR, BFLA, role/object drift, cross-service enforcement |
| Business logic | State transitions, workflow assumptions, duplicate effects, invariant failures |
| Identity | Registration, recovery, MFA, OAuth/OIDC, sessions, token lifecycle |
| APIs | Undocumented/versioned routes, gateway/service differences, object/function boundaries |
| Integrations | Trust assumptions between services, webhooks, imports, third-party boundaries |
| Concurrency | Idempotency, retry semantics, atomicity and controlled race hypotheses |
| Parsing | Encoding, normalization, content-type, proxy/backend interpretation differences |
| Legacy surfaces | Old routes, historical assets, source maps, forgotten versions and migrations |
| Client surface | JavaScript routes, configuration, GraphQL/WebSocket discovery and source analysis |
| Cloud & delivery | Exposed artifacts, configuration boundaries, cache behavior and deployment seams |

## Tool orchestration

Spodoptera can route work to established security tooling when the current hypothesis justifies it.

| Capability | Tooling |
| --- | --- |
| Asset discovery | `subfinder` · `dnsx` · `httpx` · `asnmap` |
| Services | `naabu` · `nmap` |
| Crawling & history | `katana` · `gau` · `waybackurls` · `hakrawler` |
| Content & parameters | `ffuf` · `feroxbuster` · `arjun` |
| Detection | `nuclei` · `dalfox` |
| Source & secret triage | `ripgrep` · LinkFinder · SecretFinder · `gitleaks` · `trufflehog` |
| HTTP & data analysis | `curl` · `httpie` · `jq` · `unfurl` · `anew` |
| Specialized validation | `jwt-tool` · `sqlmap` · `testssl.sh` |

Tools are **evidence producers, not verdict engines**. Broad scanner severity is never accepted as finding severity without independent analysis.

## Dynamic routing

Spodoptera progressively loads only the knowledge relevant to the surface currently being investigated.

```text
/graphql                 → GraphQL + authorization analysis
Bearer JWT / OAuth       → authentication & session model
multipart/form-data      → file-upload model
wss://                   → WebSocket authorization
URL fetch / webhook      → SSRF-oriented trust-boundary analysis
personalized cache       → cache + authorization analysis
parser disagreement      → normalization / routing analysis
API object endpoint      → API + authorization workflow
stateful operation       → business-logic workflow
```

This keeps the agent context focused instead of loading an enormous security checklist for every engagement.

## Repository structure

```text
Spodoptera/
├── README.md
├── docs/
└── skills/
    └── bug-bounty-hunter/
        ├── SKILL.md              # orchestration control plane
        ├── agents/               # agent metadata
        ├── references/           # focused security modules
        ├── workflows/            # repeatable hunt procedures
        ├── scripts/              # environment & engagement helpers
        └── templates/            # findings and reporting
```

`SKILL.md` defines the decision system. Detailed methodology lives in focused references and workflows so Hermes can use progressive disclosure instead of consuming context on irrelevant material.

## Installation

Clone the repository:

```bash
git clone https://github.com/Rektzinch/Spodoptera.git
cd Spodoptera
```

Then install or link `skills/bug-bounty-hunter` into the skills directory supported by your Hermes Agent installation. Keep the entire directory intact because the orchestrator references its supporting modules, workflows, scripts, and templates.

Run the local dependency inspection from the skill directory:

```bash
cd skills/bug-bounty-hunter
./scripts/bootstrap.sh
./scripts/check-tools.sh
```

The bootstrap workflow reports environment/tool availability; missing tooling is treated as a routing constraint rather than permission to invent results.

## Evidence discipline

Every meaningful candidate should answer:

```text
What was observed?
What security assumption might be wrong?
What result would confirm it?
What control disproves alternative explanations?
What is the minimum effective test?
Can the behavior be reproduced?
Which security boundary is crossed?
What impact is actually demonstrated?
```

This distinction between **observation**, **hypothesis**, and **confirmed finding** is central to Spodoptera.

## Responsible use

Spodoptera is intended for authorized security research and official bug-bounty engagements. Establish the target and scope before active testing. Keep activity within the applicable program rules and authorization boundary.

The project excludes denial-of-service/load testing, persistence, destructive modification, credential attacks, unauthorized secret use, real transactions, indiscriminate data collection, and activity outside the authorized scope.

## Design principle

> **Recon is not measured by how long it runs or how many tools it launches. It is measured by how effectively each action improves the model of the target and moves the investigation toward a defensible security finding.**

---

<div align="center">

**Spodoptera** · Bug bounty orchestration for Hermes Agent

`signal > volume` · `reasoning > spraying` · `evidence > alerts`

</div>
