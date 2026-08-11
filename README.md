# Liquid TQFT in Lean 4

Machine-checked categorical infrastructure for topological quantum field theory,
developed against Lean 4 and Mathlib v4.28.0. The repository combines the
condensed-mathematics target, Frobenius/cobordism presentation, concrete
finite-state theory, combinatorial surface normal forms, a first geometric
substrate, and the ribbon-category input layer in one build.

## Status

**Proof-placeholder-free.** 49 Lean source files—48 under `RequestProject`
plus `Ribbon.lean`—and 17,414 lines, with no executable proof-admission
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
- `Cob2TraceClosure.lean` writes the Frobenius self-pairing closure of an
  ordered handle in cup--endomorphism--braid--cap form and proves that it is
  the closed connected spider with one additional handle.
- `Cob2PairClosure.lean` proves that sewing the Frobenius cup to both inputs or
  the Frobenius cap to both outputs of an ordered connected spider creates one
  handle, that closing both pairs creates two, and that the two one-sided
  closed presentations agree with the trace-shaped handle closure.
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
  unit equations. `Cob2SurfaceWiring.lean` verifies boundary-reindexing
  cylinders, and `Cob2SurfaceSymmetric.lean` packages these data as a lawful
  symmetric monoidal structure on `SurfaceNFObj`.
- `Cob2SurfaceSignature.lean` defines the component-and-genus signature of
  every raw presentation word, proves all original Frobenius relations sound,
  and descends it to an ordinary functor.
  `Cob2SurfaceSignatureSymmetric.lean` proves soundness for the strengthened
  monoidal and symmetric relations and packages the descended signature as a
  strong braided monoidal functor. `Cob2ConnectedReification.lean` reifies
  every canonical connected code by an ordered spider and proves injectivity
  of its genus parameter.
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
- `FiniteDiagonalFrobenius.lean` generalizes the diagonal theory to every
  finite label type over a commutative ring, proves that connected genus words
  evaluate by the label cardinality, and turns label permutations into
  Frobenius and interpreted-theory isomorphisms.
- `Cob2OrdinaryShadow.lean` gives a conditional comparison interface: supplied
  strong braided monoidal source, sector, and decategorification functors
  compose to an ordinary theory whose generator carries a reconstructed
  commutative Frobenius datum. It constructs none of the geometric-Langlands
  comparison functors itself.
- `Cob2GeometricPrelude.lean` bundles compact smooth one-manifolds, compact
  smooth surfaces with boundary, and smooth boundary parametrizations, and
  computes the model boundary of a cylinder carrier.
- `Cob2OrientedGeometricPrelude.lean` defines smooth tangent orientations as
  locally compatible fields in tangent-bundle trivializations, proves
  reversal involutive, records preservation under diffeomorphisms, and
  packages oriented one-manifold and surface carriers.
- `Cob2GeometricCylinder.lean` proves that the two endpoint inclusions into
  \(M\times[0,1]\) are smooth, immersive, topologically embedded, and cover
  exactly the model boundary, then packages the resulting
  boundary-parametrized smooth cylinder cobordism.
- `Cob2GeometricBoundaryCollar.lean` promotes every stored boundary
  parametrization to a homeomorphism onto the model boundary, packages
  genuine smooth collar-neighborhood data, proves that a collar image
  contains a neighborhood of each boundary point, and freezes the
  boundary-first/inward-normal convention with reversed incoming and retained
  outgoing orientations. General collar existence is not asserted.
- `Cob2GeometricCylinderCollar.lean` constructs an explicit smooth two-ended
  collar of the verified cylinder, using disjoint one-third neighborhoods of
  its incoming and outgoing boundaries, and proves embedding and local-
  diffeomorphism conditions with explicit partial inverses. The separate
  oriented-collar compatibility theorem is not yet supplied.
- `Cob2GeometricTopologicalGluing.lean` glues two chosen-collared oriented
  cobordisms along their common parametrized boundary by a `TopCat` pushout.
  It proves injectivity of both piece maps, characterizes every cross-piece
  identification by a unique seam point, preserves an injective outer
  boundary, proves compactness and the pushout universal property, and checks
  collar-zero and orientation cancellation on the seam. No smooth structure
  on the pushout is asserted.
- `Cob2GeometricHausdorffGluing.lean` identifies the canonical map from the
  disjoint union of the two compact surface carriers as a quotient map,
  proves its kernel relation closed, and deduces that the glued carrier is
  Hausdorff.
- `Cob2GeometricSecondCountableGluing.lean` proves that a continuous
  surjection from a compact second-countable space to a Hausdorff space has a
  countable basis, then applies this theorem to the canonical gluing quotient.
- `Cob2GeometricLocalEuclideanGluing.lean` joins the two chosen half-collars
  into an embedded signed seam collar, transports charts through the piece
  inclusions off the seam, covers every pushout point, and constructs a
  `SurfaceModelSpace` charted space with an `IsManifold surfaceModel 0`
  theorem. Smooth transition compatibility and geometric composition remain
  open.
- `Cob2GeometricSeamOrientation.lean` proves that the normal reflection in a
  signed seam chart reconciles the opposite boundary-first orientations of
  two composable collars. It does not construct the missing smooth atlas or
  a global orientation on the glued carrier.
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
| `RequestProject/Cob2TraceClosure.lean` | Frobenius trace closure of an ordered handle and its one-handle genus shift |
| `RequestProject/Cob2PairClosure.lean` | Input, output, and two-sided Frobenius pair closures for connected spiders |
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
| `RequestProject/Cob2SurfaceWiring.lean` | Boundary-reindexing cylinder wirings and compatibility with graph gluing |
| `RequestProject/Cob2SurfaceSymmetric.lean` | Lawful monoidal and symmetric structures on `SurfaceNFObj` |
| `RequestProject/Cob2SurfaceSignature.lean` | Signature of every raw presentation word and its descent to an ordinary functor |
| `RequestProject/Cob2SurfaceSignatureSymmetric.lean` | Symmetric-relation soundness and strong braided monoidal signature semantics |
| `RequestProject/Cob2ConnectedReification.lean` | Connected spider signatures, reification, and genus injectivity |
| `RequestProject/Cob2Universal.lean` | Evaluation and interpretation functors for Frobenius data |
| `RequestProject/Cob2UniversalEquivalence.lean` | One reconstruction triangle and the converse objectwise comparison |
| `RequestProject/Cob2UniversalConverse.lean` | Converse natural reconstruction and the full commutative-Frobenius universal equivalence |
| `RequestProject/DijkgraafWitten.lean` | Rank-`n` diagonal Frobenius theory and torus/genus-word evaluations |
| `RequestProject/DijkgraafWittenSymmetric.lean` | Base-to-symmetric functor bridge and transported torus/genus evaluations |
| `RequestProject/DijkgraafWittenDisconnected.lean` | Disconnected genus-list evaluations through the packaged symmetric theory |
| `RequestProject/FiniteDiagonalFrobenius.lean` | Finite-label diagonal Frobenius data, cardinality evaluations, and relabeling isomorphisms |
| `RequestProject/Cob2OrdinaryShadow.lean` | Conditional ordinary-shadow composition and Frobenius reconstruction interface |
| `RequestProject/Cob2GeometricPrelude.lean` | Unoriented smooth one-manifolds, surfaces with boundary, boundary parametrizations, and cylinder carrier |
| `RequestProject/Cob2OrientedGeometricPrelude.lean` | Locally compatible tangent orientations, reversal, diffeomorphism preservation, and oriented carriers |
| `RequestProject/Cob2GeometricCylinder.lean` | Smooth embedded endpoint parametrization and packaged boundary-parametrized cylinder cobordism |
| `RequestProject/Cob2GeometricBoundaryCollar.lean` | Boundary homeomorphism, smooth collar data, boundary-neighborhood theorem, and oriented incoming/outgoing compatibility |
| `RequestProject/Cob2GeometricCylinderCollar.lean` | Explicit two-ended cylinder collar, embedding, and local-diffeomorphism witnesses |
| `RequestProject/Cob2GeometricTopologicalGluing.lean` | Compact topological pushout, exact seam identifications, outer boundary, universal descent, and collar/orientation seam compatibility |
| `RequestProject/Cob2GeometricHausdorffGluing.lean` | Closed-kernel quotient theorem and Hausdorffness of the compact topological gluing carrier |
| `RequestProject/Cob2GeometricSecondCountableGluing.lean` | Countable-basis descent along compact Hausdorff quotients and second countability of the gluing carrier |
| `RequestProject/Cob2GeometricLocalEuclideanGluing.lean` | Signed seam collar, covering local charts, and C⁰ manifold-with-corners structure on the gluing carrier |
| `RequestProject/Cob2GeometricSeamOrientation.lean` | Determinant and boundary-first orientation compatibility for normal reflection across a composable seam |

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
  cycle-rank subtraction is nontruncated. Closing the canonical handle
  endomorphism through its Frobenius self-pairing produces the closed
  connected spider with one additional handle. More generally, attaching the
  Frobenius cup to both inputs or the Frobenius cap to both outputs of a
  connected spider raises its genus by one; doing both raises it by two.
- Every finite permutation of a boundary `Fin n` has a represented adjacent-
  swap word, and a chosen representative is absorbed on either or both sides
  of every ordered connected spider.
- Component-and-genus normal forms form a genuine symmetric monoidal category
  under graph gluing and disjoint union. Every presentation word has a
  functorial normal-form signature; the signature respects the strengthened
  symmetric quotient and is strong braided monoidal. Every canonical
  connected normal form is represented by an ordered spider; at fixed arities
  its genus parameter is injective.
- On `Fin n -> ℤ`, the diagonal Frobenius datum evaluates the torus and every
  connected genus word in the defined family as multiplication by `n` on the
  monoidal unit; a specified tensor product of `k` such closed words evaluates
  as multiplication by `n ^ k`. These equalities persist through the packaged
  symmetric theory.
- More generally, the diagonal datum on `ι → R` for a finite label type `ι`
  evaluates the same connected genus family by `Fintype.card ι`, and every
  permutation of `ι` induces an isomorphism of its Frobenius datum and
  interpreted algebraic theory.
- Smooth tangent orientations are represented by pointwise module
  orientations compatible in local tangent-bundle trivializations. For every
  stored closed smooth one-manifold \(M\), the two endpoint inclusions into
  \(M\times[0,1]\) form a smooth manifold embedding onto the model boundary
  and define `cylinderCobordism M`. Every stored boundary parametrization is
  also a homeomorphism onto the boundary subtype; a chosen smooth collar is a
  genuine boundary neighborhood, and its differential can be required to
  implement the reversed-incoming/retained-outgoing orientation convention.
  The cylinder now has an explicit smooth two-ended collar with disjoint
  incoming and outgoing images and verified local partial inverses.
  Two such compatible pieces have a canonical compact topological pushout:
  the piece maps and unglued outer boundary are injective, and a left point
  equals a right point exactly when both come from the same parametrized seam
  point. The canonical map from the disjoint union is a quotient map with
  closed kernel relation, so the glued carrier is Hausdorff; compact-fiber
  descent of a countable basis also proves that it is second countable. A
  signed seam collar and transported off-seam charts cover the carrier and
  give it a `SurfaceModelSpace` charted structure satisfying the C⁰
  manifold-with-corners condition. On the tangent model, reflecting the
  inward-normal coordinate reconciles the two boundary-first orientations at
  every composable seam; smooth chart compatibility and a global glued
  orientation are still not asserted.
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
- The symmetric surface signature is a semantics functor from the algebraic
  presentation to finite component/genus normal forms. It is not yet proved
  full, faithful, essentially surjective, or an equivalence, and it does not
  supply arbitrary-word normal-form completeness or uniqueness.
- The geometric layer now has locally compatible tangent orientations, a
  verified boundary-parametrized cylinder, a topological boundary
  homeomorphism, bundled smooth collar data, and an explicit
  reversed-incoming/retained-outgoing orientation-compatibility predicate. It
  includes an explicit two-ended collar of the verified cylinder, but does
  not yet prove that collar satisfies the separate orientation predicate. It
  also has the compact topological pushout of two chosen-collared pieces, with
  exact control of its seam and outer-boundary identifications, and the
  pushout is proved Hausdorff and second countable and equipped with covering
  C⁰ surface charts. It does not prove that the new atlas has smooth
  transitions or is smoothly compatible with the original piece atlases,
  prove that every surface admits the bundled collar, provide smooth gluing,
  prove the cylinder is an identity for a composition
  law, form a diffeomorphism quotient or geometric bordism category, classify
  surfaces, or compare the geometric source with the algebraic source.
- The diagonal model is a finite-state Frobenius toy theory, not the conventional
  finite-group Dijkgraaf-Witten state-sum construction.
- The ordinary-shadow bridge is conditional data and reconstruction. It does
  not construct factorization homology, character stacks, quantum groups,
  twisted sheaf categories, or a quantum geometric Langlands/Fourier--Mukai
  equivalence.
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

1. Prove representation independence for finite boundary permutations and an
   arbitrary-word normal-form/completeness theorem, then determine whether the
   strong braided surface-signature functor is an equivalence.
2. Prove orientation compatibility for the explicit two-ended cylinder
   collar, package the oriented cylinder as chosen-collared data, and then
   investigate collar existence beyond the bundled-data interface.
3. Upgrade the verified compact Hausdorff second-countable C⁰ surface atlas on
   the seam pushout to a smooth surface with boundary by proving transition
   compatibility with the chosen collars; prove the verified cylinder is an
   identity, then define
   composition up to diffeomorphism and symmetric disjoint union for a
   geometric oriented `2Cob`, then prove its comparison with the
   algebraic/combinatorial source.
4. Develop modular tensor category and surgery/Kirby-move infrastructure on top
   of the ribbon layer.
5. Construct the categorified inputs required by the ordinary-shadow
   interface—such as selected factorization-homology sectors and explicit
   decategorification functors—before making any Langlands comparison claim.
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
