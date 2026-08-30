#!/usr/bin/env bash
# List contributors between two tags (default: latest tag to HEAD).
# Usage: scripts/contributors.bash [<from-tag> [<to-ref>]]
set -euo pipefail

# Default: all-time. Pass a tag as first arg to filter since that tag.
from="${1:-}"
to="${2:-HEAD}"

# Map known author names to GitHub handles.
declare -A HANDLES=(
  ["Benoît Sauvère"]="notsag"
  ["Daraius Dastoor"]="drootsad"
  ["Travis Hampton"]="thampton"
  ["Ali AKCA"]="aweris"
  ["Maxime Gaston"]="NitriKx"
  ["Greg Back"]="gtback"
  ["Ross Williams"]="gunzy83"
  ["Vlad Losev"]="vladlosev"
)

git_args=()
if [ -n "$from" ]; then
  git_args=("${from}..${to}")
fi

while read -r name; do
  case "$name" in
  *\[bot\]* | *github-actions* | *renovate* | "Brandon High" | "highb") continue ;;
  esac
  handle="${HANDLES[$name]:-$name}"
  echo "- @$handle"
done < <(git log --format="%an" "${git_args[@]}" | sort -u)
