#!/usr/bin/env bash
set -e

################################################################################
# config
################################################################################
# define the chatgpt modle we want to use
MODEL="gpt-4o"
# create a temp file to build the up the content we will then write to the README.md
TEMP_FILE=$(mktemp)
README_PATH="$(pwd)/README.md"
################################################################################
# functions
################################################################################
add_section() {
    echo -e "\n### $1" >> prompt
}

################################################################################
# create prompt
################################################################################
echo "💫 generate prompt"
echo "Hello ChatGPT, please generate markdown tables for my README.md based on the following configurations:

1. Keybindings from my nvim config
2. Keybindings from my tmux config
3. Aliases from my fish config

Every Keybinding from tmux and nvim need to be in the table the same applies for the alias table.
Output only the markdown tables without additional text and annotations like markdown codeblocks or something, as I will pipe your output directly into the README.md.
" > prompt

add_section "nvim Keybindings"
grep -E "keymap|vim\.api" .config/nvim/lua/keymap.lua >> prompt

add_section "tmux Keybindings"
grep "^bind" .tmux.conf >> prompt

add_section "Fish Aliases"
grep "^alias" .config/fish/config.fish >> prompt

# check if it makes sens to rebuild the keybinding table in the readme.
files="$HOME/.config/nvim/lua/keymap.lua $HOME/.tmux.conf $HOME/.config/fish/config.fish"

# Get modification time of README.md
readme_mtime=$(stat -f %m README.md)

# Flag to indicate if any file is newer
newer_file=false

# Loop through all files
for file in $files; do
  # Get modification time of the current file
  file_mtime=$(stat -f %m "$file")

  # If the file is newer than README.md, set the flag
  if [[ $file_mtime -gt $readme_mtime ]]; then
    newer_file=true
    break  # Exit the loop as soon as one newer file is found
  fi
done

# If any file is newer, execute the command
if [[ $newer_file == true ]]; then
  echo "💸 One or more files are newer than README.md regenerate the table with ChatGPT"
  echo "🔑 get openapi api key"
  export OPENAI_API_KEY=$(op --account pixel-combo.1password.com item get OPENAI_API_KEY --reveal --field password)
  echo "🤞 send prompt to ChatGPT ($MODEL)"
  chatgpt --model $MODEL < prompt > keymapping_table.md
else
  echo "⏸ No file is newer then the README so we dont regenerate the table to save some costs."
fi

# takes the content of the original README.md from the TOP to the spot we want to insert the table
grep -B100000 "<!-- generate-table-start -->" "$README_PATH" > "$TEMP_FILE"

cat keymapping_table.md >> "$TEMP_FILE"

# takes the content of the original README.md from the BOOTOM to the spot we want to insert the table
grep -A100000 "<!-- generate-table-stop -->" "$README_PATH" >> "$TEMP_FILE"

# overview the original README.d with the temp file we have build up
cat "$TEMP_FILE" > "$README_PATH"

# cleanup promt file
echo "🗑 cleanup"
rm prompt
