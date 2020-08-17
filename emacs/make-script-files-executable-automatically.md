# Make script files executable automatically

Emacs can automatically make script files (those with [shebangs][shebang-wiki]
at the beginning) executable on file save:

```elisp
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
```

[shebang-wiki]: https://en.wikipedia.org/wiki/Shebang_(Unix)
