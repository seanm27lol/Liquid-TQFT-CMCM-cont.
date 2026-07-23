# Liquid TQFT in Lean 4

Machine-checked categorical infrastructure for topological quantum field theory,
developed against Lean 4 and Mathlib v4.28.0. The repository combines the
condensed-mathematics target, Frobenius/cobordism presentation, concrete
finite-state theory, and ribbon-category input layer in one build.

## Status

**Proof-placeholder-free.** 22 Lean source files, approximately 7,700 lines,
no executable proof-admission placeholders, and no custom axioms. Every listed
formal result is machine-checked.

Recent milestones close the original interchange-and-braiding gap and advance
the algebraic classification program:

- `Cob2Symmetric.lean` constructs a symmetric monoidal algebraic source and a
  strong braided monoidal interpretation for every commutative Frobenius datum
  in a symmetric target.
- `Cob2Canonical.lean` equips its generating circle with the canonical
  commutative Frobenius datum and proves that interpreting this datum
  reconstructs the identity, including as a bundled lax braided functor.
- `Cob2Spider.lean`, `Cob2Permutation.lean`, and
  `Cob2BoundaryPermutations.lean` establish an ordered connected-spider
  composition law and a first layer of boundary transpositions.
- `Cob2NormalForm.lean`, `Cob2SurfaceComposition.lean`, and
  `Cob2SurfaceGraphBound.lean` construct component-and-genus codes modulo
  relabeling, descend finite-multigraph gluing to those classes, prove its
  connected positive-boundary genus formula, and verify the Euler bound that
  prevents truncated genus subtraction.
- `Cob2Universal.lean` constructs functors in both directions between
  commutative Frobenius data and strong braided functors out of the algebraic
  source. `Cob2UniversalEquivalence.lean` proves that evaluation after
  interpretation is naturally isomorphic to the identity and constructs the
  objectwise comparison for the converse.
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
| `RequestProject/Cob2Canonical.lean` | Canonical source Frobenius datum and braided identity reconstruction |
| `RequestProject/Cob2Spider.lean` | Ordered connected spiders and their positive-boundary composition law |
| `RequestProject/Cob2Permutation.lean` | First-two-wire invariance of ordered merge and split combs |
| `RequestProject/Cob2BoundaryPermutations.lean` | Arbitrary-position adjacent boundary transpositions and involutivity |
| `RequestProject/Cob2NormalForm.lean` | Component-and-genus codes modulo component relabeling |
| `RequestProject/Cob2SurfaceComposition.lean` | Indexed multigraph gluing and descended normal-form composition |
| `RequestProject/Cob2SurfaceGraphBound.lean` | Euler bound and nontruncation of the gluing genus formula |
| `RequestProject/Cob2Universal.lean` | Evaluation and interpretation functors for Frobenius data |
| `RequestProject/Cob2UniversalEquivalence.lean` | One reconstruction triangle and the converse objectwise comparison |
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
- The arity-one source object is itself a commutative Frobenius datum, and its
  interpretation reconstructs the symmetric algebraic source. Evaluation and
  interpretation are functorial, with evaluation-after-interpretation
  naturally isomorphic to the identity on commutative Frobenius data.
- Ordered connected spiders compose with genus
  `g + (b - 1) + h` across a positive boundary of arity `b`. The same formula
  is verified for the finite multigraph composition of connected
  component-and-genus codes, and the generic Euler bound proves that its
  cycle-rank subtraction is nontruncated.
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
  The component-and-genus quotient now has a well-defined binary gluing
  operation, but its associativity/unit laws and the arbitrary-word
  signature/reification theorem are not yet proved.
- Only one triangle of the expected commutative-Frobenius universal
  equivalence is complete. Naturality and braided-monoidal coherence of the
  converse objectwise comparison remain open, so no full universal
  classification property is claimed.
- No equivalence with geometric oriented bordisms, smooth-surface
  classification, or diffeomorphism/gluing-invariance theorem is claimed.
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

1. Prove the category laws for component-and-genus gluing, define the signature
   of arbitrary presentation words, and prove reification/completeness.
2. Prove naturality and monoidal coherence of the converse reconstruction and
   assemble the full commutative-Frobenius universal equivalence.
3. Construct geometric oriented `2Cob` and identify it with the completed
   algebraic/combinatorial source.
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
