#!/usr/bin/env bats

################################################################################
# Tests for fish
################################################################################

@test "nvim is installed" {
  run nvim --version
  # Ensure Neovim exited successfully
  if [ "$status" -ne 0 ]; then
    echo "Neovim exited with a non-zero status."
    echo "Neovim output:"
    echo "$output"
    return 1
  fi
}

# lazy is installed
# plugins are there

@test "bootstrap nvim" {
  # Run Neovim to install plugins and capture output
  run nvim --headless "+Lazy! sync" +qa

  # Ensure Neovim exited successfully
  if [ "$status" -ne 0 ]; then
    echo "Neovim exited with a non-zero status."
    echo "Neovim output:"
    echo "$output"
    return 1
  fi

  # NOTE: dont check on Error because of
  # https://www.reddit.com/r/neovim/comments/11uotmr/installing_lsps_using_mason_fails_because_neovim/

  echo "$output" | grep -q "stack traceback"
  if [ "$?" -eq 0 ]; then
    echo "Stack traceback found in Neovim output"
    echo "$output"
    return 1
  fi
}

@test "check that lazy.nvim is installed" {
  if [ ! -d "$HOME/.local/share/nvim/lazy/lazy.nvim/bootstrap.lua" ]; then
    echo "Directory $HOME/.local/share/nvim/lazy/lazy.nvim/ does not exist."
    return 1
  fi
}

# install lsps


# testuser@6f4b2aa99d29:~$ nvim --headless "+MasonUpdate" +qa
# gitsigns: Ignoring invalid configuration field 'yadm'testuser@6f4b2aa99d29:~$ nvim --headless "+MasonInstall jq" +qa
# gitsigns: Ignoring invalid configuration field 'yadm'Downloading file "https://github.com/stedolan/jq/releases/download/jq-1.7/jq-linux-arm64"…
# Unpacking "jq-linux-arm64"…testuser@6f4b2aa99d29:~$ nvim --headless "+MasonInstall jqsdfsdf" +qa
# gitsigns: Ignoring invalid configuration field 'yadm'testuser@6f4b2aa99d29:~$ echo $?
# 1


# "stylua", "jq", "black", "isort", "yamlfmt", "ansiblelint", "markdownlint", "pylint",

# nvim --headless "+MasonUpdate" +qa


