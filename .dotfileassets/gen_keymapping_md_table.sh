#!/usr/bin/env bash
set -e

################################################################################
# Config
################################################################################

TEMP_FILE=$(mktemp)
README_PATH="$(pwd)/README.md"

################################################################################
# Functions
################################################################################

add_section() {
    echo -e "\n### $1" >> prompt
}

cleanup() {
    rm -f prompt keymapping_table.md "$TEMP_FILE"
}
trap cleanup EXIT

################################################################################
# Check if rebuild is needed
################################################################################

files="$HOME/.config/nvim/lua/keymap.lua $HOME/.tmux.conf $HOME/.config/fish/config.fish"
readme_mtime=$(stat -f %m "$README_PATH")
newer_file=false

for file in $files; do
    if [[ ! -f "$file" ]]; then
        echo "Warning: $file not found, skipping mtime check."
        continue
    fi
    file_mtime=$(stat -f %m "$file")
    if [[ $file_mtime -gt $readme_mtime ]]; then
        newer_file=true
        break
    fi
done

if [[ $newer_file != true ]]; then
    echo "No config file is newer than README.md — skipping regeneration."
    exit 0
fi

################################################################################
# Build prompt
################################################################################

echo "Please generate markdown tables for my README.md based on the following configurations:

1. Keybindings from my nvim config
2. Keybindings from my tmux config
3. Aliases from my fish config

Include every keybinding from tmux and nvim in the respective table. The same applies for the alias table.
Output only the markdown tables without any additional text, annotations, or markdown code blocks.
The output will be inserted directly into README.md." > prompt

add_section "nvim Keybindings"
cat .config/nvim/lua/keymap.lua >> prompt

add_section "tmux Keybindings"
grep "^bind" .tmux.conf >> prompt

add_section "Fish Aliases"
grep "^alias" .config/fish/config.fish >> prompt

################################################################################
# Generate table with Claude
################################################################################

echo "Sending prompt to Claude..."
claude -p "$(cat prompt)" > keymapping_table.md

################################################################################
# Inject into README.md
################################################################################

grep -B100000 "<!-- generate-table-start -->" "$README_PATH" > "$TEMP_FILE"
cat keymapping_table.md >> "$TEMP_FILE"
grep -A100000 "<!-- generate-table-stop -->" "$README_PATH" >> "$TEMP_FILE"
cat "$TEMP_FILE" > "$README_PATH"

echo "Done. README.md updated."
