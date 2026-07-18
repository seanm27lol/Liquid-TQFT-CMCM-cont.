# RibbonLean: Balanced and Ribbon Categories for Lean 4

Balanced monoidal categories, ribbon categories, quantum traces, and the
S-pairing, formalized in Lean 4 against Mathlib v4.28.0. This structure layer
(twists, ribbon compatibility, quantum trace) is new to Mathlib.

Part of a program toward formally verified topological quantum field theory;
see the companion repository
[Liquid-tft-lean-CM4CM-](https://github.com/seanm27lol/Liquid-tft-lean-CM4CM-).

## Status

One file, `Ribbon.lean`. Machine-checked: the `BalancedMonoidalCategory` and
`RibbonCategory` classes; every symmetric right-rigid category is ribbon with
the identity twist; the quantum trace `qTrace` and dimension `qDim`; a sliding
toolbox (coevaluation/evaluation absorption, twist slides); **trace cyclicity**
`qTrace (f ≫ g) = qTrace (g ≫ f)`; symmetry of the S-pairing.

One open lemma (`sorry`): `qDim_tensor`, multiplicativity of quantum dimension,
blocked on the dual-of-a-tensor normalization. No custom axioms.

## Building

```bash
lake exe cache get
lake build
```

## Attribution

Formal verification assisted by Aristotle (Harmonic); synthesis and prompt
engineering by Claude (Anthropic). MIT license.
