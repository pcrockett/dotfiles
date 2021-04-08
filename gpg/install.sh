#!/usr/bin/env bash

# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -Eeuo pipefail

[[ "${BASH_VERSINFO[0]}" -lt 4 ]] && echo "Bash >= 4 required" && exit 1

THIS_DIR=$(dirname "$(readlink -f "${0}")")

GPG_DIR=~/.gnupg
if [ ! -d "${GPG_DIR}" ]; then
  mkdir "${GPG_DIR}"
fi

chmod go-rwx "${GPG_DIR}"
ln --symbolic --verbose "${THIS_DIR}/gpg.conf" "${GPG_DIR}/gpg.conf" || true
ln --symbolic --verbose "${THIS_DIR}/dirmngr.conf" "${GPG_DIR}/dirmngr.conf" || true
