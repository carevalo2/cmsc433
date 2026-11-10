module ContextTypes where

import StudyCheck (check, runChecks)

-- 2.3. Use only <$> / <*> and ordinary functions in these bodies.
-- No pattern matching or do notation. Write intermediate types here: ...
applyAvailable :: Maybe (a -> b) -> Maybe a -> Maybe b
applyAvailable = undefined

pairAvailable :: Maybe a -> Maybe b -> Maybe (a,b)
pairAvailable = undefined

-- Use the list Applicative; enumerate each left choice before the right choices.
choosePairs :: [a] -> [b] -> [(a,b)]
choosePairs = undefined

checks :: IO ()
checks = runChecks
  [ check "applyAvailable: present" (applyAvailable (Just not) (Just False) == Just True)
  , check "applyAvailable: missing function" (applyAvailable (Nothing :: Maybe (Int -> Int)) (Just 1) == Nothing)
  , check "applyAvailable: missing argument" (applyAvailable (Just not) Nothing == Nothing)
  , check "pairAvailable: present" (pairAvailable (Just 'x') (Just False) == Just ('x',False))
  , check "pairAvailable: missing" (pairAvailable (Nothing :: Maybe Char) (Just False) == Nothing)
  , check "choosePairs: enumeration order" (choosePairs [True,False] ['a','b'] == [(True,'a'),(True,'b'),(False,'a'),(False,'b')])
  , check "choosePairs: empty choice" (null (choosePairs [True] ([] :: [Char])))
  ]
