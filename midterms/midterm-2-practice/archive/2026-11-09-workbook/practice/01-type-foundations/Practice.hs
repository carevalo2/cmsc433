module TypeFoundations where

import StudyCheck (check, runChecks)

-- 1.4. Write intermediate types before coding. No use of undefined/error as answers.
-- swapPair: use a pair pattern; don't use an imported swap function.
-- Input components: ... ; output components: ...
swapPair :: (a,b) -> (b,a)
swapPair = undefined

-- applyTwice: don't use a loop, list, or numeric assumption about a.
-- f x :: ... ; applying f again requires ...
applyTwice :: (a -> a) -> a -> a
applyTwice = undefined

-- describeMaybe: use <$>; no pattern matching or do notation.
-- show :: ... ; context :: ... ; whole result :: ...
describeMaybe :: Show a => Maybe a -> Maybe String
describeMaybe = undefined

-- GHCi: swapPair ('r', False) == (False, 'r')
-- GHCi: applyTwice not True == True
-- GHCi: describeMaybe (Just (23 :: Int)) == Just "23"
checks :: IO ()
checks = runChecks
  [ check "swapPair: different component types" (swapPair ('r',False) == (False,'r'))
  , check "applyTwice: function on Bool" (applyTwice not True)
  , check "applyTwice: function on lists" (applyTwice (0:) [4 :: Int] == [0,0,4])
  , check "describeMaybe: present" (describeMaybe (Just (23 :: Int)) == Just "23")
  , check "describeMaybe: absent" (describeMaybe (Nothing :: Maybe Int) == Nothing)
  ]
