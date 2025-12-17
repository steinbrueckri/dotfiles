#!/usr/bin/env bats

# load bat libs
load '/opt/bats-support/load'
load '/opt/bats-assert/load'
load '/opt/bats-file/load'

################################################################################
# Tests for tmux
################################################################################

@test "tmux is installed" {
  run tmux -V
  assert_success
}

@test "tpm bootstrap" {
  # start tmux without attaching
  tmux new-session -d -s bats-test

  # install plugins with tpm
  tmux send-keys -t bats-test "tmux run-shell ~/.tmux/plugins/tpm/scripts/install_plugins.sh" C-m

  # wait a bit until tpm has done his work
  # FIXME: find a smarter way to wait
  sleep 5

  # kill tmux session and server
  tmux kill-session -t bats-test

  # check if the plugin install was working
  assert_exists "$HOME/.tmux/plugins/tmux/rose-pine.tmux"
  assert_exists "$HOME/.tmux/plugins/tpm/tpm"
}

@test "tmux send-keys writes to pane" {
  tmux new-session -d -s testsession
  tmux send-keys -t testsession 'echo "Hello, World!"' C-m
  sleep 1
  tmux capture-pane -t testsession -p >/tmp/output.txt
  tmux kill-server
  run cat /tmp/output.txt
  assert_line 'Hello, World!'
  assert_success
}
