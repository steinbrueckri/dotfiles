#!/usr/bin/env bats

################################################################################
# Tests for nvim
################################################################################

@test "fish is installed" {
  run fish --version
  [ "$status" -eq 0 ]
}