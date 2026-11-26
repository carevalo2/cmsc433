module Day09 where

import StudyCheck (check, runChecks)
import StudyState

-- Day 9. Answer the three short prompts, then redo two earlier questions that
-- needed hints. If those two touch the same skill, choose a third topic for one.
-- Predict before using :t or running an expression.

-- 9.1 TYPE: flip (,) <$> get
-- Give the state type, the returned function type, and your reasoning.
-- Your answer:

-- 9.2 OUTPUT: Evaluate sequence [[False,True], [True]]. Compare with
-- sequence [Just False, Nothing] and explain what each outer context does.
-- Your outputs and reason:

-- 9.3 IMPLEMENT: Use two reads with one state update between them. Return
-- the old and new list lengths in a pair, in that order. Remove the first
-- element if present. Handle the empty list by leaving it unchanged.
lengthsAfterDrop :: State [a] (Int, Int)
lengthsAfterDrop = undefined

checkLengthsAfterDrop :: IO ()
checkLengthsAfterDrop = runChecks
  [ check "remove one element" (runState lengthsAfterDrop "xyz" == ((3,2),"yz"))
  , check "empty input" (runState lengthsAfterDrop ([] :: [Int]) == ((0,0),[]))
  ]
