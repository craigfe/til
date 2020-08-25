# Vim editing mode for `utop`

As of version 2.5.0, `utop` has support for a [`vi` editing
mode](https://github.com/ocaml-community/utop/pull/315). Type the following
directive (or add it to your `~/.ocamlinit` file) to get access to an
approximation of `vi` modal editing:

```
#edit_mode_vi
```

This mode supports the standard `vi` verbs (`c` for "change", `d` for "delete",
`y` for "yank", etc.) and modifiers (`i` for "insert", `a` for "around", `t` for
"to", `f` for "find"), although as ever with `vi` approximations it can be
somewhat frustrating in the features that it _doesn't_ provide. Still, better
than nothing!
