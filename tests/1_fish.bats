#!/usr/bin/env bats

################################################################################
# Tests for nvim
################################################################################

# TODO: installed fundler?
# fish -c "fundle install"

@test "fish is installed" {
  run fish --version
  [ "$status" -eq 0 ]
}

@test "fundle install successful" {
  run fish -c "fundle install"
  if [ "$status" -ne 0 ]; then
    echo "exited with a non-zero status."
    echo "output:"
    echo "$output"
    return 1
  fi

  bad_string="Unknown command"
  echo "$output" | grep -q "$bad_string"
  if [ "$?" -eq 1 ]; then
    echo "Bad things found in output ($bad_string)"
    echo "$output"
    return 1
  fi
}

