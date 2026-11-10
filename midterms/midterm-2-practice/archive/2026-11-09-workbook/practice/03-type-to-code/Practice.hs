module TypeToCode where

import StudyCheck (check, runChecks)

-- 3.1/3.2. All present -> Just their values in order; any Nothing -> Nothing.
-- Explicit recursion only; no sequence/traverse/mapM or equivalent library helper.
collectMaybe :: [Maybe a] -> Maybe [a]
collectMaybe = undefined

-- Apply the action left-to-right, collecting results in order.
-- Explicit recursion; no mapM/traverse/sequence/sequenceA/foldM.
walkM :: Monad m => (a -> m b) -> [a] -> m [b]
walkM = undefined

-- Sequence all actions left-to-right and collect their results.
-- Explicit recursion; don't delegate to walkM or a traversal/sequence helper.
gather :: Monad m => [m a] -> m [a]
gather = undefined

-- 3.3. Use exactly one call to library mapM; no explicit recursion.
gatherViaMapM :: Monad m => [m a] -> m [a]
gatherViaMapM = undefined

-- 3.4. Only bind/do/return and ordinary application in these bodies.
composeM :: Monad m => (a -> m b) -> (b -> m c) -> a -> m c
composeM = undefined

flattenM :: Monad m => m (m a) -> m a
flattenM = undefined

liftTwoM :: Monad m => (a -> b -> c) -> m a -> m b -> m c
liftTwoM = undefined

-- 3.6. Collect n results; n <= 0 performs no actions.
-- Explicit recursion; no replicateM/sequence/mapM/traverse.
repeatAction :: Monad m => Int -> m a -> m [a]
repeatAction = undefined

checks :: IO ()
checks = runChecks
  [ check "collectMaybe: all present" (collectMaybe [Just 'a',Just 'z'] == Just "az")
  , check "collectMaybe: missing" (collectMaybe [Just 'a',Nothing] == Nothing)
  , check "collectMaybe: empty" (collectMaybe ([] :: [Maybe Int]) == Just [])
  , check "walkM: Maybe" (walkM (\n -> if n >= 0 then Just (n+1) else Nothing) [1,-1 :: Int] == Nothing)
  , check "walkM: list choices" (walkM (\n -> [n, -n]) [1,2 :: Int] == [[1,2],[1,-2],[-1,2],[-1,-2]])
  , check "gather: list choices" (gather [[1,2],[3,4 :: Int]] == [[1,3],[1,4],[2,3],[2,4]])
  , check "gather: Maybe empty" (gather ([] :: [Maybe Int]) == Just [])
  , check "gatherViaMapM: function values" (fmap (map ($ False)) (gatherViaMapM [Just not,Just id]) == Just [True,False])
  , check "composeM: success" (composeM (\n -> Just (n+1)) (\n -> Just (n*2)) (3 :: Int) == Just 8)
  , check "composeM: failure" (composeM (\_ -> Nothing :: Maybe Int) (Just . (+1)) () == Nothing)
  , check "flattenM: nested present" (flattenM (Just (Just True)) == Just True)
  , check "flattenM: inner failure" (flattenM (Just (Nothing :: Maybe Bool)) == Nothing)
  , check "liftTwoM: choices" (liftTwoM (,) [False,True] ['x'] == [(False,'x'),(True,'x')])
  , check "repeatAction: choices" (repeatAction 2 "ab" == ["aa","ab","ba","bb"])
  , check "repeatAction: no effects" (repeatAction 0 (Nothing :: Maybe Int) == Just [])
  ]
