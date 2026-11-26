module Day03 where

import StudyCheck (check, runChecks)

-- Day 3. See the practice guide for the GHCi command and lecture links.
-- Work one prompt at a time. Predict and explain before checking.

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
fillWithSumTwoCalls xs = 
  let total = fst (spreadSum xs 0)
  in snd (spreadSum xs total)

-- 3.3 IMPLEMENT: Get the same result with one spreadSum call. Explain why
-- computing the first component can finish and what happens for [].
fillWithSumOneCall :: [Int] -> [Int]
fillWithSumOneCall xs = 
  let (total, filled) = spreadSum xs total
  in filled

-- 3.4 OUTPUT: Compare evaluating these expressions to normal form.
-- length (snd (spreadSum [4,2] undefined))
-- head (snd (spreadSum [4,2] undefined))
-- Which can return a number? Identify exactly what each expression demands.
-- Your results and reason:

-- 3.5 TRANSFER: In the recorded minimum helper, the empty case returns
-- (seed, []) and the singleton case returns (x, [seed]). Explain why the
-- one-call version can return [] even though demanding the empty minimum
-- would force the seed to depend on itself. What changes for [4]?
-- Your explanation:

checkSumTwo :: IO ()
checkSumTwo = runChecks
  [ check "two calls on empty input" (null (fillWithSumTwoCalls []))
  , check "two calls on nonempty input" (fillWithSumTwoCalls [-2,6,1] == [5,5,5])
  ]

checkSumOne :: IO ()
checkSumOne = runChecks
  [ check "one call on empty input" (null (fillWithSumOneCall []))
  , check "one call on nonempty input" (fillWithSumOneCall [-2,6,1] == [5,5,5])
  ]
