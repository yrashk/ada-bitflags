# Bitfields for Ada

A generic, SPARK-verified implementation of typed bitflags.

## Verification

```sh
alr exec -- gnatprove -P proof/bitflags_proof.gpr -U
```

GNATprove analyzes generic code through concrete instantiations. The proof project covers a nominal
two-option instance plus minimum-width and fully occupied 8- and 64-bit instances.

## Limitations

* GNAT-only.
* `Flags_Type` must have a binary modulus and at least one bit per option.
* An option's declaration position determines its bit; enumeration representation clauses are ignored.
