module Review where

import StudyCheck (check, runChecks)
import StudyState

-- Start GHCi from the repository root using the command in README.md.
-- Take one numbered prompt at a time. Write a prediction and explain how
-- you got it before using :t or evaluating the expression. After implementing
-- a function, :reload and run its check. Each check uses different inputs
-- from the prediction prompts so you can explain those independently.

-- DAY 1 — Foundations
-- Worked: (,) 'x' :: b -> (Char, b). Applying one argument leaves an arrow.
-- Worked: [n + 1 | n <- [1,2,3 :: Int], n > 1] yields [3,4].

-- 1.1 TYPE: \xs -> [b | b <- xs, not b]
-- Reason from the guard to the input, then from the expression to the output.
-- Your type and reason:

-- 1.2 TYPE AND OUTPUT: (,) <$> Just 'x', then ((,) <$> Just 'x') <*> Just True.
-- Say what is inside Maybe after each operation.
-- Your types and outputs:

-- 1.3 IMPLEMENT: Keep the False values using a list comprehension.
-- Then predict the output on [False, True, False, True].
keepFalse :: [Bool] -> [Bool]
keepFalse = undefined

-- DAY 2 — Higher-order types, State, and threading state
-- Worked: runState (modify (+2) >> get) (3 :: Int) yields (5,5).
-- Worked: runState (put 'b') 'a' yields ((),'b').
-- State s a stores s and returns a. runState returns (result, finalState).

-- 2.1 TYPE: (\x y -> (y,x)) <$> get
-- Match the function slot of (<$>) first. Identify the stored type and the
-- entire returned function type. Explain what changes in the stored state.
-- Your type and reason:

-- 2.2 IMPLEMENT: Read one state value and return a function that compares an
-- argument with that saved value. Use the Ord comparison x < saved.
-- Predict the result of applying the returned function to 3 when the initial
-- state is 5.
-- Also predict the final state.
lessThanSaved :: Ord a => State a (a -> Bool)
lessThanSaved = undefined

-- 2.3 IMPLEMENT: Return a pair containing the value before and after adding
-- the supplied amount. Change the state once. Use get/modify and do notation.
-- First give the type of each bound value and the whole result.
beforeAndAfter :: Int -> State Int (Int, Int)
beforeAndAfter = undefined

-- 2.4 OUTPUT: Trace each action and give the final pair.
-- runState (sequence [get, modify (+3) >> get, modify (*2) >> get]) (4 :: Int)
-- Your result and state after each action:

-- DAY 3 — Lazy helpers and recursive bindings
-- Worked: fst (7, undefined) yields 7. Only the first field is demanded.
-- This helper uses the same two-output pattern as the review, with a sum.
spreadSum :: [Int] -> Int -> (Int, [Int])
spreadSum [] _ = (0, [])
spreadSum (x:xs) seed = (x + subtotal, seed : rest)
  where (subtotal, rest) = spreadSum xs seed

-- 3.1 OUTPUT: Predict spreadSum [4, -1, 2] 8, showing intermediate pairs.
-- Then predict fst (spreadSum [4, -1, 2] undefined) and explain the demand.
-- Your pairs and reason:

-- 3.2 IMPLEMENT: Replace every element with the input sum. Use two calls to
-- spreadSum and pair bindings or projections. Use no other recursive helper.
fillWithSumTwoCalls :: [Int] -> [Int]
fillWithSumTwoCalls = undefined

-- 3.3 IMPLEMENT: Get the same result with one spreadSum call. Explain why
-- computing the first component can finish and what happens for [].
fillWithSumOneCall :: [Int] -> [Int]
fillWithSumOneCall = undefined

-- Day 4 uses the Dafny worksheet linked in README.md.

-- DAY 5 — Construct a traversal from a type
-- Worked: in do { v <- action; pure (f v) }, if action :: m a and
-- f :: a -> b, then v :: a and the whole block has type m b.

-- 5.1 TYPE THEN IMPLEMENT: Before writing the list case, identify the types
-- of the head action, its bound value, the recursive action, and its bound
-- value. What should the empty input return? Use recursion and do notation.
-- Your types and base-case reason:
gatherActions :: Monad m => [m a] -> m [a]
gatherActions = undefined

-- 5.2 IMPLEMENT: Write a traversal that applies the supplied action-producing
-- function to each input. Reuse gatherActions and ordinary map. Explain the
-- intermediate type and why both functions are needed.
walkActions :: Monad m => (a -> m b) -> [a] -> m [b]
walkActions = undefined

-- DAY 6 — Same traversal, different monads
-- Use Prelude's sequence for predictions, then compare against gatherActions
-- after Day 5 is working. Worked: binding from [2,5] and adding 1 yields [3,6].

-- 6.1 OUTPUT AND TYPE: sequence [Just 'c', Nothing, Just 'z']
-- Explain what happens at the middle action.
-- Your type, output, and reason:

-- 6.2 OUTPUT: sequence [[1,2],[10,20,30 :: Int]]
-- Then compare sequence ([] :: [[Int]]) with sequence ([[]] :: [[Int]]).
-- Write the choices in order and explain the two empty cases.
-- Your outputs and reason:

-- 6.3 IMPLEMENT: Express gatherActions using mapM. First fill in the type of
-- the function argument of mapM after matching its list argument to [m a].
gatherViaMapM :: Monad m => [m a] -> m [a]
gatherViaMapM = undefined

-- DAY 7 — Short types and outputs from scratch
-- 7.1 TYPE AND OUTPUT: \xs -> [even x | x <- xs, x > 0]
-- Give the Prelude type and the output at [-2,1,2,3 :: Int].
-- Your type, constraint, and output:

-- 7.2 TYPE: get >>= \x -> pure (x, 'z')
-- Then explain why (put True >> put 'z') is ill-typed.
-- Your type and reason:

-- 7.3 IMPLEMENT: Given a predicate and a list, produce one (value, True)
-- for every passing input using a comprehension. Predict the result of
-- tagPassing even [1,4,3,2 :: Int] before running it.
tagPassing :: (a -> Bool) -> [a] -> [(a, Bool)]
tagPassing = undefined

-- DAY 8 — Mixed transfer. Attempt this before checking it.
-- 8.1 IMPLEMENT: If the stored list is nonempty, remove its head and return
-- Just the result of applying f to that head. If empty, return Nothing and
-- keep the state. First predict runState (popWith length) ["cat","hi"].
-- Your prediction and the types of both output components:
popWith :: (a -> b) -> State [a] (Maybe b)
popWith = undefined

-- 8.2 TYPE AND OUTPUT: Infer the type of this action before running it.
-- sequence [popWith length, popWith length, popWith length]
-- Then run it with ["cat", "hi"]. Explain where each Nothing or Just lives.
-- Your type, trace, and output:

-- DAY 9 — Retry the two prompts you most needed hints for. Explain what
-- changed in your reasoning before checking either one.

-- Example checks. Run only the check for a function you have attempted.
checkKeepFalse, checkLessThanSaved, checkBeforeAndAfter, checkSumTwo, checkSumOne,
  checkGather, checkWalk, checkMapM, checkTagPassing, checkPopWith :: IO ()

checkKeepFalse = runChecks
  [check "keep false values" (keepFalse [True, False, False] == [False, False])]

checkLessThanSaved = runChecks
  [ check "compare with saved value" (let (f, _) = runState lessThanSaved (-2 :: Int)
                                       in f (-3) && not (f (-2)))
  , check "keep state" (snd (runState lessThanSaved (8 :: Int)) == 8)
  ]

checkBeforeAndAfter = runChecks
  [check "return both values and store the new one" (runState (put 7 >> beforeAndAfter (-2)) 0 == ((7,5),5))]

checkSumTwo = runChecks
  [ check "two calls on empty input" (null (fillWithSumTwoCalls []))
  , check "two calls on nonempty input" (fillWithSumTwoCalls [-2,6,1] == [5,5,5])
  ]

checkSumOne = runChecks
  [ check "one call on empty input" (null (fillWithSumOneCall []))
  , check "one call on nonempty input" (fillWithSumOneCall [-2,6,1] == [5,5,5])
  ]

checkGather = runChecks
  [ check "empty Maybe input" (gatherActions ([] :: [Maybe Char]) == Just [])
  , check "keep both payloads" (gatherActions [Just 'a', Just 'b'] == Just "ab")
  , check "fail after a successful action" (gatherActions [Just 'a', Nothing] == Nothing)
  ]

checkWalk = runChecks
  [check "list branches in order" (walkActions (\x -> [x, -x]) [2,3 :: Int] == [[2,3],[2,-3],[-2,3],[-2,-3]])]

checkMapM = runChecks
  [check "gather a list of choices" (gatherViaMapM [[True,False],[False]] == [[True,False],[False,False]])]

checkTagPassing = runChecks
  [check "filter and preserve order" (tagPassing (> 0) [-1,2,1 :: Int] == [(2, True),(1, True)])]

checkPopWith = runChecks
  [ check "consume and transform" (runState (popWith not) [False, True] == (Just True, [True]))
  , check "empty input" (runState (popWith not) [] == (Nothing, []))
  ]
