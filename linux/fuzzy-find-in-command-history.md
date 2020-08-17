# Fuzzy-find in command history

Using [`fzf`](https://github.com/junegunn/fzf), it's easy to interactively
select a command from your shell history. Using `zsh`'s `print -z`, this
selected command can be pushed to the editing buffer stack.

```bash
fh() {
    print -z $(history |\
                   fzf --no-sort --tac |\
                   sed -E 's/ *[0-9]*\*? *//; s/\\/\\\\/g')
}
```

Source: the [`fzf` examples](https://github.com/junegunn/fzf/wiki/examples)
page.
