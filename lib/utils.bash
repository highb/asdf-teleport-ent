#!/usr/bin/env bash

set -euo pipefail

REPO="https://cdn.teleport.dev"
TOOL_NAME="teleport-ent"
TOOL_TEST="tsh version"
OS="${OS:-unknown}"
ARCH="${ARCH:-unknown}"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

list_all_versions() {
  echo "4.4.12"
  echo "5.2.5"
  echo "6.2.28"
  echo "6.2.29"
  echo "6.2.30"
  echo "6.2.31"

  echo "7.3.14"
  echo "7.3.15"
  echo "7.3.16"
  echo "7.3.17"
  echo "7.3.18"
  echo "7.3.19"
  echo "7.3.20"
  echo "7.3.21"
  echo "7.3.23"
  echo "7.3.25"

  echo "8.1.4"
  echo "8.1.5"
  echo "8.2.0"
  echo "8.3.0"
  echo "8.3.1"
  echo "8.3.2"
  echo "8.3.3"
  echo "8.3.4"
  echo "8.3.5"
  echo "8.3.6"
  echo "8.3.7"
  echo "8.3.8"
  echo "8.3.9"
  echo "8.3.10"
  echo "8.3.11"
  echo "8.3.12"
  echo "8.3.14"
  echo "8.3.15"
  echo "8.3.16"
  echo "8.3.17"
  echo "8.3.18"

  echo "9.0.0"
  echo "9.0.2"
  echo "9.0.3"
  echo "9.0.4"
  echo "9.1.0"
  echo "9.1.1"
  echo "9.1.2"
  echo "9.1.3"
  echo "9.2.0"
  echo "9.2.1"
  echo "9.2.3"
  echo "9.2.4"
  echo "9.3.0"
  echo "9.3.2"
  echo "9.3.4"
  echo "9.3.5"
  echo "9.3.6"
  echo "9.3.7"
  echo "9.3.9"
  echo "9.3.10"
  echo "9.3.12"
  echo "9.3.13"
  echo "9.3.14"
  echo "9.3.18"
  echo "9.3.20"

  echo "10.0.0-alpha.2"
  echo "10.0.0-rc.1"
  echo "10.0.0"
  echo "10.0.1"
  echo "10.0.2"
  echo "10.1.2"
  echo "10.1.4"
  echo "10.1.9"
  echo "10.2.0"
  echo "10.2.1"
  echo "10.2.2"
  echo "10.2.4"
  echo "10.2.5"
  echo "10.2.6"
  echo "10.3.0"
  echo "10.3.1"
  echo "10.3.2"
  echo "10.3.3"
  echo "10.3.13"

  echo "11.3.11"

  echo "12.0.0"
  echo "12.0.1"
  echo "12.0.2"
  echo "12.0.3"
  echo "12.0.4"
  echo "12.0.5"

  echo "12.1.0"
  echo "12.1.1"
  echo "12.1.2"
  echo "12.1.3"
  echo "12.1.4"
  echo "12.1.5"

  echo "12.2.0"
  echo "12.2.1"
  echo "12.2.2"
  echo "12.2.3"
  echo "12.2.4"
  echo "12.2.5"

  echo "12.3.0"
  echo "12.3.1"
  echo "12.3.2"
}

detect_os() {
  if [ "$OS" = "unknown" ]; then
    UNAME="$(command -v uname)"

    case $("${UNAME}" | tr '[:upper:]' '[:lower:]') in
    linux*)
      echo 'linux'
      ;;
    darwin*)
      echo 'darwin'
      ;;
    msys* | cygwin* | mingw*)
      echo 'windows'
      ;;
    nt | win*)
      echo 'windows'
      ;;
    *)
      fail "Unknown operating system. Please provide the operating system version by setting \$OS."
      ;;
    esac
  else
    echo "$OS"
  fi
}

detect_arch() {
  # TODO Figure out arm, arm64, i386, etc
  if [ "$ARCH" = "unknown" ]; then
    ARCH="$(uname -m)"
    if [ $? != 0 ]; then
      fail "Unknown architecture. Please provide the architecture by setting \$ARCH."
    fi
  fi

  echo "$ARCH"
}

download_release() {
  local version filename url
  version="$1"
  filename="$2"
  os=$(detect_os)
  arch=$(detect_arch "$os")
  url="$REPO/teleport-ent-v${version}-${os}-${arch}-bin.tar.gz"

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
    # Machine ID is available starting from the Teleport 9.0.0 release. So tbot not exist in previous releases
    [[ -f "$install_path"/tbot ]] && mv "$install_path"/tbot "$install_path"/bin/tbot

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
