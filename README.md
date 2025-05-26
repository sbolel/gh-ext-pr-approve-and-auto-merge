# gh-pr-approve-and-auto-merge (GitHub CLI extension)

Automates approval and auto-merging of dependency PRs. By default it runs in
preview mode; pass `--run` to actually approve and merge:

```bash
gh pr approve-and-auto-merge 123,124,125 --dry-run
gh pr approve-and-auto-merge 42 --run --yes
```

See `gh pr approve-and-auto-merge --help` for full options.
