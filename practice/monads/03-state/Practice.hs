module Practice where

import Control.Monad.State (State, get, put, modify, runState, evalState, execState)

-- 1. Predict runState ticket 10. Which part is the returned result,
-- and which part is the final state? Trace each line before running.
-- Your answer:
--
ticket :: State Int Int
ticket = do
  old <- get
  put (old + 1)
  pure old

-- 2. Predict evalState ticket 10 and execState ticket 10.
-- Does pure old restore the old state? Explain.
-- Your answer:
--

-- 3. Increase the state by the supplied amount, then return the new state.
-- Use modify and get; do not call any runner inside the computation.
addToCounter :: Int -> State Int Int
addToCounter amount = do
  modify ((+) amount)
  get

checkAddToCounter :: Bool
checkAddToCounter = and
  [ runState (addToCounter 3) 10 == (13, 13)
  , runState (addToCounter 0) 10 == (10, 10)
  , runState (addToCounter (-2)) 10 == (8, 8)
  ]

-- 4. Predict runState (ticket >> ticket) 10.
-- Explain what is discarded by >> and what is passed to the next action.
-- Your answer:
--
