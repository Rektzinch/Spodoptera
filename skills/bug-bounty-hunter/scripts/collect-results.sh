#!/usr/bin/env bash
set -u

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <engagement-dir> [output-file]" >&2
  exit 2
fi

engagement_dir=$1
output_file=${2:-"$engagement_dir/assessment-summary.md"}

{
  echo "# Assessment summary"
  echo
  echo "Generated (UTC): $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo
  if [ -f "$engagement_dir/engagement/state.md" ]; then
    echo "## State"
    sed -n '1,80p' "$engagement_dir/engagement/state.md"
  fi
  echo
  echo "## Finding counts"
  if [ -f "$engagement_dir/findings/ledger.tsv" ]; then
    awk -F '\t' 'NR>1 && NF {count[$8]++} END {for (status in count) print "- " status ": " count[status]}' "$engagement_dir/findings/ledger.tsv" | sort
  else
    echo "- No ledger found"
  fi
  echo
  echo "## Confirmed finding files"
  find "$engagement_dir/findings" -maxdepth 1 -type f -name '*.md' -print 2>/dev/null | sort || true
  echo
  echo "## Coverage artifacts"
  find "$engagement_dir/recon" "$engagement_dir/mapping" -maxdepth 1 -type f -print 2>/dev/null | sort || true
  echo
  echo "Raw evidence remains under the engagement directory and must be redacted before sharing."
} > "$output_file"

echo "Wrote $output_file"
