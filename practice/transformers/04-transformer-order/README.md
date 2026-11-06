# Transformer order: upcoming lesson handoff

## Status

Folder created and starter compilation checked when authored, but this unit has
NOT been worked through. Code exercises remain undefined. There is no evidence
of independent mastery here; do not mark this stage completed.

The two output shapes have been introduced during the ExceptT explanation:

```haskell
StateT Int (Either String) a  -- Either String (a, Int)
ExceptT String (State Int) a  -- (Either String a, Int)
```

Chris still needs reinforcement of complete runner results. Do not rush into a
comparison while the basic ExceptT runners are unsettled.

## Resume guidance

Current work is ../03-except-t/README.md, not this folder. Once ready, compare the
same state update followed by failure in both stacks. Ask for types and values
separately. Keep snippets visible and initial state explicit.

Practice.hs then provides matching coding tasks and a recursive evaluator
extension. Here the counter counts ATTEMPTS, before checking a denominator;
stage 02 counts only SUCCESSFUL divisions. State the policy before each exercise.
Avoid saying a pure State result hiding state means arbitrary external effects
have been rolled back.

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
