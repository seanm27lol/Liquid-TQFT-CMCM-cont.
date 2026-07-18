# Liquid TQFT in Lean 4

Machine-checked categorical infrastructure for topological quantum field theory,
developed against Lean 4 and Mathlib v4.28.0. The repository now keeps the
Frobenius/condensed-mathematics development and the ribbon-category input layer
in one build.

## Status

The repository contains nine Lean source files (approximately 2,900 lines).
Everything under `RequestProject/` is sorry-free. The only proof placeholder is
the pre-existing `qDim_tensor` lemma in `Ribbon.lean`, whose obstruction is the
normalization of duals of tensor products. There are no custom axioms.

The current source is an algebraic presentation and interpretation layer. It
does **not** yet prove that the presentation is equivalent to the geometric
oriented bordism category, and it does not yet construct non-compact
Chern–Simons theory.

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

1. Strengthen the `Cob2Mor` quotient with tensor/interchange/coherence laws and
   construct the induced strong monoidal functor.
2. Add swap naturality, hexagons, and involutivity for a symmetric presentation.
3. Prove connected genus normal forms before identifying the presentation with
   geometric oriented `2Cob`.
4. Instantiate normalized finite-group Dijkgraaf–Witten theories; retain the
   ribbon layer as input toward three-dimensional Reshetikhin–Turaev theory.

## Attribution

The symmetric monoidal structure on condensed abelian groups relies on Mathlib
infrastructure built by Joel Riou and Dagur Asgeirsson. Formal verification was
assisted by Aristotle (Harmonic); synthesis and prompt engineering by Claude
(Anthropic).

## License

MIT
