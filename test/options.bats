#!/usr/bin/env bats

setup() {
  export GH_STUB_LOG="$BATS_TEST_TMPDIR/gh.log"
  mkdir -p "$BATS_TEST_TMPDIR/bin"
  cat > "$BATS_TEST_TMPDIR/bin/gh" <<'SH'
#!/usr/bin/env bash
set -e
echo "$@" >> "$GH_STUB_LOG"
if [[ $1 == "auth" && $2 == "status" ]]; then
  exit 0
fi
if [[ $1 == "pr" && $2 == "view" ]]; then
  if [[ $GH_STUB_MODE == "notbump" ]]; then
    echo "update README"
  else
    echo "bump foo from 0.1.0 to 0.1.1"
  fi
  exit 0
fi
if [[ $1 == "pr" && $2 == "checks" ]]; then
  if [[ $GH_STUB_MODE == "failci" ]]; then
    echo "× failing"
  else
    echo "✔ success"
  fi
  exit 0
fi
exit 0
SH
  chmod +x "$BATS_TEST_TMPDIR/bin/gh"
  export PATH="$BATS_TEST_TMPDIR/bin:$PATH"
}

@test "default dry run" {
  run $BATS_TEST_DIRNAME/../gh-pr-approve-and-auto-merge 42 --yes
  [ "$status" -eq 0 ]
  [[ "$output" == *"(dry-run) Would approve & merge #42"* ]]
  ! grep -q "pr merge" "$GH_STUB_LOG"
}

@test "run mode merges" {
  log="$BATS_TEST_TMPDIR/out.log"
  run $BATS_TEST_DIRNAME/../gh-pr-approve-and-auto-merge 42 --run --yes --log-file "$log"
  [ "$status" -eq 0 ]
  grep -q "pr review 42" "$GH_STUB_LOG"
  grep -q "pr merge 42" "$GH_STUB_LOG"
  grep -q "Merged #42" "$log"
}

@test "skips when not a bump" {
  GH_STUB_MODE=notbump run $BATS_TEST_DIRNAME/../gh-pr-approve-and-auto-merge 5 --run --yes
  [ "$status" -eq 0 ]
  [[ "$output" == *"Not a dependency bump"* ]]
  ! grep -q "pr merge" "$GH_STUB_LOG"
}

@test "skips when CI fails" {
  GH_STUB_MODE=failci run $BATS_TEST_DIRNAME/../gh-pr-approve-and-auto-merge 6 --run --yes
  [ "$status" -eq 0 ]
  [[ "$output" == *"CI not green"* ]]
  ! grep -q "pr merge" "$GH_STUB_LOG"
}

@test "warns and skips invalid PR numbers" {
  run $BATS_TEST_DIRNAME/../gh-pr-approve-and-auto-merge 1a2b --run --yes
  [ "$status" -eq 0 ]
  [[ "$output" == *"Invalid PR number"* ]]
  ! grep -q "pr view" "$GH_STUB_LOG"
}

@test "creates log directory" {
  logdir="$BATS_TEST_TMPDIR/sub/dir"
  logfile="$logdir/out.log"
  run $BATS_TEST_DIRNAME/../gh-pr-approve-and-auto-merge 42 --run --yes --log-file "$logfile"
  [ "$status" -eq 0 ]
  grep -q "pr merge 42" "$GH_STUB_LOG"
  grep -q "Merged #42" "$logfile"
}
