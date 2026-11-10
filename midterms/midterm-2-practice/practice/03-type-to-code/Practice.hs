module TypeCodePractice where
import StudyCheck (check, runChecks)

-- GUIDED PRACTICE: start at Question 1 and discuss one step at a time.
-- Source: sample Q2 (p.2), Q4(b) (p.4); GenericMonads.hs.
-- Idea: use each argument's type to work out what values you can construct.
-- Worked example (different operation):
--   liftOne f action = do x <- action; return (f x)
-- Here action :: m a; x :: a; f x :: b; return (f x) :: m b.

-- 1. Predict before coding: in a nonempty input below, what are the types of
-- its head, the recursive result, and each bound payload?
-- Your type ledger:
-- Your plan for the empty case:
-- Then implement. All Just values -> Just their values, in order;
-- any Nothing -> Nothing. Empty input succeeds with [].
-- Use explicit recursion, not sequence/mapM/traverse or equivalent helpers.
collectMaybe :: [Maybe a] -> Maybe [a]
collectMaybe = undefined

-- 2. Generalize: apply the function left-to-right and collect the results.
-- Use explicit recursion and do/bind/return; no traversal/sequencing/fold helpers.
-- Types of f x, its bound value, and the recursive result:
walkM :: Monad m => (a -> m b) -> [a] -> m [b]
walkM = undefined

-- 3. Changed transfer: compose two action-producing functions, running the
-- first and then passing its result to the second. Only do/bind/return and
-- ordinary application; no library composition helper.
-- Why ordinary (.) does or does not fit these argument types:
composeM :: Monad m => (a -> m b) -> (b -> m c) -> a -> m c
composeM = undefined

-- Run after attempting the relevant implementation. Examples are not proofs.
checks :: IO ()
checks = runChecks
  [ check "collect: all present" (collectMaybe [Just 'x',Just 'y'] == Just "xy")
  , check "collect: failure" (collectMaybe [Just True,Nothing] == Nothing)
  , check "collect: empty" (collectMaybe ([] :: [Maybe Int]) == Just [])
  , check "walk: branching" (walkM (\x -> [x,-x]) [1,2 :: Int] == [[1,2],[1,-2],[-1,2],[-1,-2]])
  , check "walk: failure" (walkM (\x -> if x > 0 then Just x else Nothing) [1,0 :: Int] == Nothing)
  , check "compose: successful chain" (composeM (Just . (+1)) (Just . (*2)) (3 :: Int) == Just 8)
  ]
