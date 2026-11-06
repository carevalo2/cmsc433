# ExceptT: current study handoff

## Current goal and exact stopping point

We are studying CMSC433 Midterm 2. Chris requested a next-day ExceptT refresher,
then asked to save these handoffs BEFORE answering the refresher question.

The pending question is: for the following action with n = 4 and initial counter
0, what is the FULL result? Present the snippet again and wait for the attempt.
Do not jump ahead to transformer order.

```haskell
countAndDouble :: Int -> ExceptT String (State Int) Int
countAndDouble n = do
  lift (modify (+1))
  if n < 0
    then throwError "Negative number"
    else pure (n * 2)

-- Predict:
runState (runExceptT (countAndDouble 4)) 0
```

This example exists in chat, not Practice.hs. It counts one attempt before
validation. Do not confuse it with stage 02's successful-division counter.

## What has been taught

- ExceptT e m a adds error handling to an underlying monad m.
- ExceptT String (State Int) Int: String is the error type, State Int is the
  underlying state monad, final Int is the returned success value type.
- pure returns success; throwError supplies a failure and skips later actions.
- runExceptT produces State Int (Either String a); runState supplies the counter
  and produces (Either String a, Int).
- Explicit lift adapts an underlying State action into ExceptT. It does NOT
  extract a value. mtl also supports direct get/put/modify through MonadState;
  saying explicit lift is always required would be wrong.
- State is visible after failure in this ordering. No claims about IO rollback.

## Strengths demonstrated, with support level

Chris correctly identified String as the error type and wrote pure (n * 2) when
asked to double the result without changing state. After guided tracing, gave
correct numerical success components for input 3/counter 10, and correctly gave
an error with counter 5 for input -1/counter 4. These were scaffolded traces,
not independent ExceptT implementations.

## Weak areas and what still needs work

- Initially mixed up n and counter: for n = 3/counter 0 predicted counter 4 rather
  than 1. Show the separate input argument and initial state explicitly.
- Initially used runStateT and a plain pair for ExceptT over State. Practice the
  correct runners and (Right result, state) / (Left error, state) shapes.
- Initially doubled negative input instead of following the error branch.
  The increment occurs first; throwError skips the success branch.
- Needed the exact snippet repeated to follow tracing. Keep it visible.
- The current refresher question has NOT been answered. A previous-day correct
  trace does not establish retention today.

## File status and next steps

Current Practice.hs has the starter sample, runChecked, and partialFailure.
addChecked, attemptDivision, and addCheckedMtl are still undefined. Do not fill
these in for Chris without an explicit request for solutions.

After the pending refresher:
1. Use Question 1/sample to connect the runner and explicit lift to the file.
2. Resume Question 2/addChecked, already assigned but not attempted: reject a
   negative amount BEFORE changing state; otherwise add it and return NEW state.
   Use do and explicit lift initially; no runners inside the action.
3. Question 3: trace partialFailure and identify skipped actions/state exposure.
4. Question 4: implement attemptDivision; increment BEFORE checking denominator.
5. Only then discuss mtl's direct state operations in Question 5.
6. Move to ../04-transformer-order once independent traces/coding are sound.

Ask one question at a time. Use small changed examples if Chris struggles; do not
repeat an unchanged prompt with progressively answer-revealing hints.

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
