# Liquid TQFT in Lean 4

Machine-checked categorical infrastructure for topological quantum field theory,
developed against Lean 4 and Mathlib v4.28.0. The repository combines the
condensed-mathematics target, Frobenius/cobordism presentation, concrete
finite-state theory, and ribbon-category input layer in one build.

## Status

**Proof-placeholder-free.** 13 Lean source files, approximately 4,800 lines,
no executable proof-admission placeholders, and no custom axioms. Every listed
formal result is machine-checked.

Recent milestones close two earlier gaps:

- `Cob2Symmetric.lean` constructs a symmetric monoidal algebraic source and a
  strong braided monoidal interpretation for every commutative Frobenius datum
  in a symmetric target.
- `DijkgraafWittenSymmetric.lean` transports the diagonal torus and genus-word
  computations through the symmetric quotient and its packaged theory.
- `DijkgraafWittenDisconnected.lean` evaluates specified finite tensor products
  of connected genus words: `k` components contribute the scalar `n ^ k`.
- `Ribbon.lean` now proves both tensor-pairing triangle identities and quantum
  dimension multiplicativity, as well as quantum-trace cyclicity and symmetry
  of the S-pairing.

## Formalized components

| File | Machine-checked content |
| --- | --- |
| `Ribbon.lean` | Balanced/ribbon categories, quantum trace and dimension, S-pairing, and multiplicativity |
| `RequestProject/BanachEmbedding.lean` | Seminormed-group presheaves and the condensed realization |
| `RequestProject/LiquidTQFT.lean` | Abstract braided-monoidal theory and transfer |
| `RequestProject/MonoidalViaLocalization.lean` | Monoidal structure transported through localization |
| `RequestProject/FullnessCounterexample.lean` | Presheaf-level counterexample to fullness |
| `RequestProject/SheafFullnessCounterexample.lean` | Sheaf-level non-fullness |
| `RequestProject/EmbeddingProfile.lean` | Failure to reflect isomorphisms and preserve epimorphisms |
| `RequestProject/Cob2.lean` | Base Frobenius presentation and ordinary interpretation functor |
| `RequestProject/Cob2Monoidal.lean` | Lawful monoidal quotient and strong monoidal interpretation |
| `RequestProject/Cob2Symmetric.lean` | Symmetric quotient and strong braided monoidal interpretation |
| `RequestProject/DijkgraafWitten.lean` | Rank-`n` diagonal Frobenius theory and torus/genus-word evaluations |
| `RequestProject/DijkgraafWittenSymmetric.lean` | Base-to-symmetric functor bridge and transported torus/genus evaluations |
| `RequestProject/DijkgraafWittenDisconnected.lean` | Disconnected genus-list evaluations through the packaged symmetric theory |

## Headline results

- `CondensedAb` is used with Mathlib's symmetric monoidal sheaf structure.
- The realization `SemiNormedGrp -> CondensedAb` is additive, faithful, and
  left exact, but not full, not conservative, and not right exact.
- The base Frobenius interpretation descends through lawful monoidal and
  symmetric algebraic quotients; `toSymmetricTQFT2d` packages the final strong
  braided monoidal functor.
- On `Fin n -> ℤ`, the diagonal Frobenius datum evaluates the torus and every
  connected genus word in the defined family as multiplication by `n` on the
  monoidal unit; a specified tensor product of `k` such closed words evaluates
  as multiplication by `n ^ k`. These equalities persist through the packaged
  symmetric theory.
- In every ribbon category, quantum dimension is multiplicative under tensor
  product and the S-pairing is symmetric.

## Scope limits

- The tensor on `CondensedAb` is the ambient sheaf tensor, not the liquid tensor;
  no exactness of tensoring is proved here.
- The cobordism quotients are algebraic generators-and-relations constructions.
  No normal-form theorem, universal classification property, or equivalence
  with geometric oriented bordisms is claimed.
- The diagonal model is a finite-state Frobenius toy theory, not the conventional
  finite-group Dijkgraaf-Witten state-sum construction.
- The ribbon layer does not construct a modular tensor category, surgery theory,
  Kirby-move invariant, or Reshetikhin-Turaev TQFT.

## Building

```bash
lake exe cache get
lake build
```

The GitHub Actions workflow runs the full `lake build` on pushes and pull
requests to `main`.

## Roadmap

1. Prove connected normal forms in the symmetric algebraic source.
2. Prove the symmetric quotient's commutative-Frobenius universal property.
3. Construct geometric oriented `2Cob` and identify it with the algebraic source.
4. Develop modular tensor category and surgery/Kirby-move infrastructure on top
   of the ribbon layer.
5. Connect suitable liquid or nuclear targets to rigorously constructed
   infinite-dimensional field theories.

## Paper

The accompanying paper and synchronized source snapshot are maintained at
[`Liquid-TQFT-lean-CMCM`](https://github.com/seanm27lol/Liquid-TQFT-lean-CMCM).

## Attribution

The symmetric monoidal structure on condensed abelian groups relies on Mathlib
infrastructure built by Joël Riou and Dagur Asgeirsson. Formal verification
was assisted by Aristotle (Harmonic), Claude (Anthropic), and OpenAI Codex.

## License

MIT
