# Either: study handoff

## Status and strengths

Either unit completed in chat; current Practice.hs contains implementations of
checkPositive, parsePositive, sumPositiveText, and evalEither. Prediction comment
areas are still blank even where answers were given in chat.

Chris learned Either e a as Left e or Right a. For errors, Left carries a message
and Right carries success. Correctly explained why Either String Int is useful
when the caller needs to distinguish failure reasons. Initially asked whether
Either conflicts with Maybe; clarify they serve overlapping purposes, with Either
carrying information in the failure case.

Independently wrote divideThenAdd and addChecked with do, and converted addChecked
to nested binds. Completed recursive evalEither correctly: literals return Right,
left then right recursive evaluation, zero check, and quotient. Explained that
right must be evaluated because it is an expression; a nested division can yield
zero even if it is not literally Val 0.

## Weak areas and corrections already taught

- Nested wrappers: correctly predicted Right (Right 8) with fmap after earlier
  Maybe review, and Right 8 with bind. Still worth a delayed independent retest.
- Initially gave the positivity error for unparseable text. Parsing failure is
  Left "Not an integer"; parsed nonpositive numbers fail with "Must be positive".
  Then correctly classified the negative-number case and its type.
- Asked how pure chooses Right: the expected Either type selects its Applicative
  instance. pure produces success; it does not choose an error automatically.
- Occasional name mismatches and pure-parenthesis errors are syntax issues,
  separate from the correct control-flow idea.

## Resume guidance

Move on; do not repeat the entire Either unit. Current stopping point is
../03-except-t/README.md. No claim that the user ran checkEvalEither or other
checks: the assistant suggested them, but no execution was reported in chat.

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
