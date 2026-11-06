# Maybe and bind: study handoff

## Status and strengths

Reviewed in chat before transformers. Chris independently wrote sumText using
readMaybe, two <- bindings, and Just around the sum. Later correctly composed
halfOptional input = input >>= halfEven and optional positive parsing using bind.
Current Practice.hs contains addMaybe with nested binds and addMaybe' with do.
Understands that Nothing short-circuits and functions passed to bind receive the
successful contained value. Coding improved after explicit scaffolding.

## Weak areas and next review

- Biggest recurring gap: fmap versus bind when the function already returns a
  monad. Initially predicted Maybe Int rather than Maybe (Maybe Int), Nothing
  rather than Just Nothing, and 5 rather than Just 5 after bind.
- Later correctly predicted Just (Just 5), but that followed worked examples;
  retest independently with a changed function before claiming transfer.
- Distinguish values from types: answered Just Int when the value was Just 3.
- Bind needs a continuation function, not a bare arithmetic expression. An early
  attempt shadowed a String parameter with its parsed Int; name layers clearly.
- pure (x + y) needs parentheses; pure x + y wraps too early.

## Resume guidance

Do not restart this lesson now. Current work is ExceptT: see
../../transformers/03-except-t/README.md. Revisit one changed fmap/bind example
later, asking separately for the value and its type. Avoid implying bind removes
all wrappers: it returns the continuation's already-wrapped result.

## How to continue teaching

- Read the root AGENTS.md and practice/README.md first. Current goal is CMSC433
  Midterm 2 study, not completing the older Homework 4 evaluator.
- Teach a small idea before asking for code; explain unfamiliar syntax first.
  Present one question at a time and wait. Keep the full snippet visible when
  tracing: Chris has asked which code a question refers to.
- Favor lecture-style coding, then a changed example to check transfer. Do not
  replace teaching with a cold worksheet or give entire solutions unasked.
- Distinguish a correct independent implementation from a scaffolded answer or
  one repeated after seeing a solution. Do not claim mastery from the latter.
- Preserve Practice.hs and existing answers. Read their current contents before
  editing or assuming an exercise is blank. Chat review does not imply execution.
- Sources: lectures/midterm-2/07-monads/{Monads,MaybePractice,EitherMonad}.hs,
  08-state/State.hs, and 09-transformers/Transformers.hs. Read relevant sections
  before teaching. Practice is supplementary, not an official exam prediction.

Saved November 4, 2026. Progress comes from chat plus current file inspection; no new
exercise execution was performed while saving these notes.
