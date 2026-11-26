module Day02 where

import StudyCheck (check, runChecks)
import StudyState

-- Day 2. See the practice guide for the GHCi command and lecture links.
-- Work one prompt at a time. Predict and explain before checking.

-- Worked: runState (modify (+2) >> get) (3 :: Int) yields (5,5).
-- Worked: runState (put 'b') 'a' yields ((),'b').
-- State s a stores s and returns a. runState returns (result, finalState).

-- 2.1 TYPE: (\x y -> (y,x)) <$> get
-- Match the function slot of (<$>) first. Identify the stored type and the
-- entire returned function type. Explain what changes in the stored state.
-- Your type and reason:

-- 2.2 IMPLEMENT: Read one state value and return a function that compares an
-- argument with that saved value. Use the Ord comparison x < saved.
-- Predict the result of applying the returned function to 3 when the initial
-- state is 5.
-- Also predict the final state.
lessThanSaved :: Ord a => State a (a -> Bool)
lessThanSaved = do 
  saved <- get 
  pure (\n -> n < saved)

-- 2.3 IMPLEMENT: Return a pair containing the value before and after adding
-- the supplied amount. Change the state once. Use get/modify and do notation.
-- First give the type of each bound value and the whole result.
beforeAndAfter :: Int -> State Int (Int, Int)
beforeAndAfter n = do 
  before <- get 
  modify (+ n)
  after <- get
  pure (before, after)


-- 2.4 OUTPUT: Trace each action and give the final pair.
-- runState (sequence [get, modify (+3) >> get, modify (*2) >> get]) (4 :: Int)
-- Your result and state after each action:

-- 2.5 TYPE AND OUTPUT: (,) <$> get <*> (modify (+1) >> get)
-- Give the most general whole type. Then run it from (6 :: Int) on paper.
-- Track what the first action captures and when the second action reads.
-- Your type, intermediate values, and runner pair:

-- 2.6 IMPLEMENT: Transform the stored pair and return its old first field.
-- Use get and put. Predict runState (updateSecond (drop 1)) (True, "abc").
updateSecond :: (b -> b) -> State (a,b) a
updateSecond f = do 
  (first, second) <- get 
  put (first, f second)
  pure first 

checkUpdateSecond :: IO ()
checkUpdateSecond = runChecks
  [check "return first field and update second" (runState (updateSecond reverse) (False, "ab") == (False, (False, "ba")))]

checkLessThanSaved :: IO ()
checkLessThanSaved = runChecks
  [ check "compare with saved value" (let (f, _) = runState lessThanSaved (-2 :: Int)
                                       in f (-3) && not (f (-2)))
  , check "keep state" (snd (runState lessThanSaved (8 :: Int)) == 8)
  ]

checkBeforeAndAfter :: IO ()
checkBeforeAndAfter = runChecks
  [check "return both values and store the new one" (runState (put 7 >> beforeAndAfter (-2)) 0 == ((7,5),5))]
