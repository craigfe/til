# Managing dotfile symlinks with Stow

Managing system config files is a perennial problem for Linux users. Each time I
migrate machines I find another dotfile that wasn't stored in a Git repository
anywhere. The standard solution for this is to keep dotfiles in a [central
repository][dotfiles], and have each machine set up symbolic links into this
repository:

- `~/dotfiles/git/gitconfig` ↦ `~/.gitconfig`
- `~/dotfiles/zsh/zshrc` ↦ `~/.zshrc`
- `~/dotfiles/zsh/.config/alacritty/` ↦ `~/dotfiles/alacritty/`
- etc. etc.

These symlinks become a maintenance burden: each new config file needs a
manually-created symlink and each new machine needs all its symlinks to be
re-created. Fortunately, there's a two-decade-old program, [`stow`][stow], that
solves the problem. Now my machine migration process is _much_ easier:

```bash
ᐅ git clone https://github.com/CraigFe/dotfiles.git
ᐅ cd dotfiles
ᐅ stow --dotfiles --target=~ */
```

(I don't even need to pass options to `stow`, thanks to the [`.stowrc`
file][stowrc].) There are plenty of [`stow` tutorials][stow-tutorial] online,
which I will not re-create here. Enjoy :slightly_smiling_face:

[dotfiles]: https://github.com/CraigFe/dotfiles
[stow]: https://www.gnu.org/software/stow/
[stowrc]: https://www.gnu.org/software/stow/manual/html_node/Resource-Files.html
[stow-tutorial]: https://www.google.com/search?q=managing+dotfiles+with+GNU+stow
