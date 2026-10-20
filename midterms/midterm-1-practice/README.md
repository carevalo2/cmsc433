# Midterm preparation

This packet is based on `../Midterm1-2024.pdf`,
`../Midterm 2 Example - 2025.pdf`, Homework 1, Homework 2, and the root
Haskell style guide. The sources are from different years and different
midterms: they establish practice priorities, not guaranteed Fall 2026 scope.

## What appears on both exams

| Skill | 2024 exam | 2025 example |
| --- | --- | --- |
| Infer the most general Haskell type; detect type errors | Q2 | Q1 |
| Construct an expression from a type signature | Q3 | Q2 |
| Reason about a Dafny loop and its assertions | Q4 | Q3 |
| Understand and write Haskell code | Q1, Q5 | Q4, Q5 |

The recurring task is reasoning on paper, not merely getting code to compile.
You need to explain types, evaluate small programs, and justify a loop proof.

## What to be comfortable doing

1. **Types:** read curried arrows, unify argument/result types, retain `Eq`,
   `Ord`, `Show`, `Num`, and other required constraints, and distinguish a
   polymorphic variable from a particular type. Understand partial application,
   operator sections, tuples, composition, and nested `fmap`.
2. **Expression construction:** decide what information the arguments provide.
   Pattern match on lists and `Maybe`; use lambdas, comprehensions, mapping,
   filtering, and applicative/monadic operations where permitted. Recognize
   when a requested polymorphic output cannot be constructed totally.
3. **Recursion and folds:** choose base cases, trace recursive calls, distinguish
   `foldr` from `foldl` using a non-associative operation, and understand the
   accumulator type. Translate list traversal into array traversal.
4. **Dafny proofs:** distinguish `requires`, `ensures`, and `invariant`; express
   bounded quantification; establish safe array indices; derive assertions
   backward by substitution. Explain initialization, preservation, and exit.
   Know that termination is a separate obligation from partial correctness.
5. **Additional 2025 topics:** trace `Maybe` failure, list-monad branching,
   `do`/bind sequencing, `mapM`, and `State` value/state pairs. Trace lazy
   tuple bindings and understand why a recursive binding can be productive
   or can fail to terminate. These are not established by Homework 2 alone.

## What to carry forward from the homework

**Homework 1:** preconditions for arithmetic and indexing; quotient/remainder
specifications; array length and pointwise postconditions; processed-prefix
invariants from sortedness and reversal; early returns; the prime-checking
loop; and the backward assertion reasoning in decorated programs Q8/Q9.
Do not memorize those assertions: explain why each holds initially, survives
one iteration, and gives the desired result at exit.

**Homework 2:** list and `Maybe` pattern matching, empty-input behavior,
two-list recursion (`zip`/`map2`), predicates (`takeWhile`/`find`/`all`),
mapping partial results (`mapMaybe`), and rewriting recursion using `foldr`.
Review `para` and function-valued folds (`startsWith'` and `map2Tree`): they
teach you to choose an accumulator beyond a simple number or list.
Tree mapping/folding is useful structural-recursion practice, although neither
supplied exam directly asks you to implement tree operations. Practice choosing
tests for empty, singleton, mismatch, and boundary cases.

## Preparation sequence

1. Rework a few homework questions without looking at your old implementations.
   Explain the base case or invariant aloud before writing code.
2. Drill types and expressions in both directions. For every application,
   write the argument type that the function expects and unify it with the
   argument supplied. Check answers in GHCi only after committing on paper.
3. Trace folds and recursive functions on lists of length zero through three.
   Use subtraction to make fold order visible.
4. Practice one backward Hoare proof and one set of loop verification
   conditions. Keep substitutions in their exact syntactic form when asked.
5. Review the 2025 supplement if it is within your instructor's announced scope.
   Start with `Maybe` and lists, then `State`, then lazy bindings.
6. Take the three practice files closed-book. A suggested practice limit is 90 minutes for
   the core and 45 minutes for the supplement; these are not official times.
7. Afterward, compile your Haskell, test edge cases, and check Dafny if you
   have its verifier installed. Record whether each error came from a concept,
   a trace, syntax, a missing case, or a missed problem restriction. Redo weak
   questions with changed inputs the next day.

## Files and workflow

- `Written.md`: written questions, explanations, traces, and reference sheet.
- `Practice.hs`: full Haskell coding prompts, stubs, and tracing functions.
- `Practice.dfy`: full Dafny prompts, proofs, and verification conditions.

No answer key is included. The Haskell stubs intentionally use `undefined`;
replace every stub you attempt. Those placeholders are not acceptable final
solutions. The Dafny file is intentionally unfinished and will not verify.

From this directory, load Haskell with `ghci Practice.hs`, or check it with
`ghc -Wall -fno-code Practice.hs`. `Control.Monad.State.Lazy` requires the
`mtl` package. The scaffold was checked separately; compiling placeholders
does not demonstrate that you solved a problem. After implementation, add
several tests for each significant function as required by the style guide.

Use the course style guide: explicit top-level signatures, spaces rather than
tabs, lines at most 80 columns, complete pattern matches, descriptive names,
brief documentation, and no `head`, `tail`, or `fromJust` in your solutions.
Question-specific restrictions override general library-use advice.

When we review an attempt, start by explaining your reasoning. For a loop:
what does the invariant say about the work already done? For a fold: what
does the folded tail result represent?
