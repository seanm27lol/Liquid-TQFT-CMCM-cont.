import Mathlib.CategoryTheory.Monoidal.Braided.Basic
import Mathlib.CategoryTheory.Monoidal.Rigid.Braided

/-!
# Balanced and ribbon monoidal categories

## Mathlib rigid/braided API audit

* The zigzag identities are
  `ExactPairing.coevaluation_evaluation` and `ExactPairing.evaluation_coevaluation`, stated with
  explicit whiskering, associators, and unitors.  Their normalized monoidal-composition forms are
  `coevaluation_evaluation''` and `evaluation_coevaluation''`; reassociated simp lemmas are generated
  for the two original identities.
* For right mates, `rightAdjointMate_id` and `comp_rightAdjointMate` give identity and reversed
  composition.  The two naturality/absorption results needed below already exist in whiskered form:
  `coevaluation_comp_rightAdjointMate` and `rightAdjointMate_comp_evaluation` (both `[reassoc]`).
* Braiding naturality is available one variable at a time as
  `BraidedCategory.braiding_naturality_left` and `..._right`, jointly in tensor-morphism form as
  `BraidedCategory.braiding_naturality`, and likewise for inverse braidings as
  `braiding_inv_naturality_left`, `..._right`, and `..._naturality`.  Reassociated forms are
  generated for all of these.
* Mathlib's existing `CategoryTheory.Balanced` is the unrelated property that every morphism which
  is both mono and epi is an isomorphism.  Searches found no declarations named
  `BalancedMonoidalCategory` or `RibbonCategory`; those collision-free names are used below.
* Concrete symmetric right-rigid examples are available: `FGModuleCat K` is right rigid (under its
  field hypotheses), and finite-dimensional representation categories inherit symmetric and rigid
  structures.
* The available coherence support is `monoidal`, `monoidal_coherence`, and the category simplifier
  (`simp`/`cat_disch`).  There is no separate braided-coherence tactic in this Mathlib version;
  braided calculations use the named naturality, hexagon, unit-braiding, and symmetry lemmas.

The twist is represented as an object-indexed family of isomorphisms, rather than a natural
isomorphism `𝟭 C ≅ 𝟭 C`.  This makes the unit and tensor axioms literal equalities of isomorphisms,
while naturality remains an explicit, conveniently reusable field.
-/

open CategoryTheory CategoryTheory.MonoidalCategory

universe v u

noncomputable section

namespace CategoryTheory

/-- A balanced monoidal category is a braided monoidal category with a natural twist.

Our composition convention is left-to-right: the tensor twist is first
`θ_X ⊗ θ_Y`, then `β_{X,Y}`, then `β_{Y,X}`.
-/
class BalancedMonoidalCategory (C : Type u) [Category.{v} C] [MonoidalCategory C]
    [BraidedCategory C] where
  /-- The twist automorphism of an object. -/
  twist : ∀ X : C, X ≅ X
  /-- Naturality of the twist. -/
  twist_naturality : ∀ {X Y : C} (f : X ⟶ Y),
    f ≫ (twist Y).hom = (twist X).hom ≫ f := by cat_disch
  /-- The twist of the tensor unit is the identity. -/
  twist_unit : twist (𝟙_ C) = Iso.refl _
  /-- The balancing axiom, in left-to-right composition order. -/
  twist_tensor : ∀ X Y : C,
    twist (X ⊗ Y) = (twist X ⊗ᵢ twist Y) ≪≫ β_ X Y ≪≫ β_ Y X

namespace BalancedMonoidalCategory

variable {C : Type u} [Category.{v} C] [MonoidalCategory C] [BraidedCategory C]
  [BalancedMonoidalCategory C]

/-- Notation-free accessor for the twist. -/
abbrev θ (X : C) : X ≅ X := twist X

@[reassoc (attr := simp)]
lemma twist_naturality_hom {X Y : C} (f : X ⟶ Y) :
    f ≫ (twist Y).hom = (twist X).hom ≫ f :=
  twist_naturality f

@[reassoc (attr := simp)]
lemma twist_naturality_inv {X Y : C} (f : X ⟶ Y) :
    f ≫ (twist Y).inv = (twist X).inv ≫ f := by
  exact CommSq.w <| .vert_inv <| .mk <| twist_naturality_hom f

/-
The hom direction of the balancing axiom, unfolded.
-/
lemma twist_tensor_hom (X Y : C) :
    (twist (X ⊗ Y)).hom =
      ((twist X).hom ⊗ₘ (twist Y).hom) ≫ (β_ X Y).hom ≫ (β_ Y X).hom := by
  exact congr_arg Iso.hom (twist_tensor X Y)

/-
The inverse direction of the balancing axiom, unfolded.
-/
lemma twist_tensor_inv (X Y : C) :
    (twist (X ⊗ Y)).inv =
      (β_ Y X).inv ≫ (β_ X Y).inv ≫ ((twist X).inv ⊗ₘ (twist Y).inv) := by
  rw [twist_tensor]
  simp only [Iso.trans_inv, tensorIso_inv, Category.assoc]

end BalancedMonoidalCategory

open BalancedMonoidalCategory ExactPairing HasRightDual

/-- A ribbon category is a balanced monoidal category with chosen right duals such that the twist
commutes with right-dualization.  The compatibility is stated on hom morphisms; equality of the
inverse morphisms then follows automatically.
-/
class RibbonCategory (C : Type u) [Category.{v} C] [MonoidalCategory C] [BraidedCategory C]
    extends BalancedMonoidalCategory C, RightRigidCategory C where
  /-- The twist commutes with the right-adjoint mate construction. -/
  twist_rightDual : ∀ X : C,
    (BalancedMonoidalCategory.twist (Xᘁ)).hom =
      (BalancedMonoidalCategory.twist X).homᘁ

/-- Every symmetric right-rigid monoidal category is ribbon, with identity twist. -/
instance symmetricRibbonCategory (C : Type u) [Category.{v} C] [MonoidalCategory C]
    [SymmetricCategory C] [RightRigidCategory C] : RibbonCategory C where
  twist X := Iso.refl X
  twist_naturality f := by simp
  twist_unit := rfl
  twist_tensor X Y := by
    ext
    simp
  twist_rightDual X := by simp

variable {C : Type u} [Category.{v} C] [MonoidalCategory C] [BraidedCategory C]
  [RibbonCategory C]

/-- The quantum trace of `f : X ⟶ X` is the composite
`𝟙_ C --η--> X ⊗ Xᘁ --((f ≫ θ_X) ⊗ 𝟙)--> X ⊗ Xᘁ
 --β--> Xᘁ ⊗ X --ε--> 𝟙_ C`.
-/
def qTrace {X : C} (f : X ⟶ X) : 𝟙_ C ⟶ 𝟙_ C :=
  η_ X Xᘁ ≫
    ((f ≫ (BalancedMonoidalCategory.twist X).hom) ⊗ₘ 𝟙 (Xᘁ)) ≫
    (β_ X Xᘁ).hom ≫ ε_ X Xᘁ

/-- The quantum dimension of an object is the quantum trace of its identity. -/
def qDim (X : C) : 𝟙_ C ⟶ 𝟙_ C := qTrace (𝟙 X)

@[simp]
lemma qDim_def (X : C) : qDim X = qTrace (𝟙 X) := rfl

lemma qTrace_eq {X : C} (f : X ⟶ X) :
    qTrace f = η_ X Xᘁ ≫
      ((f ≫ (BalancedMonoidalCategory.twist X).hom) ⊗ₘ 𝟙 (Xᘁ)) ≫
      (β_ X Xᘁ).hom ≫ ε_ X Xᘁ := rfl

omit [RibbonCategory C] in
/-- Closing any exact pairing whose first object is the tensor unit gives the identity scalar. -/
lemma coevaluation_braiding_evaluation_unit (Y : C) [ExactPairing (𝟙_ C) Y] :
    η_ (𝟙_ C) Y ≫ (β_ (𝟙_ C) Y).hom ≫ ε_ (𝟙_ C) Y = 𝟙 (𝟙_ C) := by
  rw [braiding_tensorUnit_left, ← whiskerRight_iff]
  calc
    (η_ (𝟙_ C) Y ≫ ((λ_ Y).hom ≫ (ρ_ Y).inv) ≫ ε_ (𝟙_ C) Y) ▷ (𝟙_ C) =
      η_ (𝟙_ C) Y ▷ (𝟙_ C) ≫ (α_ (𝟙_ C) Y (𝟙_ C)).hom ≫
        (𝟙_ C) ◁ ε_ (𝟙_ C) Y := by monoidal
    _ = (λ_ (𝟙_ C)).hom ≫ (ρ_ (𝟙_ C)).inv := by
      rw [ExactPairing.evaluation_coevaluation]
    _ = (𝟙 (𝟙_ C)) ▷ (𝟙_ C) := by monoidal

@[simp]
lemma qTrace_unit : qTrace (𝟙 (𝟙_ C)) = 𝟙 (𝟙_ C) := by
  simp only [qTrace, BalancedMonoidalCategory.twist_unit, Iso.refl_hom,
    Category.comp_id, id_tensorHom]
  let i : HasRightDual (𝟙_ C) := RightRigidCategory.rightDual (𝟙_ C)
  simpa only [MonoidalCategory.whiskerLeft_id, Category.comp_id, Category.id_comp] using
    (@coevaluation_braiding_evaluation_unit C _ _ _
      (@rightDual C _ _ (𝟙_ C) i) i.exact)

/-
A morphism can be absorbed into a coevaluation on either leg, with the morphism on the
right leg replaced by its right mate.  This tensor-morphism orientation matches `qTrace`.
-/
lemma coevaluation_absorption {X Y : C} (f : X ⟶ Y) :
    η_ X Xᘁ ≫ (f ⊗ₘ 𝟙 (Xᘁ)) = η_ Y Yᘁ ≫ (𝟙 Y ⊗ₘ fᘁ) := by
  simpa using (coevaluation_comp_rightAdjointMate f).symm

/-
Dual evaluation absorption: a morphism can be moved from the primal leg to the dual leg as
its right mate.
-/
lemma evaluation_absorption {X Y : C} (f : X ⟶ Y) :
    (fᘁ ⊗ₘ 𝟙 X) ≫ ε_ X Xᘁ = (𝟙 (Yᘁ) ⊗ₘ f) ≫ ε_ Y Yᘁ := by
  simpa using rightAdjointMate_comp_evaluation f

/-
The twist slides past every morphism.
-/
lemma twist_slide {X Y : C} (f : X ⟶ Y) :
    f ≫ (BalancedMonoidalCategory.twist Y).hom =
      (BalancedMonoidalCategory.twist X).hom ≫ f :=
  BalancedMonoidalCategory.twist_naturality_hom f

/-
Coevaluation absorption, reassociated with a further tensor map.
-/
lemma coevaluation_absorption_tensor_assoc {X Y Z : C} (f : X ⟶ Y) (h : Y ⟶ Z)
    (k : Z ⊗ Xᘁ ⟶ 𝟙_ C) :
    η_ X Xᘁ ≫ ((f ≫ h) ⊗ₘ 𝟙 (Xᘁ)) ≫ k =
      η_ Y Yᘁ ≫ (𝟙 Y ⊗ₘ fᘁ) ≫ (h ⊗ₘ 𝟙 (Xᘁ)) ≫ k := by
  simp +decide [← Category.assoc]
  grind +suggestions

/-
The middle, braided part of trace rotation.
-/
@[reassoc]
lemma absorption_braiding {X Y : C} (f : X ⟶ Y) (h : Y ⟶ X) :
    (𝟙 Y ⊗ₘ fᘁ) ≫ (h ⊗ₘ 𝟙 (Xᘁ)) ≫ (β_ X Xᘁ).hom =
      (β_ Y Yᘁ).hom ≫ (fᘁ ⊗ₘ h) := by
  rw [← Category.assoc, MonoidalCategory.tensorHom_comp_tensorHom]
  simp only [Category.comp_id, Category.id_comp,
    BraidedCategory.braiding_naturality]

/-
Evaluation absorption after both tensor legs have acquired morphisms.
-/
@[reassoc]
lemma tensor_evaluation_absorption {X Y : C} (f : X ⟶ Y) (h : Y ⟶ X) :
    (fᘁ ⊗ₘ h) ≫ ε_ X Xᘁ =
      (𝟙 (Yᘁ) ⊗ₘ (h ≫ f)) ≫ ε_ Y Yᘁ := by
  rw [MonoidalCategory.tensorHom_def']
  grind +suggestions

/-- Sliding a morphism all the way around the closed quantum-trace diagram. -/
lemma qTrace_rotate {X Y : C} (f : X ⟶ Y) (g : Y ⟶ X) :
    qTrace (f ≫ g) =
      η_ Y Yᘁ ≫ (β_ Y Yᘁ).hom ≫
        (𝟙 (Yᘁ) ⊗ₘ (g ≫ (BalancedMonoidalCategory.twist X).hom ≫ f)) ≫ ε_ Y Yᘁ := by
  unfold qTrace
  simp only [Category.assoc]
  let h : Y ⟶ X := g ≫ (BalancedMonoidalCategory.twist X).hom
  change η_ X Xᘁ ≫ ((f ≫ h) ⊗ₘ 𝟙 (Xᘁ)) ≫
      (β_ X Xᘁ).hom ≫ ε_ X Xᘁ = _
  rw [coevaluation_absorption_tensor_assoc f h]
  rw [absorption_braiding_assoc f h]
  rw [tensor_evaluation_absorption f h]
  simp only [h, Category.assoc]

/-
Cyclicity of the quantum trace.
-/
lemma qTrace_cyclic {X Y : C} (f : X ⟶ Y) (g : Y ⟶ X) :
    qTrace (f ≫ g) = qTrace (g ≫ f) := by
  rw [qTrace_rotate f g]
  unfold qTrace
  simp only [Category.assoc]
  rw [BraidedCategory.braiding_naturality_assoc]
  rw [← twist_slide f]

/-- The S-pairing is the quantum trace of the double braiding on `X ⊗ Y`.
Nondegeneracy of this pairing is the modularity condition; no such condition is imposed here.
-/
def sPairing (X Y : C) : 𝟙_ C ⟶ 𝟙_ C :=
  qTrace ((β_ X Y).hom ≫ (β_ Y X).hom)

/-- Quantum dimension is multiplicative under tensor product.

The isolated Stage 3 blocking goal is exactly this equality.  Its proof requires expanding the
chosen right dual and exact pairing of `X ⊗ Y` and normalizing the resulting associators, braidings,
twist tensor axiom, coevaluation, and evaluation to the composite of the two closed diagrams.
-/
lemma qDim_tensor (X Y : C) : qDim (X ⊗ Y) = qDim X ≫ qDim Y := by
  sorry

/-- The S-pairing is symmetric. -/
lemma sPairing_symm (X Y : C) : sPairing X Y = sPairing Y X := by
  unfold sPairing
  exact qTrace_cyclic (β_ X Y).hom (β_ Y X).hom

end CategoryTheory