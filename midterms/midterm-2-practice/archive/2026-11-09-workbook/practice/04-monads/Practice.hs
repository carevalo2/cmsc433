module MonadPractice where

import StudyCheck (check, runChecks)

-- Supplied for M1/M2 predictions, not an implementation task in this file.
bundle :: Monad m => [m a] -> m [a]
bundle [] = return []
bundle (u:us) = do
  x <- u
  xs <- bundle us
  return (x:xs)

-- 4.3. Safe integer division. Divisor 0 -> Nothing; otherwise Just (x `div` y).
safeQuot :: Int -> Int -> Maybe Int
safeQuot = undefined

-- Starting with a number, divide successively by each divisor, left-to-right.
-- Empty divisor list succeeds with the original number. Any 0 fails.
-- Use explicit recursion plus safeQuot and do/bind, not a library fold.
divideChain :: Int -> [Int] -> Maybe Int
divideChain = undefined

-- Use list do notation; left choices outermost. No comprehensions/concatMap.
allPairs :: [a] -> [b] -> [(a,b)]
allPairs = undefined

-- Monadic left fold. Each step receives the previous accumulator and next input.
-- Use recursion and do/bind. No foldM, foldlM, foldr, mapM, or sequence.
foldActions :: Monad m => (a -> b -> m a) -> a -> [b] -> m a
foldActions = undefined

checks :: IO ()
checks = runChecks
  [ check "safeQuot: success" (safeQuot 20 4 == Just 5)
  , check "safeQuot: zero" (safeQuot 20 0 == Nothing)
  , check "divideChain: ordered" (divideChain 100 [5,2] == Just 10)
  , check "divideChain: failure" (divideChain 100 [5,0,2] == Nothing)
  , check "divideChain: empty" (divideChain 7 [] == Just 7)
  , check "allPairs: choices" (allPairs [False,True] "xy" == [(False,'x'),(False,'y'),(True,'x'),(True,'y')])
  , check "allPairs: no results" (null (allPairs ([] :: [Bool]) "x"))
  , check "foldActions: Maybe" (foldActions safeQuot 48 [2,3] == Just 8)
  , check "foldActions: fail" (foldActions safeQuot 48 [0] == Nothing)
  , check "foldActions: list branching" (foldActions (\a b -> [a+b,a-b]) 0 [1,2 :: Int] == [3,-1,1,-3])
  , check "foldActions: no steps" (foldActions (\_ _ -> Nothing :: Maybe Int) 7 ([] :: [Int]) == Just 7)
  ]
