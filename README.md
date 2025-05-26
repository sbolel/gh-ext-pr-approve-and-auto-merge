# gh-pr-approve-and-auto-merge (GitHub CLI extension)

[![buy me a coffee][coffee-badge]][coffee-url]

A small extension for the [GitHub CLI](https://cli.github.com/) that helps
approve and auto-merge dependency update pull requests. It checks that CI is
passing and then approves and merges the selected PRs.

## Requirements

- [GitHub CLI](https://cli.github.com/) (`gh`) authenticated with the target
  repository.
- A POSIX shell environment.
- To run the tests you need [`bats`](https://bats-core.readthedocs.io/).

## Installation

Install directly from the repository:

```bash
gh extension install sinanbolel/gh-ext-pr-approve-and-auto-merge
```

Or from a local clone:

```bash
gh extension install .
```

## Usage

Approve and auto-merge multiple PRs by number or comma-separated list:

```bash
gh pr approve-and-auto-merge 123 124 125
# or
gh pr approve-and-auto-merge 123,124,125
```

Run `gh pr approve-and-auto-merge --help` to see all available options.

## Testing

Execute the smoke tests with `bats`:

```bash
bats test
```

[coffee-badge]: https://img.shields.io/badge/Buy%20Me%20a%20Coffee-ffdd00?&logo=buy-me-a-coffee&logoColor=black
[coffee-url]: https://buymeacoffee.com/sinanbolel
