module MixedReview where

import StudyState (State, runState, get, put, modify)
import StudyCheck (check, runChecks)

-- Optional GHCi companion. All answers may instead be written in lesson.tex.
-- Q2. Explicit recursion, no traversal helpers. First Left wins left-to-right.
collectEither :: [Either e a] -> Either e [a]
collectEither = undefined

-- Return f currentState, leaving state unchanged; abstract State interface only.
applyAfterRead :: (s -> a) -> State s a
applyAfterRead = undefined

-- Return the old triple and store its rotation (z,x,y).
rotateStore :: State (a,a,a) (a,a,a)
rotateStore = undefined

-- Sequence actions left-to-right and combine outputs; do/bind/return only.
liftThree :: Monad m => (a -> b -> c -> d) -> m a -> m b -> m c -> m d
liftThree = undefined

-- Supplied Q4 program.
pack :: Monad m => [m (a -> b)] -> m [a -> b]
pack [] = return []
pack (u:us) = do
  f <- u
  fs <- pack us
  return (f:fs)

-- Q4. Exactly one mapM call; no explicit recursion.
packViaMapM :: Monad m => [m (a -> b)] -> m [a -> b]
packViaMapM = undefined

-- Supplied Q5 helper.
scatterMin :: [Int] -> Int -> (Int,[Int])
scatterMin [] seed = (seed,[])
scatterMin [x] seed = (x,[seed])
scatterMin (x:xs) seed = (min x rest,seed:out)
  where (rest,out) = scatterMin xs seed

-- [] -> []; replace each element by input minimum. On nonempty input use
-- exactly two scatterMin calls. No other recursive list helper or recursion.
toMinimumTwoPass :: [Int] -> [Int]
toMinimumTwoPass = undefined

-- Same restrictions and behavior, but one scatterMin call on nonempty input.
toMinimumOneCall :: [Int] -> [Int]
toMinimumOneCall = undefined

checks :: IO ()
checks = runChecks
  [ check "collectEither: present" (collectEither [Right 'a',Right 'b'] == (Right "ab" :: Either String String))
  , check "collectEither: first error" (collectEither [Right True,Left "first",Left "second"] == Left "first")
  , check "collectEither: empty" (collectEither [] == (Right [] :: Either String [Bool]))
  , check "applyAfterRead" (runState (applyAfterRead length) "abcd" == (4,"abcd"))
  , check "rotateStore" (runState rotateStore ('a','b','c') == (('a','b','c'),('c','a','b')))
  , check "liftThree" (liftThree (\a b c -> (a,b,c)) (Just 'a') (Just False) (Just ()) == Just ('a',False,()))
  , check "packViaMapM: function outputs" (fmap (map ($ False)) (packViaMapM [Just not,Just id]) == Just [True,False])
  , check "two pass: positive" (toMinimumTwoPass [8,3,6] == [3,3,3])
  , check "two pass: negative" (toMinimumTwoPass [-4,-9,2] == [-9,-9,-9])
  , check "two pass: empty" (toMinimumTwoPass [] == [])
  , check "one call: positive" (toMinimumOneCall [8,3,6] == [3,3,3])
  , check "one call: singleton" (toMinimumOneCall [8] == [8])
  , check "one call: empty" (toMinimumOneCall [] == [])
  ]
