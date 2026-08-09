import RequestProject.Cob2Spider

/-!
# Trace closure in the symmetric Cob2 presentation

This file packages the Frobenius self-pairing closure of the ordered handle
endomorphism. The closure is written in the same cup--endomorphism--braid--cap
shape as the categorical quantum trace: the cup is `unit ≫ comul`, the cap is
`mul ≫ counit`, and the middle endomorphism acts on one of the two circles.

The resulting word is proved equal, in the verified symmetric algebraic
quotient, to the closed connected spider with one additional handle. Thus
this is a finite algebraic sewing theorem. It does not construct a geometric
cobordism category, compare the word with a smooth seam pushout, or assert an
excision theorem for a state assignment.
-/

open CategoryTheory MonoidalCategory

noncomputable section

namespace Cob2Spider

/-- The Frobenius self-pairing closure of the genus-`g` handle endomorphism. -/
def handleTraceClosure (g : ℕ) :
    (⟨0⟩ : Cob2SymmetricObj) ⟶ (⟨0⟩ : Cob2SymmetricObj) :=
  Cob2Symmetric.unit ≫ Cob2Symmetric.comul ≫
    (handle g ⊗ₘ 𝟙 (⟨1⟩ : Cob2SymmetricObj)) ≫
    (β_ (⟨1⟩ : Cob2SymmetricObj) (⟨1⟩ : Cob2SymmetricObj)).hom ≫
    Cob2Symmetric.mul ≫ Cob2Symmetric.counit

/-- Closing a genus-`g` handle endomorphism creates the closed connected
genus-`g + 1` spider. -/
theorem handleTraceClosure_eq_spider (g : ℕ) :
    handleTraceClosure g = spider 0 0 (g + 1) := by
  unfold handleTraceClosure
  simp only [MonoidalCategory.tensorHom_id]
  slice_lhs 2 3 => rw [comul_handle]
  have hmul :
      (β_ (⟨1⟩ : Cob2SymmetricObj) (⟨1⟩ : Cob2SymmetricObj)).hom ≫
          Cob2Symmetric.mul = Cob2Symmetric.mul := by
    simpa using Cob2Symmetric.canonicalFrobenius.mul_comm'
  simp only [Category.assoc]
  slice_lhs 4 5 => rw [hmul]
  have hhandle : Cob2Symmetric.comul ≫ Cob2Symmetric.mul = handle 1 := by
    simp
  slice_lhs 3 4 => rw [hhandle]
  slice_lhs 2 3 => rw [← handle_add]
  simp [spider_eq]

end Cob2Spider
