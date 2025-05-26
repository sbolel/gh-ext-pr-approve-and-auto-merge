#!/usr/bin/env bats

setup() {
  PATH="$BATS_TEST_DIRNAME/bin:$PATH"
}

@test "prints help" {
  run $BATS_TEST_DIRNAME/../gh-pr-approve-and-auto-merge --help
  [ "$status" -eq 0 ]
}

@test "fails without PR numbers" {
  run $BATS_TEST_DIRNAME/../gh-pr-approve-and-auto-merge <<<"Y"
  [ "$status" -ne 0 ]
  [[ "$output" == *"No PR numbers supplied."* ]]
}

@test "dry-run merges dependency bump" {
  run bash -c "printf 'Y\n' | $BATS_TEST_DIRNAME/../gh-pr-approve-and-auto-merge 1"
  [ "$status" -eq 0 ]
  [[ "$output" == *"Would approve & merge #1"* ]]
}

@test "skips non-bump PR" {
  run bash -c "printf 'Y\n' | $BATS_TEST_DIRNAME/../gh-pr-approve-and-auto-merge 2"
  [ "$status" -eq 0 ]
  [[ "$output" == *"Not a dependency bump"* ]]
}

@test "skips when CI not green" {
  run bash -c "printf 'Y\n' | $BATS_TEST_DIRNAME/../gh-pr-approve-and-auto-merge 3"
  [ "$status" -eq 0 ]
  [[ "$output" == *"CI not green"* ]]
}

@test "handles comma-separated list" {
  run bash -c "printf 'Y\n' | $BATS_TEST_DIRNAME/../gh-pr-approve-and-auto-merge 1,2"
  [ "$status" -eq 0 ]
  [[ "$output" == *"Will process PRs: 1 2"* ]]
}
