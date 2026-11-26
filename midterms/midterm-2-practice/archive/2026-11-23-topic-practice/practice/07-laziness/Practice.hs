module LazyTopicPractice where
import StudyCheck (check, runChecks)

-- GUIDED PRACTICE: one prompt at a time, with feedback before continuing.
-- Sample Q5 (p.5); Dynamic.hs provides the broader self-reference/laziness idea.
-- Idea: one component of a pair can be computed without demanding the other.
-- Worked small example: fst (7, undefined) evaluates to 7.
-- A recursive binding is useful only when the demanded part is productive.

-- Supplied helper, adapted from the sample's summary/list helper.
spreadMax :: [Int] -> Int -> (Int,[Int])
spreadMax [] seed = (seed,[])
spreadMax [x] seed = (x,[seed])
spreadMax (x:xs) seed = (max x rest,seed:out)
  where (rest,out) = spreadMax xs seed

-- 1. Predict before running:
-- spreadMax [4,1,7] 20
-- Recursive intermediate pairs:
-- Final pair:
-- Meaning of each output for any finite nonempty input:

-- 2. Replace every element by the input maximum; [] -> [].
-- Exactly TWO spreadMax calls for nonempty input. Use let/projections.
-- No explicit recursion, maximum, map, replicate, folds, or any other
-- recursive list helper. Work out which output supplies each needed value.
toMaximumTwoPass :: [Int] -> [Int]
toMaximumTwoPass = undefined

-- 3. After discussing 2, implement the same behavior with exactly ONE
-- spreadMax call for nonempty input, using a recursive binding.
-- Same restrictions; handle [] explicitly.
toMaximumOneCall :: [Int] -> [Int]
toMaximumOneCall = undefined

-- Explain why your numeric summary does or does not need to force seed:

checks :: IO ()
checks = runChecks
  [ check "two calls: mixed input" (toMaximumTwoPass [4,1,7] == [7,7,7])
  , check "two calls: negative input" (toMaximumTwoPass [-8,-3] == [-3,-3])
  , check "two calls: empty" (toMaximumTwoPass [] == [])
  , check "one call: mixed input" (toMaximumOneCall [4,1,7] == [7,7,7])
  , check "one call: singleton" (toMaximumOneCall [-8] == [-8])
  , check "one call: empty" (toMaximumOneCall [] == [])
  ]
