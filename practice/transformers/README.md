# Monad transformers: guided practice

Start with **01, Question 1**. Explain each new idea in chat before attempting
its exercise. Work one prompt at a time: predict, explain, code, then check.
Do not run a check until its exercise is implemented; `undefined` is intentional.
These are supplementary exercises modeled on the lectures, not exam predictions.

## Route

1. [Either](01-either/Practice.hs): types and constructors, error messages,
   do notation, bind versus fmap, then a small recursive evaluator.
2. [State with errors](02-state-with-errors/Practice.hs): StateT with Either,
   lift, successful results, failure, then an evaluator that counts divisions.
3. [ExceptT](03-except-t/Practice.hs): its runner, throwError, lifting State
   actions, and an independent state-and-error coding task.
4. [Transformer order](04-transformer-order/Practice.hs): compare output shapes
   and whether state is exposed after failure; finish with a coding transfer.

This continues practice/monads rather than replacing it. Prior review showed
stronger State sequencing; revisit fmap versus bind and nested wrappers as needed.
Do not assume independent mastery from answers completed with guidance.

## Running

From the repository root, load ONE file at a time:

```sh
ghci practice/transformers/01-either/Practice.hs
```

Use `:reload` after editing. Later stages use `mtl`, as the earlier State practice
does. Checks cover representative examples, not every possible input.
Prediction answer areas contain no solutions. Discuss later stages only when ready.

## Course sources

- lectures/midterm-2/07-monads/EitherMonad.hs: Either, Functor, Monad.
- lectures/midterm-2/09-transformers/Transformers.hs: division evaluator,
  StateT, ExceptT, MonadTrans/lift, and transformer order (Steps 3–5).
- lectures/midterm-2/08-state/State.hs: state interface and runners.

The division exercises use bounded Int values; arithmetic overflow is outside
this practice's scope. No assignment files are changed.
