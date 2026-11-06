# Do notation: study handoff

## Status and strengths

Chris independently wrote sequential parsing with do, and later wrote both do
and nested-bind versions of addChecked over Either. Correctly implemented a State
action with get >>= followed by put ... >> pure original. Learned that >> discards
an action's returned value while preserving its state changes/failure behavior.
Current Practice.hs still has parseDouble = undefined; do not equate the broader
chat review with completion of every numbered exercise in this file.

## Weak areas and next review

- Needed a refresher on >> and a step-by-step list-state trace; then correctly
  traced runState (record 3 >> record 6) [] as (1, [6,3]).
- Repeated syntax slip: pure length original instead of pure (length original),
  or pure x + y instead of pure (x + y).
- Chris asked whether >> can be replaced by separate lines. Explain that an else
  branch needs its own do block to group multiple actions.
- Older handoff records <- versus let and pure not exiting early as covered;
  those distinctions were not independently retested in the latest review.

## Resume guidance

Continue at ../../transformers/03-except-t/README.md. If bind syntax becomes a
barrier, show the same tiny action in do and >>= form, then ask for one translation.
Do not insist on a full monad lesson restart.

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
