#!/usr/bin/env bash
set -u

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <engagement-dir> <target>" >&2
  exit 2
fi

engagement_dir=$1
target=$2
mkdir -p "$engagement_dir"/{engagement,recon,mapping,evidence,findings,logs}

authorization="$engagement_dir/engagement/authorization.md"
if [ ! -e "$authorization" ]; then
  {
    echo "# Authorization"
    echo
    echo "Complete this file before any active request. A target string is not proof of permission."
    echo
    echo "- Operator:"
    echo "- Program/owner:"
    echo "- Proposed target: $target"
    echo "- In-scope domains/hosts/paths:"
    echo "- Excluded assets/actions:"
    echo "- Window (UTC):"
    echo "- Approved accounts/test data:"
    echo "- Rate/concurrency limits:"
    echo "- Contact/escalation:"
    echo "- Explicit authorization reference:"
    echo
    echo "## Required prohibitions"
    echo "DoS/load testing, persistence, destructive changes, spam, real purchases, credential attacks, secret use, data dumping, and out-of-scope testing are prohibited unless separately and explicitly authorized."
  } > "$authorization"
fi

if [ ! -e "$engagement_dir/engagement/state.md" ]; then
  {
    echo "# State"
    echo
    echo "- Current state: SCOPE"
    echo "- Target: $target"
    echo "- Started (UTC): $(date -u +%Y-%m-%dT%H:%M:%SZ)"
    echo "- Next action: complete authorization.md"
  } > "$engagement_dir/engagement/state.md"
fi

if [ ! -e "$engagement_dir/findings/ledger.tsv" ]; then
  printf 'id\tasset\tobservation\thypothesis\tcontrol\ttest\tprerequisite\tstatus\tevidence\tnext_action\n' > "$engagement_dir/findings/ledger.tsv"
fi

echo "Initialized engagement directory: $engagement_dir"
echo "Complete $authorization before active testing."
