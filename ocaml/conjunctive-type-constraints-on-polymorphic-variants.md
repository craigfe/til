# Conjunctive type constraints on polymorphic variants

The OCaml type-checker often has to unify _conjunctions_ of constraints for a
particular type. This process produces the the "`expected <foo> got <bar>`"
error messages we know and love:

```ocaml
# let f x = succ x + int_of_string x;;
(*                                 ^
 * Error: This expression has type int but an expression was expected of type string *)
```

For simple structural types like functions and tuples, the type-checker will
even simplify failing constraints to produce nicer error messages:

```ocaml
# let (_ : ('a * 'a)) = (1, "foo");;
(*                          ^^^^^
 * Error: This expression has type string but an expression was expected of type int *)
```

In this case, the type-checker simplified the unsolvable constraint `('a, 'a) =
(int, string)` down to `int = string` before reporting the error message. Nice!
Unfortunately, for complex structural types like polymorphic variants, the
type-checker is not so kind to us:

```ocaml
(* Redefine [succ] and [int_of_string] to take arguments from a [`Foo] variant. *)
# let succ (`Foo i) = succ i;;
# let int_of_string (`Foo s) = int_of_string s;;

# let f' x = succ x + int_of_string x;;
val f : [< `Foo of string & int ] -> int = <fun>
```

In this case, our function `f'` is behaviourally equivalent to the rejected
function `f` from before, but is not rejected by the type-checker. Instead, it
gets given the perplexing argument type `` [< `Foo of string & int ] ``. There
are no values of this type, so `f'` can never be called. Unfortunately, we don't
get the same exhaustivity checks for this empty type as is possible elsewhere.

This is a case of so-called ["full
specifications"](https://caml.inria.fr/pub/docs/manual-ocaml/types.html#tag-spec-full)
of variant tags, which allow conjunctions (`&`) to appear in the type:

```
tag-spec-full ::= `tag-name [ of [&] typeexpr { & typeexpr }]
```

These allow writing all manner of variant tags that are actually unusable in
practice:

```ocaml
type 'a t1 = [< `Foo of int & string ] as 'a
(** Both [ `Foo of int ] and [ `Foo of string ]. Unsatisfiable. *)

type 'a t2 = [< `Foo of & int ] as 'a
(** Both [ `Foo ] (with no arguments) and [ `Foo of int ]. Unsatisfiable. *)

type ('a, 'b) t3 = [< `Foo of int * 'b ] as 'a
(** Both [ `Foo of int ] and [ `Foo of 'b ]. Unsatisfiable when 'b <> int. *)
```

Such types are not intended for programmer use, but you might see them in
inferred types or in cryptic type-checking error messages.
:slightly_smiling_face:
