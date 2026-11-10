module LazinessPractice where

import StudyCheck (check, runChecks)

-- Supplied helper, adapted from the sample's Q5 structure.
spreadMax :: [Int] -> Int -> (Int,[Int])
spreadMax [] seed = (seed,[])
spreadMax [x] seed = (x,[seed])
spreadMax (x:xs) seed = (max x rest,seed:out)
  where (rest,out) = spreadMax xs seed

-- 7.3. Replace each entry with the input maximum; [] -> [].
-- Exactly two spreadMax calls for nonempty input. No other recursive list
-- helpers, explicit recursion, maximum, map, replicate, or folds.
toMaximumTwoPass :: [Int] -> [Int]
toMaximumTwoPass = undefined

-- 7.4. Same behavior/restrictions; exactly one spreadMax call on nonempty input.
-- Use a lazy recursive binding; handle [] explicitly.
toMaximumOneCall :: [Int] -> [Int]
toMaximumOneCall = undefined

-- Supplied for the changed problem 7.5.
spreadSum :: [Int] -> Int -> (Int,[Int])
spreadSum [] _ = (0,[])
spreadSum (x:xs) seed = (x+rest,seed:out)
  where (rest,out) = spreadSum xs seed

-- 7.5. Replace every entry with the total sum, using one spreadSum call.
-- Same recursive-helper restrictions; [] -> [].
toTotalOneCall :: [Int] -> [Int]
toTotalOneCall = undefined

checks :: IO ()
checks = runChecks
  [ check "two pass: mixed input" (toMaximumTwoPass [4,1,7] == [7,7,7])
  , check "two pass: all negative" (toMaximumTwoPass [-8,-3,-6] == [-3,-3,-3])
  , check "two pass: empty" (toMaximumTwoPass [] == [])
  , check "one call: mixed input" (toMaximumOneCall [4,1,7] == [7,7,7])
  , check "one call: singleton negative" (toMaximumOneCall [-8] == [-8])
  , check "one call: empty" (toMaximumOneCall [] == [])
  , check "total: mixed signs" (toTotalOneCall [2,-1,4] == [5,5,5])
  , check "total: singleton" (toTotalOneCall [-3] == [-3])
  , check "total: empty" (toTotalOneCall [] == [])
  ]
