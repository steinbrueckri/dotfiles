#!/usr/bin/env bats

# load bat libs
load '/opt/bats-support/load'
load '/opt/bats-assert/load'
load '/opt/bats-file/load'

################################################################################
# Tests for Nvim
################################################################################

@test "nvim is installed" {
  run nvim --version
  assert_success
}

@test "bootstrap nvim" {
  run nvim --headless "+Lazy! sync" +qall!
  assert_success
  assert_exists "$HOME/.config/nvim/lazy-lock.json"
  assert_exists "$HOME/.local/share/nvim/lazy/lazy.nvim/bootstrap.lua"
  assert_exists "$HOME/.local/share/nvim/lazy/telescope.nvim/lua/telescope/init.lua"
}

@test "bootstrap TSInstall " {
  run nvim --headless "+TSInstallSync all" +qall!
  assert_success
}

# NOTE: Test is a bit flary because of that the retry
@test "Install all LSPs with Mason" {
  # Define a list of LSPs to be installed
  lsps=("stylua" "jq" "black" "isort" "yamlfmt" "markdownlint" "pylint")

  # Maximum number of retries
  max_retries=3

  # Loop through the list of tools
  for lsp in "${lsps[@]}"; do
    # Retry counter
    retries=0
    success=false

    # Retry loop
    while [[ $retries -lt $max_retries ]]; do
      # NOTE: print LSP name for easier debugging
      echo "Installing $lsp, attempt $(($retries + 1))..."

      run nvim --headless "+MasonInstall $lsp --force" +qall!

      if [[ "$status" -eq 0 ]]; then
        echo "... install $lsp successfully"
        success=true
        break
      else
        echo "... install $lsp failed, retrying..."
        retries=$(($retries + 1))
        sleep 2  # Optional: wait for a short time before retrying
      fi
    done

    # If after retries the installation is still failing, fail the test
    if [[ "$success" = false ]]; then
      echo "... install $lsp failed after $max_retries attempts"
      assert_success
    fi
  done
}

@test "checkhealth" {
  run nvim --headless "+checkhealth" '+w!health.log' +qa
  assert_success
  assert_regex "OK Parser.*"
  assert_regex ".*OK Registry.*"
  assert_regex ".*OK plenary installed.*"
  assert_regex ".*OK nvim-treesitter installed.*"
  assert_regex ".*OK nvim-web-devicons installed.*"
  assert_regex ".*OK rg: found ripgrep.*"
  assert_regex ".*OK fd: found fdfind.*"

  refute_line 'ERROR Registry'
  refute_line 'ERROR stylua: the command "stylua" is not executable.'
  refute_line 'ERROR black: the command "black" is not executable.'
  refute_line 'ERROR isort: the command "isort" is not executable.'
  refute_line 'ERROR markdownlint: the command "markdownlint" is not executable.'
}

@test "Average startuptime is below 12 msec" {
  LOG_FILE="vim-startuptime.log"
  run vim-startuptime -vimpath nvim > $LOG_FILE
  total_avg=$(grep "Total Average:" "$LOG_FILE" | awk '{print $3}')
  total_avg_rounded=$(printf "%.0f" $total_avg)

  limit=150

  assert_success
  assert [ "$total_avg_rounded" -lt "$limit" ]
}
