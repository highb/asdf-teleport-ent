#!/usr/bin/env bash

set -euo pipefail

REPO="https://get.gravitational.com"
TOOL_NAME="teleport-ent"
TOOL_TEST="tsh version"
OS="${OS:-unknown}"
ARCH="${ARCH:-unknown}"

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
  echo "9.0.0"
  echo "8.3.4"
  echo "8.3.3"
  echo "8.3.2"
  echo "8.3.1"
  echo "8.3.0"
  echo "8.2.0"
  echo "8.1.5"
  echo "8.1.4"
  echo "7.3.17"
  echo "7.3.16"
  echo "7.3.15"
  echo "7.3.14"
  echo "6.2.31"
  echo "6.2.30"
  echo "6.2.29"
  echo "6.2.28"
  echo "5.2.5"
  echo "4.4.12"
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
    if [ "$1" = "darwin" ]; then
      echo 'amd64'
    elif [ "$1" = "linux" ]; then
      echo 'amd64'
    else
      fail "Unknown architecture. Please provide the architecture by setting \$ARCH."
    fi
  else
    echo "$ARCH"
  fi
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
