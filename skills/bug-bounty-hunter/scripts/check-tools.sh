#!/usr/bin/env bash
set -u

tools="subfinder dnsx httpx asnmap naabu nmap katana nuclei ffuf feroxbuster gau waybackurls arjun dalfox sqlmap jwt-tool gitleaks trufflehog testssl.sh anew unfurl hakrawler curl jq rg"
missing=0
for tool_name in $tools; do
  if command -v "$tool_name" >/dev/null 2>&1; then
    printf 'OK\t%s\n' "$tool_name"
  else
    printf 'MISSING\t%s\n' "$tool_name"
    missing=$((missing + 1))
  fi
done

if [ "$missing" -gt 0 ]; then
  echo "Some tools are unavailable; route around them and do not fabricate output." >&2
  exit 1
fi
echo "All listed tools are available."
