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

  # Check for errors or stack tracebacks in the output
  echo "$output" | grep -q "Error"
  if [ "$?" -eq 0 ]; then
    echo "Error found in Neovim output"
    echo "$output"
    return 1
  fi

  echo "$output" | grep -q "stack traceback"
  if [ "$?" -eq 0 ]; then
    echo "Stack traceback found in Neovim output"
    echo "$output"
    return 1
  fi
}

@test "check that lazy.nvim is installed" {
  if [ ! -d "$HOME/.local/share/nvim/lazy/lazy.nvim/" ]; then
    echo "Directory $HOME/.local/share/nvim/lazy/lazy.nvim/ does not exist."
    return 1
  fi
}
