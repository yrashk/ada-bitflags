# Bitfields for Ada

A generic, SPARK-verified implementation of typed bitflags.

## Verification

```sh
alr exec -- gnatprove -P proof/bitflags_proof.gpr -U
```

## Limitations

* GNAT-only.
* `Flags_Type` must have a binary modulus and at least one bit per option.
* An option's declaration position determines its bit; enumeration representation clauses are ignored.
