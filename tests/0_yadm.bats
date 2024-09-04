@test "yadm is installed" {
  run yadm --version
  # Ensure Yadm exited successfully
  if [ "$status" -ne 0 ]; then
    echo "yadm exited with a non-zero status."
    echo "yadm output:"
    echo "$output"
    return 1
  fi
}

@test "yadm bootstrap is working" {
  run yadm bootstrap
  if [ "$status" -ne 0 ]; then
    echo "yadm exited with a non-zero status."
    echo "yadm output:"
    echo "$output"
    return 1
  fi

  # verify that the bootstrap script run was successfully
  if [ -f /tmp/bootstrap-finished ]; then
      if [ $(($(date +%s) - $(date +%s -r /tmp/bootstrap-finished))) -lt 600 ]; then
          echo "The file /tmp/bootstrap-finished is not older than 10 minutes."
      else
          echo "The file /tmp/bootstrap-finished is older than 10 minutes."
          return 1
      fi
  else
      echo "The file /tmp/bootstrap-finished does not exist."
      return 1
  fi
}
