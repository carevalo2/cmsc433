# Monads: preparation for Homework 4

Start with **01, Question 1**. We will teach and discuss each step in chat;
these files keep the route and your answers together. Do not rush through the
whole folder as a problem set.

## Route

1. [Maybe and bind](01-maybe/Practice.hs): success, failure, `>>=`, and `pure`.
2. [Do notation](02-do/Practice.hs): `<-`, `let`, `>>`, and dependent steps.
3. [State](03-state/Practice.hs): results versus state, `get`, `put`, `modify`,
   and the three ways to run a state computation.
4. [State with failure](04-state-maybe/Practice.hs): `StateT`, `lift`, and
   tracing the combination used by `Eval.hs`.

At each stage: trace a concrete example, explain its behavior, implement a
small analogous function, then try a changed example independently. After
Stage 2, discuss the monad laws: `pure a >>= f = f a`, `m >>= pure = m`, and
`(m >>= f) >>= g = m >>= (\x -> f x >>= g)`.

Ready for Homework 4 means you can explain `Eval Value` versus `Eval ()`,
trace a store through sequential actions, explain how failure propagates,
and use `lift` without manually running a nested evaluator. Then return to
the assignment's store helpers, expressions, statements, arrays, and methods.
Its instructions prohibit `evalStateT`, `execStateT`, and `runStateT` inside
`evalE` and its helpers, and require handling invalid inputs without Haskell
runtime exceptions.

## Running exercises

From the repository root, load one file at a time:

```sh
ghci practice/monads/01-maybe/Practice.hs
```

Change the path for later stages. In GHCi, use `:reload` after editing.
Stages 3 and 4 require `mtl` (the same library used by Homework 4).
If it is unavailable in your GHCi environment, resolve that environment before
continuing; no separate project or dependency installation is supplied here.

Each file includes a `check...` value for its coding exercise. Run it only
after replacing that exercise's `undefined`; it should produce `True`.
Prediction answers have blank comment areas, with no answer key.

## Course sources

- `lectures/midterm-2/07-monads/Monads.hs`: “Abstracting programming patterns”
  and the Maybe monad development.
- `lectures/midterm-2/07-monads/MaybePractice.hs`: combining fallible operations.
- `lectures/midterm-2/08-state/State.hs`: “Accessing and Modifying State” and
  `runState`, `evalState`, `execState`.
- `lectures/midterm-2/09-transformers/Transformers.hs`: “How do we use multiple
  monads at once?”
- `homework-4/Eval.hs`: the `Eval` type and evaluator requirements.

The examples in this folder are supplementary practice modeled on those sources.

## Current study progress (November 4, 2026)

The original homework-preparation route above is retained. We have since reviewed
these foundations for Midterm 2 and moved into transformers. Each numbered folder
now has a study-handoff README. Resume at
[ExceptT](../transformers/03-except-t/README.md), not the older homework stopping
point in HANDOFF.md. Main recurring gaps: nested fmap/bind wrappers and full
runner output shapes. State sequencing and do-notation coding are stronger.
