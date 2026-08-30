#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/gravitational/teleport/"
REPO="https://get.gravitational.com"
TOOL_NAME="teleport-ent"
TOOL_TEST="tsh version"
OS="${OS:-unknown}"
ARCH="${ARCH:-unknown}"

fail() {
  echo -e "asdf-$TOOL_NAME: $*" >/dev/stderr
  exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -E 'refs/tags/v[0-9]+\.[0-9]+\.[0-9]+$' |
    sed 's|.*refs/tags/v||' |
    sort -t. -k1,1n -k2,2n -k3,3n
}

# Teleport supports the two most recent major versions.
# Update this when a new major is released or an old one goes EOL.
# Reference: https://endoflife.date/teleport
SUPPORTED_MAJOR_VERSIONS="17 18"

list_all_versions() {
  local major rest
  list_github_tags | while IFS=. read -r major rest; do
    for supported in $SUPPORTED_MAJOR_VERSIONS; do
      if [ "$major" = "$supported" ]; then
        echo "$major.$rest"
        break
      fi
    done
  done
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
  if [ "$ARCH" = "unknown" ]; then
    ARCH="$(uname -m)"
    if [ $? != 0 ]; then
      fail "\$ARCH not provided and could not call uname -m."
    fi

    # Translate to Teleport arch names/explicit list of supported arch
    if [ "${ARCH}" == "x86_64" ]; then
      echo "amd64"
    elif [ "${ARCH}" == "amd64" ]; then
      echo "$ARCH"
    elif [ "${ARCH}" == "arm64" ]; then
      echo "$ARCH"
    elif [ "${ARCH}" == "aarch64" ]; then
      echo "arm64"
    elif [ "${ARCH}" == "i386" ]; then
      echo "$ARCH"
    elif [ "${ARCH}" == "armv7" ]; then
      echo "$ARCH"
    else
      fail "Unknown architecture. Please provide the architecture by setting \$ARCH."
    fi
  else
    echo "$ARCH"
  fi
}

download_release() {
  local version filename url fips_build
  version="$1"
  filename="$2"
  fips_build="$3"
  os=$(detect_os)
  arch=$(detect_arch "$os")

  if [[ "$fips_build" == true ]]; then
    url="$REPO/teleport-ent-v${version}-${os}-${arch}-fips-bin.tar.gz"
  else
    url="$REPO/teleport-ent-v${version}-${os}-${arch}-bin.tar.gz"
  fi

  echo "* Downloading $TOOL_NAME release $version (fips=$fips_build)..."
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_client_binary() {
  local install_path="$1"
  local binary="$2"

  local binary_path="$install_path/$binary"

  if [ ! -f "$binary_path" -a -d "${binary_path}.app" ]; then
    # Hanle MacOS application bundle.
    mv "${binary_path}.app" "$install_path/bin/${binary}.app"
    (cd "$install_path/bin" && ln -s "${binary}.app/Contents/MacOS/$binary" "$binary")
  else
    mv "$binary_path" "$install_path/bin/$binary"
  fi
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
    install_client_binary "$install_path" tsh
    install_client_binary "$install_path" tctl
    install_client_binary "$install_path" teleport
    # Machine ID is available starting from the Teleport 9.0.0 release. So tbot not exist in previous releases
    [[ -f "$install_path"/tbot ]] && install_client_binary "$install_path" tbot

    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    test -x "$install_path/bin/$tool_cmd" || fail "Expected $install_path/bin/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error ocurred while installing $TOOL_NAME $version."
  )
}
