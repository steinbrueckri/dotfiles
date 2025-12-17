#!/usr/bin/env bats

# load bat libs
load '/opt/bats-support/load'
load '/opt/bats-assert/load'
load '/opt/bats-file/load'

################################################################################
# Tests for Fish
################################################################################

@test "fish is installed" {
  run fish --version
  assert_success
}

@test "fundle install successful" {
  run fish -c "fundle install"
  assert_success
  refute_output "Unknown command"
  assert_exists "$HOME/.config/fish/fundle/sentriz/fish-pipenv/README.md"
  assert_exists "$HOME/.config/fish/fundle/oh-my-fish/theme-bobthefish/README.md"
}
