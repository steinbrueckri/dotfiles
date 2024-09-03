#!/usr/bin/env bats

################################################################################
# Tests for fish
################################################################################

@test "nvim is installed" {
  run nvim --version
  [ "$status" -eq 0 ]
}

@test "install plugins" {
  # Run Neovim to install plugins
  run nvim --headless "+Lazy! sync" +qa
  [ "$status" -eq 0 ]

  # Wait a few seconds to ensure the plugins have been installed
  sleep 5

  # Check if the lazy directory exists
  if [ ! -d "$HOME/.local/share/nvim/lazy" ]; then
    echo "Directory $HOME/.local/share/nvim/lazy/ does not exist."
    return 1
  fi
}
