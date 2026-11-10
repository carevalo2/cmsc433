# Source map and limits

Paths below are relative to this directory. This guide was prepared November 9,
2026. It is practice material, not an instructor announcement.

## Governing reference for question styles

`data/Midterm 2 Example - 2025.pdf` is titled **CMSC 433: Midterm Exam 2
(Spring 2025)**. It contains five 20-point questions:

| Physical PDF page | Evidence | Practice use |
| --- | --- | --- |
| 1, Q1 | Most general types or ill-typed; list comprehensions; `get`, `put`, `modify`, function-valued `State` | 01, 02, 05, 08 |
| 2, Q2 | Well-defined expression from a signature; collect `[Maybe a]`; generic monadic traversal; `State`; uninhabited generic result | 03, 05, 08 |
| 3, Q3 | Induced verification conditions for three proposed invariants of a triangle-summing program, including a post-loop increment | 06, 08 |
| 4, Q4 | Trace a recursive monadic collector under lists, `Maybe`, and `State`, including function values; implement it with `mapM` | 03, 04, 05, 08 |
| 5, Q5 | Trace a recursive summary/list helper; use it to replace all elements by a summary; optional one-call lazy binding | 07, 08 |

The Q1 text refers to an appendix, but this local PDF contains only five pages and
no separate appendix page. `reference.tex` supplies our own study reference from
the lectures and used interfaces; it is not a reconstruction of an official appendix.
The sample inconsistently writes `Triangle` / `triangle` in Q3. New questions use
one spelling consistently. The sample is not evidence of current coverage,
timing, allowed resources, or question counts for Fall 2026.

## Lecture support

| Source | Verified sections/concepts | Use |
| --- | --- | --- |
| `../../lectures/midterm-2/07-monads/Monads.hs` | Keeping track of errors; bind; Monads and do notation; Functors, Applicatives and Monads; The List Monad | Contexts, type signatures, short circuiting, list choices, applicative lifting |
| `../../lectures/midterm-2/07-monads/GenericMonads.hs` | Generic Monad Operations; General Applicative Functions | `mapM`, `sequence`, `foldM`, Kleisli composition, `join`, lifting; implementation exercises |
| `../../lectures/midterm-2/07-monads/EitherMonad.hs` | `Either` datatype; Functor and Monad instances | Fixed error parameter and success parameter; lecture extension |
| `../../lectures/midterm-2/08-state/State.hs` | Generic state transformer; `runState`; Accessing and Modifying State | Separate state/result; `get`, `put`, `modify`, `evalState`, `execState` |
| `../../lectures/midterm-2/08-state/StateMonad.hs` | Explicit state passing; tree counting and labeling | Fresh labels and ordered state transitions |
| `../../lectures/midterm-2/09-transformers/Transformers.hs` | Multiple effects; division evaluator; counting operations; StateT/ExceptT | Optional extension, with runner definitions stated explicitly |
| `../../lectures/midterm-2/dynamic/Dynamic.hs` | Immutable arrays; Dynamic Programming in Haskell; Recursion over indices; self-referential array | Laziness context; optional array DP extension |
| `../../lectures/midterm-2/10-GADTs/GADTs.hs` | Untyped/typed expression evaluators; GADTs with DataKinds | Optional indexed-type exercise |
| `../../lectures/midterm-2/agda/Tutorial.agda` | Natural numbers; implicit arguments; vectors; Curry-Howard; predicate logic | Optional dependent-type/proof overview |
| `../../lectures/midterm-2/DafnyVerificationConditions.pdf` | Physical PDF pp. 3-7: assignment; 8-12: sequence; 13-18: conditionals; 19-30: loops/VCs | Backward substitution and loop obligations |
| `../../lectures/midterm-1/hoare-logic/HoareLogic.dfy` | Hoare triples; assignment; loops; invariant reasoning | Supporting prerequisite for 06 |

## Corrections and supplementary teaching

The Dafny slide deck labels itself **Spring 2026** on physical page 1. Its presence
does not establish Fall 2026 exam coverage. Physical page 12 (printed slide 11)
says to work "forward" after starting at the end and shows `sp` in its final line.
For weakest preconditions through sequential code, this guide consistently works
**backward**, using `wp(S1; S2,Q) = wp(S1,wp(S2,Q))`, as illustrated on the
preceding example slides. We flag the apparent slide typos rather than repeat them.

The Agda tutorial's disjunction deduction bullet says conjunction, and its bottom
type heading says "Negation: false". Our extension uses disjunction case analysis
and distinguishes falsity (`Bottom`) from negation (`P -> Bottom`).

The type ledger, study order, readiness checks, changed exercises, and difficulty
ranking are supplementary teaching aids. New names such as `gather`, `spreadMax`,
and `scatterMax` are practice analogues, not claims about names on a future exam.
The lazy helper in 07 adapts the **sample Q5 structure**; the dynamic-programming
lecture supplies the broader laziness/self-reference context, not that exact helper.

Transformer order, GADTs, Agda, and array DP are kept in 09 as lecture extensions.
They are not explicitly asked on the sample. Conversely, absence from one old
sample does not establish exclusion from the upcoming exam.
