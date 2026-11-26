module Day07 where

import StudyCheck (check, runChecks)
import StudyState

-- Day 7. See the practice guide for the GHCi command and lecture links.
-- Work one prompt at a time. Predict and explain before checking.

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

-- 7.4 TYPE OR ILL-TYPED. For each answer, show the matching argument slots
-- or the conflict. Underline any arrow that remains inside a context.
--   \f xs -> f <$> xs
--   Just not <*> Just 'a'
--   modify (drop 1)
--   (,) <$> [True, False]
-- Your answers:

-- 7.5 OUTPUT: Compare (,) <$> [1,2 :: Int] <*> ['a','b'] with
-- (,) <$> Just (2 :: Int) <*> (Nothing :: Maybe Char). State the whole
-- type of each expression and the order of any results.
-- Your types, outputs, and reason:

checkTagPassing :: IO ()
checkTagPassing = runChecks
  [ check "filter and preserve order" (tagPassing (> 0) [-1,2,1 :: Int] == [(2, True),(1, True)])
  , check "tag values read from state" (runState (tagPassing odd <$> get) [1,2 :: Int] == ([(1,True)],[1,2]))
  ]
