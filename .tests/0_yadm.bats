#!/usr/bin/env bats

# load bat libs
load '/opt/bats-support/load'
load '/opt/bats-assert/load'
load '/opt/bats-file/load'

################################################################################
# Tests for YADM
################################################################################

@test "yadm is installed" {
  run yadm --version
  assert_success
}

@test "yadm bootstrap is working" {
  run yadm bootstrap
  assert_success
  assert_file_contains /tmp/yadm-bootstrap "finished"
}
