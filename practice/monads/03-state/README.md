# State: study handoff

## Status and strengths

Reviewed through changed chat exercises. Chris identified State Int Bool as an
Int state with a Bool result. Wrote replaceWithLength and record with correct
State logic after small variable-name/parenthesis fixes. Independently completed:

```haskell
readAndAdd amount =
  get >>= (\original -> put (original + amount) >> pure original)
```

Correctly traced two readAndAdd actions from 10 as (13,15). Current file contains
addToCounter using modify and get. These successes support moving forward rather
than restarting State fundamentals.

## Weak areas and next review

- Needs periodic reminders: State s a has state type first, result type second;
  runState produces (a,s), in the opposite order.
- Initially used the new list length instead of original length, and reversed
  cons order. A saved original binding does not change when put updates state.
- Occasionally names put as set or update; distinguish the library operation
  from unrelated helpers.
- Needed a refresher on modify: apply a function to current state, return ().
  Initially treated (*2) like (+2), then correctly answered 5 * 3 = 15 and wrote
  tick = modify (+1).
- Can give only the state when asked for the complete runner result.

## Resume guidance

Current work is ../../transformers/03-except-t/README.md. Use changed initial
states and explicitly separate input argument, returned value, and counter.
The latest review did not independently retest evalState versus execState.

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
