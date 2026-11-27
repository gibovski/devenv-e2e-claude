#!/usr/bin/env bash
# Verifies every e2e/*.md file contains exactly the expected single line.
set -euo pipefail

cd "$(dirname "$0")/.."

expected='hello from the devenv e2e test'
status=0
shopt -s nullglob
files=(e2e/*.md)

if [ "${#files[@]}" -eq 0 ]; then
  echo "FAIL: no e2e/*.md files found" >&2
  exit 1
fi

for f in "${files[@]}"; do
  lines=$(wc -l < "$f")
  content=$(cat "$f")
  if [ "$lines" -ne 1 ] || [ "$content" != "$expected" ]; then
    echo "FAIL: $f does not contain exactly the expected line" >&2
    status=1
  else
    echo "ok: $f"
  fi
done

exit "$status"
