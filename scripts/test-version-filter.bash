#!/usr/bin/env bash
# Verify `list-all` returns only versions from SUPPORTED_MAJOR_VERSIONS.
set -euo pipefail

current_script_path=${BASH_SOURCE[0]}
plugin_dir=$(dirname "$(dirname "$current_script_path")")

# shellcheck source=../lib/utils.bash
source "${plugin_dir}/lib/utils.bash"

versions="$(list_all_versions)"

if [ -z "$versions" ]; then
  echo "list_all_versions returned no versions" >&2
  exit 1
fi

# Every returned version must belong to a supported major.
for version in $versions; do
  major="${version%%.*}"
  supported=false
  for supported_major in $SUPPORTED_MAJOR_VERSIONS; do
    if [ "$major" = "$supported_major" ]; then
      supported=true
    fi
  done
  if [ "$supported" != true ]; then
    echo "unsupported major in list-all: $version" >&2
    exit 1
  fi
done

# Every supported major must have at least one version.
for supported_major in $SUPPORTED_MAJOR_VERSIONS; do
  found=false
  for version in $versions; do
    if [ "${version%%.*}" = "$supported_major" ]; then
      found=true
    fi
  done
  if [ "$found" != true ]; then
    echo "no versions for supported major $supported_major" >&2
    exit 1
  fi
done

count="$(echo "$versions" | wc -w)"
echo "list-all OK: $count versions across majors [$SUPPORTED_MAJOR_VERSIONS]"
