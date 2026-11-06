# StateT with Maybe: study handoff

## Status and strengths

The October 28 handoff records guided work on StateT and lift; this session
reviewed it with a withdrawal exercise. Chris wrote the right validation and
update logic, initially calling put by the wrong name (update). Correctly predicted
Nothing for withdraw 3 >> withdraw 8 starting at 10. Current Practice.hs contains
spend, returning (), and the starter addText. Do not confuse spend with the chat
withdraw variant that returned the remaining balance.

## Weak areas and next review

- Complete result shape needs reinforcement: StateT s Maybe a runs to
  Maybe (a,s), not just the pair or just the returned number.
- lift adapts an underlying Maybe action into StateT; it does not unwrap a
  number. <- performs the successful value binding.
- Failure exposes no final state through this runner; avoid describing this as
  undoing arbitrary external effects.

## Resume guidance

This is prerequisite review, not the current lesson. Continue at
../../transformers/03-except-t/README.md. Compare with Either only when useful:
Maybe gives Nothing; Either can carry an explanatory Left message.

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
