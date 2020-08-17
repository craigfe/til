# Pipe to and from the system clipboard

[`xsel`](https://linux.die.net/man/1/xsel) is useful for programatically
interacting with the system clipboard:

```bash
xsel --clipboard --input   # stdin ↦ clipboard
xsel --clipboard --output  # clipboard ↦ stdout
```

I alias these to `cbi` and `cbo` respectively. Now we can tinker with the
clipboard in many ways:

```bash
ls | tee >(cbi)              # Intercept command output in the clipboard
cbo | sort | uniq -c | cbi   # Sort and count all lines in the clipboard
watch xsel -bo               # Track what's stored in the clipboard
```
