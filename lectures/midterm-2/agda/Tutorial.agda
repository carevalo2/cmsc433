{- Agda Tutorial -}

open import Function using (case_of_)

{-
   Agda is a dependently typed functional programming language that
   allows you to reason about the programs you write!

   To install Agda, you can just run:

     cabal install Agda

   Or follow the instructions here:
     https://agda.readthedocs.io/en/latest/getting-started/installation.html

   Warning, this might take a while! 
   Once installed, you can run to get things setup with emacs.

     agda-mode setup

   Then you can C-c C-l to load this (or any Agda) file interactively.
   Note - there is no syntax highlighting before loading the file.
   That's because the naming conventions in Agda are so liberal that
   we need type information to distinguish between terms, types, and
   other things! 
-}

{- Data Types: Natural Numbers -}

data Nat : Set where
  z : Nat
  s : Nat -> Nat

{- Defining datatypes is similar to the GADT syntax of Haskell -
   We're defining the Nat datatype, with two constructors, Z
   and S, the latter of which takes another Nat as an argument
   to construct a new one.

   Key differences:
   * The type annotation uses single colons.
   * Naming is liberal (e.g. constructors can be lower case)
   * The type of Nat is Set (similar to the kind * in Haskell)

   Defining a term is similar to Haskell. And a function on
   Nats is as well. 
-}

two : Nat
two = s (s z)

_+_ : Nat â†’ Nat â†’ Nat
z + y = y
(s x) + y = s (x + y)

{- The addition function is defined by pattern matching.
   Names between underscores define operators. The caveat
   is that you need to separate them by whitespace. Things
   like "1+1" are actually valid names!

   Also, note the arrows! Agda allows arbitrary unicode,
   so both -> and â†’ are valid to construct function types. 
-}

{- Programming by case analysis: One of the cool features of Agda
   is support for type-guided interactive programming. You can
   add holes, and then ask the type checker for information (C-c C-e),
   case split (C-c C-c), navigate goals (C-c C-f, C-c C-b), try
   to automatically fill holes (C-c C-a), fill them (C-c C-SPC)
   or refine them (C-c C-r).
   -}

_*_ : Nat â†’ Nat â†’ Nat
x * y = {!!}

{- Polymorphism:
   Note that this defines a function id that takes
   a type (something of type Set), and then can use
   that type in its own type -- more on that later!
-}

id : (A : Set) -> A -> A
id A x = {!!}

ex_id : Nat
ex_id = {!!}

{- To avoid providing type arguments, we can use curly
   braces to declare them implicit. -}

id' : {A : Set} â†’ A â†’ A
id' x = {!!}

ex_id' : Nat
ex_id' = {!!}

{- Polymorphic datatypes -}
data List (A : Set) : Set where
  []   : List A
  _::_ : A â†’ List A â†’ List A

{- Operators can appear _everywhere_ -}

data _Ã—_ (A B : Set) : Set where
  _,_ : A â†’ B â†’ A Ã— B
infixr 4 _,_

fst : {A B : Set} â†’ A Ã— B -> A
fst p = {!!}

{- Totality checking - Agda checks for:
   * Pattern completeness
   * Termination
-}

foo : Nat â†’ Nat
foo x = {!!}

{- Dependent types

   Example: Vectors (length-indexed lists)
-}

data Vec (A : Set) : Nat â†’ Set where
  {- Vector of length 0 -}
  []  : Vec A z
  {- Vector of length s n -}
  _::_ : {n : Nat} â†’ A â†’ Vec A n â†’ Vec A (s n)
infixr 5 _::_

_++v_ : {A : Set} {m n : Nat} â†’ Vec A m â†’ Vec A n â†’ Vec A (m + n)
xs ++v ys = {!!}

{- Curry Howard Correspondence

   Key idea:
   Propositions correspond to  types
      Proofs    correspond to programs

   For each proposition, we can ask two questions:
   * How do we prove this proposition?
   * What can we deduce from it?

   Conjunction: P âˆ§ Q
   ------------------
   * Deduce:
     - Given a proof of P âˆ§ Q, we can deduce that both P and Q hold.
     - So given a proof r of P âˆ§ Q
       we can get a proof of P (let's call it _)
        and a proof of Q       (let's call it _).
   * To Prove:
     - We need a proof of P and a proof of Q.
     - A proof of P âˆ§ Q is a 





















   Therefore P âˆ§ Q corresponds to pairs P Ã— Q.

   Disjunction: P âˆ¨ Q
   ------------------
   * Deduce:
     - Given a proof of P âˆ§ Q, we can deduce that
     
   * To Prove
     - We need a proof of P _or_ a proof of Q.

   Therefore P âˆ¨ Q correspons to ?
     -}

{- TODO: Data type for disjunction -}





















data Either (A B : Set) : Set where
  Left : A â†’ Either A B
  Right : B â†’ Either A B

{-

   Implication: P â‡’ Q
   ------------------
   * To Prove:
     - Given a proof of P, we need to construct a proof of Q.

   * Deduce:
     - Given a proof of P â‡’ Q, and a proof of P,
       we can combine the two proofs into a proof of Q.
     - ...

   Therefore P â‡’ Q corresponds to ? 

-}

{-
   Truth: true
   -----------
   * To Prove: We can always prove true. Therefore we can
     assume there is some trivial proof tt of true.
   * Deduce: No new information.

   It corresponds to the following type (similar to unit
   in Haskell)
-}

data âŠ¤ : Set where
  tt : âŠ¤

{-
   Negation: false
   ---------------
   * To Prove:
   * Deduce:
-}

data âŠ¥ : Set where
  -- no constructors

absurd : (A : Set) -> âŠ¥ -> A
absurd A f = {!!}

{- Now we can take _any_ formula in propositional logic, translate it
   to a type in Agda, and then prove the formula by writing down a
   program of that type! And if the program typechecks, it is a
   machine-checked proof of our original proposition! -}

{- Example: P implies P -}
proofEx1 : {P : Set} â†’ P â†’ P
proofEx1 p = {!!}

{- Example: Transitivity.
   (If P implies Q and Q implies R then P implies R)
-}

proofEx2 : {P Q R : Set} -> (P â†’ Q) â†’ (Q â†’ R) â†’ (P â†’ R)
proofEx2 pq qr = {!!}

impossibleProof : {P Q : Set} â†’ P â†’ Q
impossibleProof p = {!!}

{- Predicate Logic -}

{- If propositions are types, then we can define new
   propositions by defining new data types. -}

data IsEven : Nat â†’ Set where
  even-z  : IsEven z
  even-ss : {n : Nat} â†’ IsEven n â†’ IsEven (s (s n))
   
data IsOdd : Nat â†’ Set where
  odd-sz  : IsOdd (s z)
  odd-ss : {n : Nat} â†’ IsOdd n â†’ IsOdd (s (s n))

2-is-even : IsEven two
2-is-even = {!!}

three : Nat
three = {!!}

1-is-not-even : IsEven (s z) â†’ âŠ¥ 
1-is-not-even pf = {!!}

3-is-not-even : IsEven three â†’ âŠ¥ 
3-is-not-even pf = {!!}

five : Nat
five = s (s (s (s (s z))))

5-is-not-even : IsEven five â†’ âŠ¥
5-is-not-even pf = {!!} 

{- Quantification: -}
double : Nat â†’ Nat
double z = z
double (s n) = s (s (double n))

double-is-even : (n : Nat) â†’ IsEven (double n)
double-is-even n = {!!} 

ind-principle-nat : (P : Nat â†’ Set) â†’ P z â†’ ({n : Nat} â†’ P n â†’ P (s n)) â†’ ((n : Nat) â†’ P n)
ind-principle-nat P pf-z pf-s n = {!!} 

every-nat-is-even-or-odd : (n : Nat) â†’ Either (IsEven n) (IsOdd n)
every-nat-is-even-or-odd n = case n of Î» where
                               z   -> _
                               (s z) -> _
                               (s (s m)) -> _                               














