#!/usr/bin/env bash
#
# Render a Ringo SIP profile from its template using 1Password.
#
# The template (ringo/profiles/<profile>.toml.tmpl) holds {{ op://... }} secret
# references; `op inject` resolves them at render time. Secrets and personal
# data never live in the dotfiles, only templates and this script.
#
# The rendered profile is written locally to
#   ~/.config/ringo/profiles/<profile>/profile.toml
# with mode 0600.
#
# Adding a provider needs NO change here: just drop a new
# ringo/profiles/<profile>.toml.tmpl with its own op:// references.
#
# Usage: render-ringo-profile.sh [profile]   (default: telekom)

set -euo pipefail

# Resolve the directory this script lives in, so templates are found regardless
# of the current working directory.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DEFAULT_PROFILE="telekom"
profile="${1:-$DEFAULT_PROFILE}"

# 1Password account the secret references resolve against. Required because more
# than one account is configured; without it op would use the default account.
OP_ACCOUNT="pixel-combo.1password.com"

TEMPLATE="$SCRIPT_DIR/profiles/$profile.toml.tmpl"
TARGET_DIR="$HOME/.config/ringo/profiles/$profile"
TARGET="$TARGET_DIR/profile.toml"

# --- Preconditions ----------------------------------------------------------

if ! command -v op >/dev/null 2>&1; then
  echo "1Password CLI 'op' is not installed or not on PATH." >&2
  exit 1
fi

# Verify the account is reachable/authorized. We use 'op account get' (not
# 'op whoami') because with the 1Password desktop-app integration there is no
# CLI session token, yet data commands are authorized by the app.
if ! op account get --account "$OP_ACCOUNT" >/dev/null 2>&1; then
  echo "1Password account '$OP_ACCOUNT' is not reachable. Unlock the 1Password app or run: op signin --account $OP_ACCOUNT" >&2
  exit 1
fi

if [[ ! -f "$TEMPLATE" ]]; then
  echo "Unknown Ringo profile '$profile': no template at $TEMPLATE" >&2
  echo "Create it to add this provider." >&2
  exit 1
fi

# --- Render -----------------------------------------------------------------

mkdir -p "$TARGET_DIR"

# Inject to a temp file first, then atomically move it into place. The temp file
# is created in the target dir (same filesystem) so 'mv' is atomic. umask 077
# plus an explicit chmod guarantee 0600 on the rendered secret file.
umask 077
tmp="$(mktemp "$TARGET.XXXXXX")"
trap 'rm -f "$tmp"' EXIT

op inject --account "$OP_ACCOUNT" --in-file "$TEMPLATE" --out-file "$tmp" --force >/dev/null

chmod 600 "$tmp"
mv "$tmp" "$TARGET"
trap - EXIT

# Never print secrets — only the destination path.
echo "Rendered Ringo profile '$profile' to $TARGET"
