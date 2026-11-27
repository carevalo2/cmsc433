module Day05 where

import StudyCheck (check, runChecks)

-- Day 5. See the practice guide for the GHCi command and lecture links.
-- Work one prompt at a time. Predict and explain before checking.

-- Worked: in do { v <- action; pure (f v) }, if action :: m a and
-- f :: a -> b, then v :: a and the whole block has type m b.

-- 5.1 TYPE THEN IMPLEMENT: Before writing the list case, identify the types
-- of the head action, its bound value, the recursive action, and its bound
-- value. What should the empty input return? Use recursion and do notation.
-- Your types and base-case reason:
gatherActions :: Monad m => [m a] -> m [a]
gatherActions [] = pure []
gatherActions (first : rest) = do
  x <- first
  xs <- gatherActions rest
  pure (x : xs)

-- 5.2 IMPLEMENT: Write a traversal that applies the supplied action-producing
-- function to each input. Reuse gatherActions and ordinary map. Explain the
-- intermediate type and why both functions are needed.
walkActions :: Monad m => (a -> m b) -> [a] -> m [b]
walkActions f inputs = gatherActions (map f inputs)

-- 5.3 IMPLEMENT: Use the result of f as the input to g. Write the function
-- with bind or do notation. Why does ordinary (.) fail to connect f and g?
composeActions :: Monad m => (a -> m b) -> (b -> m c) -> a -> m c
composeActions f g x = do
  res <- f x
  g res

-- 5.4 REASON: Given only the constraint Monad m, can you produce an action
-- that returns a fully defined a for every a and m? What does pure require?
-- Consider the signature makeValue :: Monad m => m a.
-- Your reason and what changes if you are also given an a:

checkCompose :: IO ()
checkCompose = runChecks
  [ check "pass the payload along" (composeActions Just (Just . length) "abc" == Just 3)
  , check "propagate failure" (composeActions (const Nothing) Just True == (Nothing :: Maybe Char))
  ]

checkGather :: IO ()
checkGather = runChecks
  [ check "empty Maybe input" (gatherActions ([] :: [Maybe Char]) == Just [])
  , check "keep both payloads" (gatherActions [Just 'a', Just 'b'] == Just "ab")
  , check "fail after a successful action" (gatherActions [Just 'a', Nothing] == Nothing)
  ]

checkWalk :: IO ()
checkWalk = runChecks
  [check "list branches in order" (walkActions (\x -> [x, -x]) [2,3 :: Int] == [[2,3],[2,-3],[-2,3],[-2,-3]])]
