# gh-pr-approve-and-auto-merge (GitHub CLI extension)

[![buy me a coffee][coffee-badge]][coffee-url]

`gh-pr-approve-and-auto-merge` approves and auto-merges dependency bump pull requests. It verifies that each PR represents a version bump and that required checks are passing before approving and merging through the GitHub CLI.

## Requirements

- [GitHub CLI](https://cli.github.com/) and an authenticated session (`gh auth login`).
- [`bats`](https://github.com/bats-core/bats-core) to run the test suite.

## Installation

Install the extension via the GitHub CLI:

```bash
gh extension install sinanbolel/gh-pr-approve-and-auto-merge
```

You can also install from a local clone:

```bash
# from inside the cloned repository
gh extension install .
```

## Usage

```bash
# preview actions without merging
gh pr approve-and-auto-merge 123,124,125 --dry-run

# approve and merge after confirmation
gh pr approve-and-auto-merge 42 --run --yes
```

Run `gh pr approve-and-auto-merge --help` for the full list of options.

## Running the tests

With `bats` installed you can run the tests with:

```bash
bats test
```

If you prefer not to install `bats` globally, invoke it with `npx`:

```bash
npx bats test
```

[coffee-badge]: https://img.shields.io/badge/Buy%20Me%20a%20Coffee-ffdd00?&logo=buy-me-a-coffee&logoColor=black
[coffee-url]: https://buymeacoffee.com/sinanbolel
