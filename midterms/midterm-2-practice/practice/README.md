# CMSC433 Midterm 2 Nine-Day Practice

Study November 23 through December 1, assuming a December 2 exam. Start with a short refresher. Then tackle higher-order State, laziness, and verification while there is time to revisit them. Later lessons move through implementing traversals, tracing outputs, short type questions, and mixed review.

The TA says at **0:25** that the upcoming exam will be fairly similar in structure to the sample. The daily lessons cover all five question styles from the recording and use the matching files under `lectures/`. [Spring 2025 sample exam](../data/Midterm%202%20Example%20-%202025.pdf)

## How to work through a lesson

Open the day's file and work one numbered prompt at a time. For a type question, write the most general type, any constraints, and which expression determines them. For an output question, trace the intermediate values on paper or in the comments. For an implementation, start with the given signature and replace `undefined`. Share the attempt and your reasoning so we can check the step that needs work.

This command loads Day 1 in GHCi from the repository root. Change the day folder to load a later lesson.

```sh
ghci -imidterms/midterm-2-practice/support midterms/midterm-2-practice/practice/day-01-foundations/Practice.hs
```

Use `:t` or evaluate the expression after predicting. After editing, use `:reload` and run the named `check...` expression for the function you attempted. Day 4 is written. Day 8 is an independent mixed set, so save your answers before checking them.

## Daily lessons

| Day | Lesson | What you'll do | Recording |
| --- | --- | --- | --- |
| **1 · Mon Nov 23** | [Haskell foundations](day-01-foundations/Practice.hs) | Read lambdas and comprehensions, trace nested generators, infer the type of a partially applied constructor, and implement a filter. | 0:55–4:27, 9:51–11:44 |
| **2 · Tue Nov 24** | [Higher-order types and State](day-02-state/Practice.hs) | Infer function-valued actions, implement reads and updates, and trace actions under bind and applicative sequencing. | 9:51–17:30, 22:34–25:53, 51:20–54:45 |
| **3 · Wed Nov 25** | [Lazy helpers and recursive bindings](day-03-laziness/Practice.hs) | Trace both tuple fields, write two-call and one-call implementations, and explain when a seed is forced. | 58:47–1:11:44 |
| **4 · Thu Nov 26** | [Dafny verification conditions](day-04-dafny/Practice.md) | Work backward through assignments, derive all three loop obligations, and compare proposed invariants with counterexamples. | 27:47–38:06 |
| **5 · Fri Nov 27** | [Implement from polymorphic signatures](day-05-types-to-code/Practice.hs) | Implement collection, traversal, and monadic composition. Use types to explain what you can construct. | 17:30–27:47 |
| **6 · Sat Nov 28** | [Trace monadic outputs](day-06-monad-tracing/Practice.hs) | Trace `Maybe`, lists, and `State`, then rewrite collection using `mapM`. Explain which context controls nested failure. | 38:06–58:47 |
| **7 · Sun Nov 29** | [Short types and outputs](day-07-short-types/Practice.hs) | Practice most-general types, identify ill-typed expressions, compare applicative contexts, and implement a comprehension. | 0:55–17:30 |
| **8 · Mon Nov 30** | [Mixed Haskell practice](day-08-mixed-practice/Practice.hs) and [Dafny practice](day-08-mixed-practice/Verification.md) | Attempt one set that combines all five sample question styles. Explain each answer and mark where you were unsure. | Revisit the relevant segment after attempting |
| **9 · Tue Dec 1** | [Haskell recall](day-09-retention/Practice.hs) and [Dafny recall](day-09-retention/Verification.md) | Answer short type, trace, and implementation questions. Redo two prompts you needed help with. | Use only for a targeted refresher |

## Lecture references

- **Days 1 and 7.** Use the Functor and Applicative sections to match function arguments and types. [Monads.hs](../../../lectures/midterm-2/07-monads/Monads.hs)
- **Day 2.** Use the `State` representation and the sections on `get`, `put`, and `modify` to distinguish a returned value from stored state. [State.hs](../../../lectures/midterm-2/08-state/State.hs)
- **Day 3.** Use the discussion of an array that depends on itself to connect the lecture's lazy dependency reasoning to the review's tuple helper. [Dynamic.hs](../../../lectures/midterm-2/dynamic/Dynamic.hs)
- **Day 4.** Use the assignment and sequence rules, followed by slides 28–31 for loop conditions. [Dafny verification deck](../../../lectures/midterm-2/DafnyVerificationConditions.pdf)
- **Days 5 and 6.** Use the `mapM` example, the `sequence` signature, and the Maybe and List sections for the relationship between traversal and execution. [GenericMonads.hs](../../../lectures/midterm-2/07-monads/GenericMonads.hs) · [Monads.hs](../../../lectures/midterm-2/07-monads/Monads.hs)

The recording leaves the exam coverage of transformers, GADTs, array-based dynamic programming, Agda, and concurrency open. If current course guidance includes any of those, use the corresponding lecture and the relevant extension exercise where available. [Transformers](../../../lectures/midterm-2/09-transformers/Transformers.hs) · [GADTs](../../../lectures/midterm-2/10-GADTs/GADTs.hs) · [Dynamic programming](../../../lectures/midterm-2/dynamic/Dynamic.hs) · [Agda](../../../lectures/midterm-2/agda/Tutorial.agda) · [Concurrency](../../../lectures/midterm-2/12-concurrency/Concurrency.hs) · [Earlier lecture extension exercises](../archive/2026-11-09-workbook/practice/09-lecture-extensions/lesson.tex)
