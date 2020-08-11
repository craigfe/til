# Diffing two OCaml ASTs

It's possible to use `ppx_tools/dumpast` to dump the parsed form of an OCaml
AST. This is very useful when writing PPXs or discovering some dark corner of
OCaml's syntax.

```bash
ᐅ opam install ppx_tools
ᐅ ocamlfind ppx_tools/dumpast -t 'unit Lwt.t'
unit Lwt.t
==>
{ptyp_desc =
  Ptyp_constr ({txt = Ldot (Lident "Lwt", "t")},
   [{ptyp_desc = Ptyp_constr ({txt = Lident "unit"}, []);
     ptyp_loc_stack = []}]);
 ptyp_loc_stack = []}
=========
```

To take it a step further, you can combine [process
substitution][process-substitution] with a nice diffing algorithm like
[`patdiff`][patdiff] to quickly determine how two ASTs differ:

```bash
ᐅ opam install patdiff
ᐅ patdiff <(ocamlfind ppx_tools/dumpast -t '[ `Black of int ]') \
          <(ocamlfind ppx_tools/dumpast -t '[ `Black of & int ]')
------ /proc/self/fd/12
++++++ /proc/self/fd/13
@|-1,11 +1,11 ============================================================
!|[ `Black of & int ]
 |==>
 |{ptyp_desc =
 |  Ptyp_variant
 |   ([{prf_desc =
-|       Rtag ({txt = "Black"}, false,
+|       Rtag ({txt = "Black"}, true,
 |        [{ptyp_desc = Ptyp_constr ({txt = Lident "int"}, []);
 |          ptyp_loc_stack = []}])}],
 |   Closed, None);
 | ptyp_loc_stack = []}
 |=========
```

I set up a wrapper for this:

```bash
#!/bin/bash
set -euo pipefail

command -v patdiff >/dev/null 2>&1 || { echo >&2 "Error: missing dependency 'patdiff'"; exit 1; }

if [ $# -lt 2 ]; then
    echo >&2 "Usage: diff-ast [options] <prev> <next>"
    exit 1
fi

ARGS="${*: 1:$#-2}"
PREV="${*: -2:1}"
NEXT="${*: -1:1}"

patdiff <(ocamlfind ppx_tools/dumpast "$ARGS" "$PREV") \
        <(ocamlfind ppx_tools/dumpast "$ARGS" "$NEXT")
```

which allows me to quickly diff expressions, patterns and types with `diff-ast
{-e,-p,-t}` respectively.

[process-substitution]: https://www.gnu.org/software/bash/manual/bash.html#Process-Substitution
[patdiff]: https://github.com/janestreet/patdiff
