#!/usr/bin/env bash

set -euo pipefail

REPO="https://get.gravitational.com"
TOOL_NAME="teleport-ent"
TOOL_TEST="tsh version"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_all_versions() {
  echo "v8.3.4-darwin-amd64"
  echo "v7.3.17-darwin-amd64"
  echo "v6.2.31-darwin-amd64"
}

download_release() {
  local version filename url
  version="$1"
  filename="$2"

  url="$REPO/teleport-ent-${version}-bin.tar.gz"

  echo "* Downloading $TOOL_NAME release $version..."
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    mkdir -p "$install_path"
    cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"
    mkdir -p "$install_path"/bin
    mv "$install_path"/tsh "$install_path"/bin/tsh
    mv "$install_path"/tctl "$install_path"/bin/tctl
    mv "$install_path"/teleport "$install_path"/bin/teleport

    # TODO: Asert teleport-ent executable exists.
    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    test -x "$install_path/bin/$tool_cmd" || fail "Expected $install_path/bin/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error ocurred while installing $TOOL_NAME $version."
  )
}
