# Move to the root of the current repository

`git rev-parse` gives assorted useful information about the structure of Git
repositories:

```bash
git rev-parse --show-toplevel                   # Root of the current git repository
git rev-parse --show-superproject-working-tree  # If this is a submodule, root of its parent
```

These can be used to quickly `cd` to the parent root (if it exists) or the
current root (if this repository is not a submodule):

```bash
alias gr="cd $(git rev-parse --show-superproject-working-tree --show-toplevel | head -n 1)"
```

Going further, we can use a script to get the root of an arbitrary nesting of
Git repositories:

```bash
#!/bin/sh
set -eu

PARENT=$(git rev-parse --show-toplevel)

while :; do
    TMP="$(git -C "$PARENT" rev-parse --show-superproject-working-tree)"
    [ -n "$TMP" ] || break
    PARENT="$TMP"
done

echo "$PARENT"
```

We can also improve the alias to handle error cases properly:

```bash
alias gr='GR_ROOT="$(git-root)" && cd "$GR_ROOT" && unset GR_ROOT'
```
