module LazyTopicMock where

-- TOPIC MOCK: independent attempt, feedback after the whole file.
-- Modeled on sample Q5, p.5. Untimed, no points; current exam scope unconfirmed.
-- Supplied program:
scatterMin :: [Int] -> Int -> (Int,[Int])
scatterMin [] seed = (seed,[])
scatterMin [x] seed = (x,[seed])
scatterMin (x:xs) seed = (min x rest,seed:out)
  where (rest,out) = scatterMin xs seed

-- 1. Evaluate these without running the program:
-- (a) scatterMin [] 11
-- Answer:
-- (b) scatterMin [8] 11
-- Answer:
-- (c) scatterMin [8,3,6] (-20)
-- Answer:

-- 2. Replace every element by the original list's minimum, returning [] for [].
-- Use exactly TWO scatterMin calls for nonempty input. No explicit recursion,
-- minimum, map, replicate, folds, or other recursive list functions.
toMinimumTwoPass :: [Int] -> [Int]
toMinimumTwoPass = undefined

-- 3. Challenge (as in the sample's bonus): same behavior and restrictions,
-- with exactly ONE scatterMin call for nonempty input.
toMinimumOneCall :: [Int] -> [Int]
toMinimumOneCall = undefined

-- Explain whether your one-call definition is productive on finite nonempty
-- inputs, referring to the dependencies in the supplied helper:

-- Assistance used (fill after completing the mock):
