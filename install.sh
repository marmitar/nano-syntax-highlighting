#!/bin/bash
set -e

# check for unzip before we continue
if [ ! "$(command -v unzip)" ]; then
  echo 'unzip is required but was not found. Install unzip first and then run this script again.' >&2
  exit 1
fi

INSTALL_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nano-syntax-highlighting"

_remove_dotnano() {
  sed -i 's#"~/.nano/#d' "${NANORC_FILE}"
  rm -rf ~/.nano
}

_fetch_sources() {
  br=$(_find_suitable_branch)
  mkdir -p "$INSTALL_DIR"

  curl -sSL "https://github.com/galenguyer/nano-syntax-highlighting/archive/${br}.tar.gz" \
    | tar -C  "$INSTALL_DIR" -xz --strip-components=2 --wildcards '*/src/'
}

_update_nanorc() {
  inc="include \"${INSTALL_DIR}/nanorc\""
  if ! grep -qF "$inc" "${NANORC_FILE}"; then
    echo "$inc" >> "$NANORC_FILE"
  fi
}

_version_str_to_num() {
  if [ -z "$1" ]; then
    return
  fi
  echo -n "$1" | awk -F . '{printf("%d%02d%02d", $1, $2, $3)}'
}

_find_suitable_branch() {
  # find the branch that is suitable for local nano
  verstr=$(nano --version 2>/dev/null | awk '/GNU nano/ {print ($3=="version")? $4: substr($5,2)}')
  ver=$(_version_str_to_num "$verstr")
  if [ -z "$ver" ]; then
    echo "Cannot determine nano's version, fallback to master" >&2
    echo "master"
    return
  fi
  branches=(
    pre-6.0
    pre-5.0
    pre-4.5
    pre-2.9.5
    pre-2.6.0
    pre-2.3.3
    pre-2.1.6
  )
  target="master"
  # find smallest branch that is larger than ver
  for b in "${branches[@]}"; do
    num=$(_version_str_to_num "${b#*pre-}")
    if (( ver < num )); then
      target="${b}"
    else
      break
    fi
  done
  echo "$target"
}

_find_nanorc() {
  if [ -f ~/.nanorc ]; then
    echo ~/.nanorc
  else
    nano_home="${XDG_CONFIG_HOME:-$HOME/.config}/nano"
    mkdir -p "${nano_home}"
    touch "${nano_home}/nanorc"
    echo "${nano_home}/nanorc"
  fi
}


NANORC_FILE="$(_find_nanorc)"

case "$1" in
 --find_suitable_branch)
  _find_suitable_branch
  exit 0
 ;;
 -h|--help)
   echo "Install script for nanorc syntax highlights"
   exit 0
 ;;
esac

_remove_dotnano
_fetch_sources
_update_nanorc
