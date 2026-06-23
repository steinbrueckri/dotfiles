#!/usr/bin/env bash
#
# Render a Ringo SIP profile and start Ringo with it.
#
# Usage:
#   phone-wrapper.sh                -> render+start default profile (telekom)
#   phone-wrapper.sh <profile>      -> render+start <profile>
#   phone-wrapper.sh <profile> ...  -> render+start <profile>, forward extra args
#   phone-wrapper.sh --help         -> default profile, forward --help to Ringo

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DEFAULT_PROFILE="telekom"

# How Ringo selects a profile to start.
# Ringo takes the profile as a POSITIONAL argument of its `start` subcommand:
#   ringo start <profile> [extra-args]
# There is no --profile flag. If that ever changes, adjust these two constants.
RINGO_BIN="ringo"
RINGO_START_SUBCOMMAND="start"

# Argument parsing:
#   - no args                 -> profile = default, no extra Ringo args
#   - first arg starts with - -> treat as a Ringo flag, use default profile
#   - first arg otherwise     -> it is the profile name; rest goes to Ringo
if [[ $# -gt 0 && "$1" != -* ]]; then
  profile="$1"
  shift
else
  profile="$DEFAULT_PROFILE"
fi

# Render the profile first (reads secrets from 1Password, writes profile.toml).
"$SCRIPT_DIR/render-ringo-profile.sh" "$profile"

# Start Ringo with the selected profile and forward any remaining arguments.
exec "$RINGO_BIN" "$RINGO_START_SUBCOMMAND" "$profile" "$@"
