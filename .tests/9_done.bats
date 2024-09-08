#!/usr/bin/env bats

teardown() {
  # NOTE: Killall processes because some parts of the dotfiles will fork processes.
  # If the processes are not killed the tests will fail or will hung for ever.
  kill -15 -1
}
