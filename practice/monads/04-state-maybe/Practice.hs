module Practice where

import Control.Monad.State (StateT, get, put, lift, runStateT, evalStateT, execStateT)
import Text.Read (readMaybe)

type Counter = StateT Int Maybe

-- 1. Predict runStateT addText "4" carefully using the parenthesized
-- application below. What happens to the result when parsing fails?
-- Compare with the successful result: where are Maybe and the pair?
-- Evaluate: runStateT (addText "4") 10
-- Evaluate: runStateT (addText "four") 10
-- Your answer:
--
addText :: String -> Counter Int
addText text = do
  amount <- lift (readMaybe text)
  old <- get
  put (old + amount)
  pure old

-- 2. What does lift connect here? Why can't readMaybe text be used as
-- the right side of <- directly in this StateT do block?
-- Compare evalStateT and execStateT on the successful example.
-- Your answer:
--

-- 3. Spend a nonnegative amount from the counter. Fail with Nothing if
-- the amount is negative or exceeds the balance. Otherwise update the
-- balance and return (). Use lift to introduce failure.
spend :: Int -> Counter ()
spend amount = do
  balance <- get
  if amount < 0 || amount > balance then 
    lift Nothing 
  else 
    put(balance - amount)

checkSpend :: Bool
checkSpend = and
  [ runStateT (spend 3) 10 == Just ((), 7)
  , runStateT (spend 10) 10 == Just ((), 0)
  , runStateT (spend 0) 10 == Just ((), 10)
  , runStateT (spend 11) 10 == Nothing
  , runStateT (spend (-1)) 10 == Nothing
  ]

-- 4. After implementing spend, predict:
-- runStateT (spend 3 >> spend 8) 10
-- Is a final state exposed to the caller if the computation fails?
-- Then explain how Counter () differs from Counter Int, and connect
-- that distinction to Eval () and Eval Value in Homework 4.
-- Your answer:
--
