{-# OPTIONS --rewriting --prop #-}
module Syntax where

open import Utils

-- SYNTAX

record ICTT-Sorts : Set1 where
  field
    -- Computational CWF sorts
    CCon : Set
    CSub : CCon → CCon → Set
    CTm : CCon → Set

    -- Logical CWF sorts
    LCon : Set
    LSub : LCon → LCon → Set
    Ty : LCon → Set
    LTm : ∀ LΓ → Ty LΓ → Set
    
    -- Total CWF sorts
    Con : LCon → CCon → Set
    Sub : ∀ {LΓ LΔ CΓ CΔ} → Con LΓ CΓ → Con LΔ CΔ → LSub LΓ LΔ → CSub CΓ CΔ → Set
    Tm : ∀ {LΓ CΓ} → (Γ : Con LΓ CΓ) → (A : Ty LΓ) → LTm LΓ A → CTm CΓ → Set


module ICTT-InSorts (Sorts : ICTT-Sorts) where
  open ICTT-Sorts Sorts

  variable  
    IΓ IΓ' IΔ IΔ' : LCon
    CΓ CΓ' CΔ CΔ' : CCon
    Ia Ia' Ib Ib' : LTm _ _
    Ca Ca' Cb Cb' : CTm _
    Iσ Iσ' Iσ'' : LSub _ _
    Cσ Cσ' Cσ'' : CSub _ _
    

  record ICTT-Ctors : Set1 where
    field 
      -- COMPUTATIONAL

      ∙ : CCon
      _, : CCon → CCon
      id : CSub CΓ CΓ
      _∘_ : CSub CΓ CΓ' → CSub CΔ CΓ → CSub CΔ CΓ'
      id∘ : id ∘ Cσ ＝ Cσ
      ∘id : Cσ ∘ id ＝ Cσ
      ∘assoc : (Cσ ∘ Cσ') ∘ Cσ'' ＝ Cσ ∘ (Cσ' ∘ Cσ'')

      ε : CSub CΓ ∙
      εη : Cσ ＝ ε
      
      p : CSub (CΓ ,) CΓ
      q : CTm (CΓ ,)
      _[_] : CTm CΔ → (Cσ : CSub CΓ CΔ) → CTm CΓ
      _,_ : (Cσ : CSub CΓ CΔ) → CTm CΓ → CSub CΓ (CΔ ,)
      p∘, : p ∘ (Cσ , Ca) ＝ Cσ
      p,q : (p {CΓ} , q) ＝ id
      ,∘ : (Cσ , Ca) ∘ Cσ' ＝ ((Cσ ∘ Cσ') , (Ca [ Cσ' ]))

      lam : CTm (CΓ ,) → CTm CΓ
      app : CTm CΓ → CTm (CΓ ,)

      [id] : Ca [ id ] ＝ Ca
      [∘] : Ca [ Cσ ∘ Cσ' ] ＝ (Ca [ Cσ ]) [ Cσ ]
      q[,] : q [ Cσ , Ca ] ＝ Ca

      -- Logical

  -- record ICTT-Log : Set1 where
  --   field 
      -- LOGICAL


    -- ε : CSub CΓ ∙
    
  
  

-- -- CONSTRUCTORS

-- -- Computational CWF sorts are the 'realisers', i.e. computational content
-- -- this is just untyped LC
-- data CCon : Set
-- data CSub : CCon → CCon → Set
-- data CTm : CCon → Set

-- -- Irrelevant CWF sorts are the 'logical content'
-- data ICon : Set
-- data ISub : ICon → ICon → Set
-- data Ty : ICon → Set
-- data ITm : ∀ IΓ → Ty IΓ → Set

-- variable  
--   IΓ IΓ' IΔ IΔ' : ICon
--   CΓ CΓ' CΔ CΔ' : CCon
--   Ia Ia' Ib Ib' : ITm _ _
--   Ca Ca' Cb Cb' : CTm _
--   Iσ Iσ' Iσ'' : ISub _ _
--   Cσ Cσ' Cσ'' : CSub _ _

-- -- Displayed CWF sorts are indexed over computational and logical content.
-- data Con : ICon → CCon → Set
-- data Sub : ∀ {IΓ IΔ CΓ CΔ} → Con IΓ CΓ → Con IΔ CΔ → ISub IΓ IΔ → CSub CΓ CΔ → Set
-- data Tm : ∀ {IΓ CΓ} → (Γ : Con IΓ CΓ) → (A : Ty IΓ) → ITm IΓ A → CTm CΓ → Set

-- variable  
--   Γ Γ' Δ Δ' : Con _ _
--   A A' B B' : Ty _
--   a a' b b' : Tm _ _ _ _
--   σ σ' σ'' : Sub _ _ _ _

-- -- Irr

-- data ICon where
--   ∙ : ICon
--   _,_ : ∀ IΓ → Ty IΓ → ICon
  
-- data Ty where
--   _[_] : Ty IΔ → ISub IΓ IΔ → Ty IΓ
--   U : Ty IΓ
--   El : ITm IΓ U → Ty IΓ
--   Π : (A : Ty IΓ) → Ty (IΓ , A) → Ty IΓ
--   Π0 : (A : Ty IΓ) → Ty (IΓ , A) → Ty IΓ
--   Π-ID : (A : Ty IΓ) → Ty (IΓ , A) → Ty IΓ
  
-- data ISub where
--   id : ISub IΓ IΓ
--   _∘_ : ISub IΓ IΓ' → ISub IΔ IΓ → ISub IΔ IΓ'
--   p : ISub (IΓ , A) IΓ
--   _,_ : (Iσ : ISub IΓ IΔ) → ITm IΓ (A [ Iσ ]) → ISub IΓ (IΔ , A)
--   ε : ISub IΓ ∙
  
-- data ITm where
--   _[_] : ITm IΔ A → (Iσ : ISub IΓ IΔ) → ITm IΓ (A [ Iσ ]) 
--   q : ITm (IΓ , A) (A [ p ])

--   lam : ITm (IΓ , A) B → ITm IΓ (Π A B)
--   app : ITm IΓ (Π A B) → ITm (IΓ , A) B

--   lam0 : ITm (IΓ , A) B → ITm IΓ (Π0 A B)
--   app0 : ITm IΓ (Π0 A B) → ITm (IΓ , A) B

--   lam-ID : ITm (IΓ , A) B → ITm IΓ (Π-ID A B)
--   app-ID : ITm IΓ (Π-ID A B) → ITm (IΓ , A) B
  
-- -- Displayed CWF constructors

-- data Con where
--   ∙ : Con ∙ ∙
--   _,_ : (Γ : Con IΓ CΓ) → (A : Ty IΓ) → Con (IΓ , A) (CΓ ,)
--   _,I_ : (Γ : Con IΓ CΓ) → (A : Ty IΓ) → Con (IΓ , A) CΓ
  
-- data Sub where
--   id : Sub Γ Γ id id
--   _∘_ : Sub Γ Γ' Iσ Cσ → Sub Δ Γ Iσ' Cσ' → Sub Δ Γ' (Iσ ∘ Iσ') (Cσ ∘ Cσ')
--   ε : Sub Γ ∙ ε ε 
  
--   p : Sub (Γ , A) Γ p p
--   _,_ : Sub Γ Δ Iσ Cσ → Tm Γ (A [ Iσ ]) Ia Ca → Sub Γ (Δ , A) (Iσ , Ia) (Cσ , Ca)
  
--   pI : Sub (Γ ,I A) Γ p id
--   _,I_ : Sub Γ Δ Iσ Cσ → (Ia : ITm IΓ (A [ Iσ ])) → Sub Γ (Δ ,I A) (Iσ , Ia) Cσ

-- data Tm where
--   _[_] : Tm Δ A Ia Ca → Sub Γ Δ Iσ Cσ → Tm Γ (A [ Iσ ]) (Ia [ Iσ ]) (Ca [ Cσ ])
--   q : Tm (Γ , A) (A [ p ]) q q
  
--   lam : Tm (Γ , A) B Ia Ca → Tm Γ (Π A B) (lam Ia) (lam Ca)
--   app : Tm Γ (Π A B) Ia Ca → Tm (Γ , A) B (app Ia) (app Ca)

--   lam0 : Tm (Γ ,I A) B Ia Ca → Tm Γ (Π0 A B) (lam0 Ia) Ca
--   app0 : Tm Γ (Π0 A B) Ia Ca → Tm (Γ ,I A) B (app0 Ia) Ca

--   lam-ID : Tm (Γ , A) B Ia q → Tm Γ (Π-ID A B) (lam-ID Ia) (lam q)
--   app-ID : Tm Γ (Π-ID A B) Ia Ca → Tm (Γ , A) B (app-ID Ia) q

-- -- EQUATIONS


