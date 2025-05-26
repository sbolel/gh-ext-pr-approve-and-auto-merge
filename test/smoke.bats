#!/usr/bin/env bats
@test "prints help" {
  run $BATS_TEST_DIRNAME/../gh-pr-approve-and-auto-merge --help
  [ "$status" -eq 0 ]
}
