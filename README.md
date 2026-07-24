# Liquid TQFT in Lean 4

Machine-checked categorical infrastructure for topological quantum field theory,
developed against Lean 4 and Mathlib v4.28.0. The repository combines the
condensed-mathematics target, Frobenius/cobordism presentation, concrete
finite-state theory, combinatorial surface normal forms, a first geometric
substrate, and the ribbon-category input layer in one build.

## Status

**Proof-placeholder-free.** 33 Lean source files—32 under `RequestProject`
plus `Ribbon.lean`—and 12,776 lines, with no executable proof-admission
placeholders and no custom axioms. Every listed formal result is
machine-checked.

Recent milestones close the original interchange-and-braiding gap and advance
the algebraic classification program to the threshold of geometric
cobordisms:

- `Cob2Symmetric.lean` constructs a symmetric monoidal algebraic source and a
  strong braided monoidal interpretation for every commutative Frobenius datum
  in a symmetric target.
- `Cob2Canonical.lean` equips its generating circle with the canonical
  commutative Frobenius datum and proves that interpreting this datum
  reconstructs the identity, including as a bundled lax braided functor.
- `Cob2Spider.lean`, `Cob2Permutation.lean`, and
  `Cob2BoundaryPermutations.lean` establish the ordered connected-spider
  composition law and the basic boundary transpositions.
- `Cob2SpiderPermutations.lean`, `Cob2SpiderPermutationWords.lean`,
  `Cob2SpiderPermutationInvariance.lean`, and
  `Cob2FinitePermutationWords.lean` extend absorption to every adjacent
  position and every represented finite word, prove that every permutation
  of `Fin n` has such a word, and obtain incoming, outgoing, and two-sided
  spider invariance for a chosen representative.
- `Cob2NormalForm.lean`, `Cob2SurfaceComposition.lean`, and
  `Cob2SurfaceGraphBound.lean` construct component-and-genus codes modulo
  relabeling, descend finite-multigraph gluing, and verify its genus formula
  and nontruncation bound. `Cob2SurfaceCategory.lean` proves both unit laws
  and associativity and makes these normal forms a genuine category.
- `Cob2SurfaceMonoidal.lean` packages disjoint union as a bifunctor and proves
  interchange, identity preservation, and transported associativity;
  `Cob2SurfaceMonoidalCoherence.lean` proves the transported left and right
  unit equations. No `MonoidalCategory` or `SymmetricCategory` instance is
  claimed for this category.
- `Cob2SurfaceSignature.lean` defines the component-and-genus signature of
  every raw presentation word, proves all original Frobenius relations sound,
  and descends it to an ordinary functor. `Cob2ConnectedReification.lean`
  reifies every canonical connected code by an ordered spider and proves
  injectivity of its genus parameter.
- `Cob2Universal.lean` constructs functors in both directions between
  commutative Frobenius data and strong braided functors out of the algebraic
  source. `Cob2UniversalEquivalence.lean` proves that evaluation after
  interpretation is naturally isomorphic to the identity, while
  `Cob2UniversalConverse.lean` proves the natural converse reconstruction and
  assembles the full categorical equivalence.
- `DijkgraafWittenSymmetric.lean` transports the diagonal torus and genus-word
  computations through the symmetric quotient and its packaged theory.
- `DijkgraafWittenDisconnected.lean` evaluates specified finite tensor products
  of connected genus words: `k` components contribute the scalar `n ^ k`.
- `Cob2GeometricPrelude.lean` bundles compact smooth one-manifolds, compact
  smooth surfaces with boundary, and smooth boundary parametrizations, and
  computes the model boundary of a cylinder carrier. This prelude is
  deliberately unoriented and does not define geometric composition.
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
| `RequestProject/Cob2SpiderPermutations.lean` | Absorption of an adjacent transposition at every boundary position |
| `RequestProject/Cob2SpiderPermutationWords.lean` | Typed finite adjacent-swap words and merge/split absorption |
| `RequestProject/Cob2SpiderPermutationInvariance.lean` | Incoming, outgoing, and two-sided represented-word spider invariance |
| `RequestProject/Cob2FinitePermutationWords.lean` | Existence of an adjacent-swap word for every finite permutation and chosen-representative absorption |
| `RequestProject/Cob2NormalForm.lean` | Component-and-genus codes modulo component relabeling |
| `RequestProject/Cob2SurfaceComposition.lean` | Indexed multigraph gluing and descended normal-form composition |
| `RequestProject/Cob2SurfaceGraphBound.lean` | Euler bound and nontruncation of the gluing genus formula |
| `RequestProject/Cob2SurfaceCategory.lean` | Unit and associativity laws for graph gluing and the `SurfaceNFObj` category |
| `RequestProject/Cob2SurfaceMonoidal.lean` | Disjoint-union bifunctor, interchange, identity preservation, and transported associativity |
| `RequestProject/Cob2SurfaceMonoidalCoherence.lean` | Transported left and right unit equations for disjoint union |
| `RequestProject/Cob2SurfaceSignature.lean` | Signature of every raw presentation word and its descent to an ordinary functor |
| `RequestProject/Cob2ConnectedReification.lean` | Connected spider signatures, reification, and genus injectivity |
| `RequestProject/Cob2Universal.lean` | Evaluation and interpretation functors for Frobenius data |
| `RequestProject/Cob2UniversalEquivalence.lean` | One reconstruction triangle and the converse objectwise comparison |
| `RequestProject/Cob2UniversalConverse.lean` | Converse natural reconstruction and the full commutative-Frobenius universal equivalence |
| `RequestProject/DijkgraafWitten.lean` | Rank-`n` diagonal Frobenius theory and torus/genus-word evaluations |
| `RequestProject/DijkgraafWittenSymmetric.lean` | Base-to-symmetric functor bridge and transported torus/genus evaluations |
| `RequestProject/DijkgraafWittenDisconnected.lean` | Disconnected genus-list evaluations through the packaged symmetric theory |
| `RequestProject/Cob2GeometricPrelude.lean` | Unoriented smooth one-manifolds, surfaces with boundary, boundary parametrizations, and cylinder carrier |

## Headline results

- `CondensedAb` is used with Mathlib's symmetric monoidal sheaf structure.
- The realization `SemiNormedGrp -> CondensedAb` is additive, faithful, and
  left exact, but not full, not conservative, and not right exact.
- The base Frobenius interpretation descends through lawful monoidal and
  symmetric algebraic quotients; `toSymmetricTQFT2d` packages the final strong
  braided monoidal functor.
- The arity-one source object is itself a commutative Frobenius datum, and its
  interpretation reconstructs the symmetric algebraic source. Evaluation at
  the generator and interpretation are inverse up to natural isomorphism,
  giving an equivalence between commutative Frobenius data and strong braided
  functors out of the algebraic source.
- Ordered connected spiders compose with genus
  `g + (b - 1) + h` across a positive boundary of arity `b`. The same formula
  is verified for the finite multigraph composition of connected
  component-and-genus codes, and the generic Euler bound proves that its
  cycle-rank subtraction is nontruncated.
- Every finite permutation of a boundary `Fin n` has a represented adjacent-
  swap word, and a chosen representative is absorbed on either or both sides
  of every ordered connected spider.
- Component-and-genus normal forms form a genuine category under graph
  gluing. Disjoint union is a bifunctor satisfying verified interchange,
  identity, associativity, and unit equations. Every presentation word has a
  functorial normal-form signature, and every canonical connected normal form
  is represented by an ordered spider; at fixed arities its genus parameter
  is injective.
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
  Their completed commutative-Frobenius universal equivalence is an algebraic
  universal property, not a geometric bordism theorem.
- The finite-permutation result chooses a representing adjacent-swap word. It
  does not prove that two words for the same permutation evaluate to the same
  morphism or construct a categorical symmetric-group action.
- The normal-form signature is defined for arbitrary presentation words, but
  only the canonical connected codes are reified here. No arbitrary-word
  spider normal-form/completeness theorem or equivalence between
  `Cob2SymmetricObj` and `SurfaceNFObj` is claimed.
- Disjoint union on `SurfaceNFObj` is a verified bifunctor with associativity
  and unit equations, but no `MonoidalCategory` or `SymmetricCategory`
  instance, pentagon/triangle package, or symmetric braiding has yet been
  constructed.
- The geometric prelude is unoriented and describes individual parametrized
  smooth surfaces only. It has no orientation data, collars, smooth gluing,
  identity/composition laws, diffeomorphism quotient, geometric bordism
  category, surface-classification theorem, or comparison with the algebraic
  source.
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

1. Bundle the verified disjoint-union equations into monoidal and symmetric
   structure on `SurfaceNFObj`, including the required transported naturality,
   pentagon, triangle, and braiding coherence.
2. Prove representation independence for finite boundary permutations and an
   arbitrary-word normal-form/completeness theorem, then compare the symmetric
   presentation with the surface-normal-form category.
3. Add orientation, induced boundary orientation, boundary submanifolds, and
   collar data to the geometric substrate.
4. Construct smooth gluing, identity cylinders, composition up to
   diffeomorphism, and symmetric disjoint union for a geometric oriented
   `2Cob`, then prove its comparison with the algebraic/combinatorial source.
5. Develop modular tensor category and surgery/Kirby-move infrastructure on top
   of the ribbon layer.
6. Connect suitable liquid or nuclear targets to rigorously constructed
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
