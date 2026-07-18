# Liquid TQFT in Lean 4

Machine-checked categorical infrastructure for topological quantum field theory,
developed against Lean 4 and Mathlib v4.28.0. The repository now keeps the
Frobenius/condensed-mathematics development and the ribbon-category input layer
in one build.

## Status

The repository contains ten Lean source files (approximately 3,500 lines).
Everything under `RequestProject/` is sorry-free. The only proof placeholder is
the pre-existing `qDim_tensor` lemma in `Ribbon.lean`, whose obstruction is the
normalization of duals of tensor products. There are no custom axioms.

The current source is an algebraic presentation and interpretation layer.
`Cob2Monoidal.lean` equips a strengthened quotient with a lawful monoidal
category, proves that every commutative Frobenius interpretation descends to
it, and supplies the descended functor with a strong monoidal structure. It
does **not** yet construct a braiding or symmetry on that quotient, prove that
the presentation is equivalent to the geometric oriented bordism category, or
construct non-compact Chern–Simons theory.

## Formalized components

| File | Machine-checked content |
| --- | --- |
| `Ribbon.lean` | Balanced and ribbon categories, quantum trace and cyclicity, S-pairing |
| `RequestProject/BanachEmbedding.lean` | Banach-space presheaves and the condensed embedding |
| `RequestProject/LiquidTQFT.lean` | Abstract braided-monoidal theory and transport |
| `RequestProject/MonoidalViaLocalization.lean` | Monoidal structure transported through localization |
| `RequestProject/FullnessCounterexample.lean` | Counterexample to fullness of the discrete embedding |
| `RequestProject/SheafFullnessCounterexample.lean` | Sheaf-level non-fullness |
| `RequestProject/EmbeddingProfile.lean` | Reflection and preservation limits of the embedding |
| `RequestProject/Cob2.lean` | Commutative Frobenius data, presentation quotient, and ordinary induced functor |
| `RequestProject/Cob2Monoidal.lean` | Strengthened quotient, lawful monoidal category, descended strong monoidal interpretation, and comparison with the ordinary functor |
| `RequestProject/DijkgraafWitten.lean` | Rank-`n` diagonal Frobenius theory and torus/genus-word evaluations |

The concrete theory on `Fin n → ℤ` proves that multiplication after
comultiplication is the identity and computes the standard torus and connected
genus words as multiplication by `n` on the monoidal unit. This is a genuine
non-trivial finite-state Frobenius theory, but the name `DijkgraafWitten` should
be read as motivation: a geometric bordism equivalence and the conventional
finite-group state-sum normalization remain future work.

## Building

```bash
lake exe cache get
lake build
```

The GitHub Actions workflow runs the full `lake build` on pushes and pull
requests to `main`.

## Roadmap

1. Add swap naturality, hexagons, and involutivity, then prove compatibility
   of the descended interpretation for symmetric targets.
2. Prove connected genus normal forms and the commutative-Frobenius universal
   property of the presentation.
3. Identify the completed presentation with geometric oriented `2Cob`.
4. Instantiate normalized finite-group Dijkgraaf–Witten theories; retain the
   ribbon layer as input toward three-dimensional Reshetikhin–Turaev theory.

## Attribution

The symmetric monoidal structure on condensed abelian groups relies on Mathlib
infrastructure built by Joel Riou and Dagur Asgeirsson. Formal verification was
assisted by Aristotle (Harmonic); synthesis and prompt engineering by Claude
(Anthropic).

## License

MIT
