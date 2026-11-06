> Historical homework handoff saved October 28. Current Midterm 2 study progress
> is in ../transformers/03-except-t/README.md (updated November 4, 2026).
> The stopping point and assignment status below describe that earlier session;
> re-read assignment files before relying on them for current homework work.

# CMSC433 monads and Homework 4 handoff

Saved October 28, 2026. Read this and the root AGENTS.md before continuing.

## Goal and teaching preferences

Chris learned monad fundamentals to prepare for Homework 4 and is now implementing
the evaluator through guided homework help. Continue one small step/question at a
time, waiting for an attempt. Explain new concepts and syntax BEFORE presenting
examples or asking questions. Chris explicitly requested this after do notation
was introduced too abruptly. Avoid completing the whole assignment unasked.
Do not edit assignment files unless requested. This handoff was explicitly requested.
No lightning round now: user is saving remaining usage time.

## Files and environment

- Active assignment: `homework-3/src/Eval.hs`. Homework instructions said to place
  the provided Homework 4 file with HW3. An older `homework-4/Eval.hs` also exists;
  use the active file, not that starter copy.
- Syntax: `homework-3/src/Syntax.hs`.
- Practice route: `practice/monads/README.md`, with four numbered directories:
  Maybe/bind, do notation, State, StateT with Maybe. Each has `Practice.hs`.
- Practice files initially compiled successfully, but exercise implementations
  submitted in chat were not executed or saved by the assistant. Read current
  files before assuming their contents.
- User successfully loaded from `homework-3/src` with `stack ghci Eval.hs`.
  Output: GHCi 9.6.5, Syntax and Eval loaded successfully. Cabal indentation and
  missing-component warnings did not prevent loading.
- Another verified compile command, from `homework-3`, was
  `stack exec -- ghc -fno-code -isrc ../homework-4/Eval.hs` (earlier starter location).
  For the active file use `stack exec -- ghci -isrc src/Eval.hs` from homework-3.
- Do not claim current implementations pass tests: no evaluator behavior tests
  have been run by the assistant. Suggested commands include
  `runTestTT test_index`, `runTestTT test_update`, `runTestTT test_updateNth`.

## Learning progress

Chris correctly implemented these patterns in chat:

```haskell
addMaybe mx my = mx >>= (\x -> my >>= (\y -> Just (x + y)))

addMaybe' mx my = do
  x <- mx
  y <- my
  pure (x + y)

addToCounter amount = do
  modify ((+) amount)
  get

spend amount = do
  balance <- get
  if amount < 0 || amount > balance
    then lift Nothing
    else put (balance - amount)
```

Understanding demonstrated:
- Maybe bind supplies the contained value to the next function; Nothing skips
  the continuation. `>>` discards the first result but keeps state/failure behavior.
- `<-` binds the successful plain value; `let` would bind the whole expression.
- `pure`/`return` wraps an ordinary value; it does not update state or exit early.
- get reads current state; earlier bindings do not change after later put actions.
- put replaces state; modify applies a function to the state.
- runState returns (returned value, final state); evalState keeps the returned
  value; execState keeps the final state.
- StateT state monad result runs to monad (result, state). Type argument order
  differs from output tuple order; this was a major confusion, eventually resolved.
- StateT adds state handling to an underlying monad. Maybe supplies failure.
- lift adapts an underlying Maybe computation into StateT; it does not extract
  a number or assign a binding. readMaybe parses, lift adapts, <- binds success.
- Failure in StateT Store Maybe returns only Nothing, exposing no final store.
- Expressions produce values; statements are evaluated too but perform effects
  and generally return (). Assignment evaluates its RHS, then updates the store.

Watch these weak areas without restarting the whole lesson:
- Chris sometimes gives only the returned value or pair when asked for the whole
  runStateT output. Reinforce `Just (value, finalState)` versus `Nothing`.
- Originally confused <$> with >>=. Explain via function return types:
  fmap accepts a -> b; bind accepts a -> m b. Do not assume mastery was established.
- Type/constructor layers need explicit explanation, e.g. Var (Name name).
- Haskell immutable map/list operations and ordinary values versus monadic actions.

## Assignment progress (active file inspected at handoff)

Implemented in `homework-3/src/Eval.hs`:

```haskell
index name = do
  store <- get
  lift (store !? name)

update name value = do
  store <- get
  put (Map.insert name value store)

updateNth name idx value = do
  arrayValue <- index name
  case (arrayValue, idx, value) of
    (ArrayVal xs, IntVal i, IntVal n) ->
      if i < 0 || i >= length xs then lift Nothing
      else update name (ArrayVal (take i xs ++ [n] ++ drop (i + 1) xs))
    _ -> lift Nothing

evalE (Var (Name name)) = index name
```

These were reasoned through with guidance, not independently solved or tested.
Chris understands the list replacement formula as keeping the prefix and suffix
and inserting the replacement in between. take/drop use counts; drop (i+1) skips
the old element too. Lists have no built-in element-replacement operator.

Already supplied by the starter:
- `evalE (Val v) = return v`.
- Binary-expression evaluation recursively evaluates operands, then lifts evalOp2.
- evalOp2 implements integer Plus/Minus/Times/Divide, including division by zero.
- eval maps evalS across a block; evaluate and exec are supplied runners.

Remaining:
- evalE: array projection and unary operations. Current active file has no
  catch-all equation, so missing constructors currently cause pattern failures.
- evalOp2: remaining operators and invalid-operand fallback (still undefined).
- evalS: all statement cases (still undefined).
- runMethod: one undefined inside parameter insertion.
- Tests for expressions, invalid inputs, statements, and whole methods.

Requirements from Eval.hs: invalid inputs must produce Nothing rather than error
or Haskell runtime exceptions. No evalStateT/execStateT/runStateT inside evalE or
its helpers. Nonterminating source loops may legitimately fail to terminate.

## Exact stopping point and next step

We just explained evalE's job: evaluate an AST expression into a Value using the
store as needed. Chris first tried `return index name`; corrected to `index name`
because that already has type Eval Value. Chris correctly explained why literal
values need wrapping with return.

We are about to handle array projection:

```haskell
Var (Proj name position)
```

`name` is the array's variable name; `position` is an Expression, not an Int.
For example, a[x+1] requires evaluating the position expression.

The last question asked (not answered yet):
**Which function should we call to evaluate position?**

Expected concept: recursively use evalE position. Resume by briefly reminding
Chris of this point and ask that one question, rather than dumping a solution.
Then guide lookup through index name, evaluate position, match ArrayVal/IntVal,
validate bounds, and return the selected element wrapped as IntVal. Explain any
new operator before using it; `!!` reads a list element and requires checked bounds.

## Course sources already consulted

- `lectures/midterm-2/07-monads/Monads.hs`: Maybe abstraction and bind.
- `lectures/midterm-2/07-monads/MaybePractice.hs`.
- `lectures/midterm-2/07-monads/GenericMonads.hs`.
- `lectures/midterm-2/08-state/State.hs`: state interface.
- `lectures/midterm-2/09-transformers/Transformers.hs`: combined monads.
- Active Eval.hs and Syntax.hs expression/value/operator definitions.

Read relevant sections yourself before teaching new requirements. No external
resources or official grading/AI-use rules beyond available materials were verified.
