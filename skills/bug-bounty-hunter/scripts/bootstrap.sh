#!/usr/bin/env bash
set -u

echo "[environment]"
for command_name in go python3 pipx node npm git curl jq; do
  if command -v "$command_name" >/dev/null 2>&1; then
    printf 'present\t%s\t%s\n' "$command_name" "$(command -v "$command_name")"
  else
    printf 'missing\t%s\n' "$command_name"
  fi
done

echo "[tooling]"
for command_name in subfinder dnsx httpx asnmap naabu nmap katana nuclei ffuf feroxbuster gau waybackurls arjun dalfox sqlmap jwt-tool gitleaks trufflehog testssl.sh anew unfurl hakrawler http; do
  if command -v "$command_name" >/dev/null 2>&1; then
    printf 'present\t%s\t%s\n' "$command_name" "$(command -v "$command_name")"
  else
    printf 'missing\t%s\n' "$command_name"
  fi
done

echo "[policy]"
echo "No tools were installed or executed. Select tools only after scope review."
