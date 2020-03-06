#!/usr/bin/env bash

# Add customizations here

# My own GPG key
export GPG_MYSELF="B1AB796631CD7433EE213F9ACE9C332D8D86D48B"

# Use this GPG key to encrypt something to my offline encryption key
export OFFLINE_ENCRYPT_KEY="110054020B03B6FF!"

# Leave this environment variable export here. It is used in the install script.
export INTERACTIVE_PROFILE_LOADED=true

if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
    # shellcheck source=/dev/null
    . ~/.nix-profile/etc/profile.d/nix.sh
fi
