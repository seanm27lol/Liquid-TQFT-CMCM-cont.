import RequestProject.Cob2TraceClosure

/-!
# Frobenius pair closure for connected spiders

This file records two elementary sewing operations on the verified ordered
connected spiders. Attaching the Frobenius cup to both inputs, or the
Frobenius cap to both outputs, creates one handle. Closing both sides creates
two handles. The existing cup--endomorphism--braid--cap trace closure agrees
with either one-sided pair closure in the closed case.

These are statements in the algebraic symmetric Cob2 presentation. They do
not identify the words with smooth cobordisms, construct geometric gluing, or
prove an excision theorem.
-/

open CategoryTheory MonoidalCategory

noncomputable section

namespace Cob2Spider

/-- The Frobenius coevaluation word, viewed as a two-output connected spider. -/
def frobeniusCup :
    (⟨0⟩ : Cob2SymmetricObj) ⟶ (⟨2⟩ : Cob2SymmetricObj) :=
  Cob2Symmetric.unit ≫ Cob2Symmetric.comul

/-- The Frobenius evaluation word, viewed as a two-input connected spider. -/
def frobeniusCap :
    (⟨2⟩ : Cob2SymmetricObj) ⟶ (⟨0⟩ : Cob2SymmetricObj) :=
  Cob2Symmetric.mul ≫ Cob2Symmetric.counit

@[simp]
theorem frobeniusCup_eq_spider :
    frobeniusCup = spider 0 2 0 := by
  simp [frobeniusCup, spider_eq]
  change Cob2Symmetric.unit ≫ Cob2Symmetric.comul =
    Cob2Symmetric.unit ≫ (Cob2Symmetric.comul ≫ 𝟙 (⟨2⟩ : Cob2SymmetricObj))
  simp

@[simp]
theorem frobeniusCap_eq_spider :
    frobeniusCap = spider 2 0 0 := by
  simp [frobeniusCap, spider_eq]

/-- Close both outputs of a connected two-output spider with the Frobenius cap. -/
def outputPairClosure (a g : ℕ) :
    (⟨a⟩ : Cob2SymmetricObj) ⟶ (⟨0⟩ : Cob2SymmetricObj) :=
  spider a 2 g ≫ frobeniusCap

/-- Closing the two outputs of a connected spider creates one handle. -/
theorem outputPairClosure_eq_spider (a g : ℕ) :
    outputPairClosure a g = spider a 0 (g + 1) := by
  rw [outputPairClosure, frobeniusCap_eq_spider,
    spider_comp a 2 0 g 0 (by omega)]

/-- Close both inputs of a connected two-input spider with the Frobenius cup. -/
def inputPairClosure (b g : ℕ) :
    (⟨0⟩ : Cob2SymmetricObj) ⟶ (⟨b⟩ : Cob2SymmetricObj) :=
  frobeniusCup ≫ spider 2 b g

/-- Closing the two inputs of a connected spider creates one handle. -/
theorem inputPairClosure_eq_spider (b g : ℕ) :
    inputPairClosure b g = spider 0 b (g + 1) := by
  rw [inputPairClosure, frobeniusCup_eq_spider,
    spider_comp 0 2 b 0 g (by omega)]
  simp [Nat.add_comm]

/-- Close both inputs and both outputs of a connected two-by-two spider. -/
def twoSidedPairClosure (g : ℕ) :
    (⟨0⟩ : Cob2SymmetricObj) ⟶ (⟨0⟩ : Cob2SymmetricObj) :=
  frobeniusCup ≫ spider 2 2 g ≫ frobeniusCap

/-- Closing both pairs of a connected two-by-two spider creates two handles. -/
theorem twoSidedPairClosure_eq_spider (g : ℕ) :
    twoSidedPairClosure g = spider 0 0 (g + 2) := by
  rw [twoSidedPairClosure, ← Category.assoc,
    show frobeniusCup ≫ spider 2 2 g = inputPairClosure 2 g by rfl,
    inputPairClosure_eq_spider,
    show spider 0 2 (g + 1) ≫ frobeniusCap = outputPairClosure 0 (g + 1) by rfl,
    outputPairClosure_eq_spider]

/-- The existing categorical-trace-shaped closure agrees with output-pair sewing. -/
theorem handleTraceClosure_eq_outputPairClosure (g : ℕ) :
    handleTraceClosure g = outputPairClosure 0 g := by
  rw [handleTraceClosure_eq_spider, outputPairClosure_eq_spider]

/-- The existing categorical-trace-shaped closure agrees with input-pair sewing. -/
theorem handleTraceClosure_eq_inputPairClosure (g : ℕ) :
    handleTraceClosure g = inputPairClosure 0 g := by
  rw [handleTraceClosure_eq_spider, inputPairClosure_eq_spider]

end Cob2Spider
