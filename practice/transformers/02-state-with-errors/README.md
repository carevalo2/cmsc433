# State with errors: study handoff

## Status and strengths

Coding portion completed. Current Practice.hs contains correct-looking withdraw
and evalCount implementations, matching the versions reviewed in chat.

- Correctly traced bump from 4 as Right (4,5).
- Wrote withdraw using get, lift (Left ...) for two error cases, and put followed
  by pure of the ORIGINAL balance. Correctly predicted insufficient balance when
  withdrawing 3 then 8 from 10.
- Recognized that safeDivide :: Int -> Int -> Either String Int must be lifted
  when called inside StateT Int (Either String).
- After explanation, identified Counter () as an action with no useful result
  and wrote tick = modify (+1).
- Wrote recursive evalCount with left/right evaluation, lifted zero error,
  modify (+1) only after checking the denominator, and pure quotient.
- Correctly explained pure n versus put n: return a value versus replace state.

## Weak areas and next review

- Counter Int versus Counter () needed explicit explanation: the argument is the
  RETURN type; both use an Int state and Either String failure.
- Needed clarity on what is counted: SUCCESSFUL divisions only. Val n does not
  increment. An attempted zero division fails before incrementing for that node.
- Literal case pure n was supplied after confusion; recursive case was then
  correctly written by Chris. Do not label the whole evaluator unaided work.
- Repeatedly omitted output pieces: answered 6 (counter only) for Right (4,6),
  then (9,3) without Right; subsequently gave Right (4,1) correctly.
- Needs brief modify refreshers and explicit separation of counter from input.
- Error wording/capitalization must match code when comparing exact values.

## Resume guidance

Continue in ../03-except-t/README.md. The different stack there exposes state even
on failure; this stack's output is Either String (a,Int), so Left has no final
state in the returned value. Explicit lift teaches underlying-layer adaptation;
mtl's get/put/modify already operate at the StateT layer and need no lift here.
No behavior checks have been run by the assistant in this handoff task.

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
