import RequestProject.Cob2GeometricTopologicalGluing

/-!
# Orientation compatibility across a geometric cobordism seam

This file proves the model-tangent orientation calculation needed at a smooth gluing seam.  The
transition between the two inward collar coordinates fixes the boundary-tangent direction and
reflects the inward-normal direction.  That reflection reverses a two-dimensional orientation.
At the same time, the established incoming/outgoing convention reverses the one-dimensional
boundary orientation.  The two sign changes cancel, so the boundary-first product orientations
on the two sides agree after the normal reflection.

This is an orientation prerequisite for constructing an oriented smooth seam atlas.  It does not
prove smooth compatibility of the topological gluing charts, construct a global smooth structure
or orientation on the pushout, define smooth cobordism composition, prove cylinder orientation
compatibility, or establish identity or associativity laws.
-/

namespace Cob2GeometricPrelude

noncomputable section

/-- The tangent-model transition which fixes the seam tangent and reflects the inward normal. -/
def seamNormalReflection : SurfaceTangentSpace ≃ₗ[ℝ] SurfaceTangentSpace :=
  (LinearEquiv.refl ℝ LineTangentSpace).prodCongr (LinearEquiv.neg ℝ)

/-- Negation has determinant `-1` on the one-dimensional tangent model. -/
theorem lineTangentNeg_det :
    LinearMap.det ((LinearEquiv.neg ℝ : LineTangentSpace ≃ₗ[ℝ] LineTangentSpace) :
      LineTangentSpace →ₗ[ℝ] LineTangentSpace) = -1 := by
  rw [← LinearMap.det_toMatrix (PiLp.basisFun 2 ℝ (Fin 1))]
  simp [LinearMap.toMatrix_apply]

/-- The normal reflection has determinant `-1` on the surface tangent model. -/
theorem seamNormalReflection_det :
    LinearMap.det (seamNormalReflection :
      SurfaceTangentSpace →ₗ[ℝ] SurfaceTangentSpace) = -1 := by
  rw [seamNormalReflection, LinearEquiv.coe_prodCongr, LinearMap.det_prodMap]
  change LinearMap.det (LinearMap.id : LineTangentSpace →ₗ[ℝ] LineTangentSpace) *
      LinearMap.det ((LinearEquiv.neg ℝ : LineTangentSpace ≃ₗ[ℝ] LineTangentSpace) :
        LineTangentSpace →ₗ[ℝ] LineTangentSpace) = -1
  rw [LinearMap.det_id]
  simp only [one_mul]
  exact lineTangentNeg_det

/-- Reflecting the inward normal reverses every orientation of the surface tangent model. -/
theorem seamNormalReflection_map_orientation
    (o : Orientation ℝ SurfaceTangentSpace (Fin 2)) :
    Orientation.map (Fin 2) seamNormalReflection o = -o := by
  apply (Orientation.map_eq_neg_iff_det_neg o seamNormalReflection (by
    simp [SurfaceTangentSpace, LineTangentSpace])).2
  rw [seamNormalReflection_det]
  norm_num

private theorem reindexedProdOrientation_neg_of_neg
    (b bneg p : Module.Basis (Fin 1) ℝ LineTangentSpace)
    (hneg : bneg.orientation = -b.orientation) :
    ((bneg.prod p).reindex finSumFinEquiv).orientation =
      -((b.prod p).reindex finSumFinEquiv).orientation := by
  let f : LineTangentSpace ≃ₗ[ℝ] LineTangentSpace :=
    b.equiv bneg (Equiv.refl (Fin 1))
  let F : SurfaceTangentSpace ≃ₗ[ℝ] SurfaceTangentSpace :=
    f.prodCongr (LinearEquiv.refl ℝ LineTangentSpace)
  have hmap : b.map f = bneg := by
    simp [f]
  have hfneg : LinearMap.det (f : LineTangentSpace →ₗ[ℝ] LineTangentSpace) < 0 := by
    apply (b.orientation_comp_linearEquiv_eq_neg_iff_det_neg f).1
    rw [hmap]
    exact hneg
  have hFneg : LinearMap.det (F : SurfaceTangentSpace →ₗ[ℝ] SurfaceTangentSpace) < 0 := by
    dsimp only [F]
    rw [LinearEquiv.coe_prodCongr, LinearMap.det_prodMap]
    change LinearMap.det (f : LineTangentSpace →ₗ[ℝ] LineTangentSpace) *
        LinearMap.det (LinearMap.id : LineTangentSpace →ₗ[ℝ] LineTangentSpace) < 0
    simpa using hfneg
  have hprodmap : (b.prod p).map F = bneg.prod p := by
    ext i : 1
    rcases i with i | i
    · fin_cases i
      simp [F, f, Module.Basis.prod_apply]
    · fin_cases i
      simp [F, f, Module.Basis.prod_apply]
  have horientation : (bneg.prod p).orientation = -(b.prod p).orientation := by
    rw [← hprodmap]
    exact (b.prod p).orientation_comp_linearEquiv_eq_neg_iff_det_neg F |>.2 hFneg
  rw [Module.Basis.orientation_reindex, Module.Basis.orientation_reindex,
    horientation, Orientation.reindex_neg]

/-- Reversing the boundary tangent reverses the boundary-first product orientation. -/
@[simp]
theorem boundaryFirstInwardOrientation_neg
    (o : Orientation ℝ LineTangentSpace (Fin 1)) :
    boundaryFirstInwardOrientation (-o) = -boundaryFirstInwardOrientation o := by
  apply reindexedProdOrientation_neg_of_neg
  simp

/-- Reflecting the inward normal reconciles opposite oriented seam tangents. -/
theorem boundaryFirstInwardOrientation_map_seamNormalReflection
    (o : Orientation ℝ LineTangentSpace (Fin 1)) :
    Orientation.map (Fin 2) seamNormalReflection
        (boundaryFirstInwardOrientation (-o)) =
      boundaryFirstInwardOrientation o := by
  rw [boundaryFirstInwardOrientation_neg, Orientation.map_neg,
    seamNormalReflection_map_orientation]
  exact neg_neg (boundaryFirstInwardOrientation o)

namespace CollaredOrientedParametrizedSmoothCobordism

/-- The boundary-first product orientations on a composable seam agree after normal reflection. -/
theorem seam_boundaryFirstInwardOrientations_match_after_reflection
    (M N P : OrientedClosedSmoothOneManifold)
    (x : N.toClosedSmoothOneManifold.M) :
    Orientation.map (Fin 2) seamNormalReflection
        (boundaryFirstInwardOrientation
          (orientedBoundaryOrientationAt M N (Sum.inr x))) =
      boundaryFirstInwardOrientation
        (orientedBoundaryOrientationAt N P (Sum.inl x)) := by
  rw [seam_boundary_orientations_cancel]
  exact boundaryFirstInwardOrientation_map_seamNormalReflection _

end CollaredOrientedParametrizedSmoothCobordism

end


end Cob2GeometricPrelude
