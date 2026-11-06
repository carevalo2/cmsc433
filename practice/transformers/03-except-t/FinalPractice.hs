module FinalPractice where

import Control.Monad.Except (ExceptT, runExceptT, throwError)
import Control.Monad.State (State, get, put, modify, runState)
import Control.Monad.Trans.Class (lift)

-- Final independent practice for 03-except-t; no solutions are included.
-- Sources: lectures/midterm-2/09-transformers/Transformers.hs, Steps 3-5,
-- and MtlExample.hs. Supplementary practice, not an exam prediction.
--
-- The state is a REMAINING BALANCE, not an attempt counter.
-- Assume a nonnegative initial balance and small Int values (no overflow).
-- Implement in order. Use do notation for actions and no runners inside them.
-- Run each check only after implementing its function; expect True.
-- If a check fails, explain the returned value and state separately in chat.
--
-- Load from the repository root:
-- ghci practice/transformers/03-except-t/FinalPractice.hs
-- Use :reload after editing.

type Budget a = ExceptT String (State Int) a

-- 1. Implement the runner using runExceptT and runState.
-- Take a Budget action and initial balance; expose BOTH its Either result
-- and final balance, including when the action fails.
runBudget :: Budget a -> Int -> (Either String a, Int)
runBudget action initial = runState (runExceptT action) initial

checkRunBudget :: Bool
checkRunBudget = and
  [ runBudget (pure True) 7 == (Right True, 7)
  , runBudget (throwError "Stopped" :: Budget ()) 7 == (Left "Stopped", 7)
  ]

-- 2. Use EXPLICIT lift for every state operation.
-- Reject a negative amount with "Negative credit" BEFORE changing the balance.
-- Otherwise add the amount to the balance and return the OLD balance.
-- Zero is allowed. Do not call runBudget/runState/runExceptT here.
credit :: Int -> Budget Int
credit amt = 
  if amt < 0 then throwError "Negative credit"
  else do 
    orig <- lift (get)
    lift (put (amt + orig)) >> pure orig

checkCredit :: Bool
checkCredit = and
  [ runBudget (credit 4) 9 == (Right 9, 13)
  , runBudget (credit 0) 9 == (Right 9, 9)
  , runBudget (credit (-2)) 9 == (Left "Negative credit", 9)
  ]

-- 3. Use mtl's get/put/modify directly, WITHOUT explicit lift.
-- First reject a negative amount with "Negative spend".
-- Then reject an amount greater than the balance with "Insufficient balance".
-- Neither failure changes the balance.
-- Otherwise subtract the amount and return the NEW balance.
-- Zero and spending the entire balance are allowed.
spend :: Int -> Budget Int
spend amt = 
  if amt < 0 then throwError "Negative spend"
  else do 
    balance <- get 
    if amt > balance then throwError "Insufficient balance"
    else 
      put (balance - amt) >> pure (balance - amt)

checkSpend :: Bool
checkSpend = and
  [ runBudget (spend 4) 9 == (Right 5, 5)
  , runBudget (spend 0) 9 == (Right 9, 9)
  , runBudget (spend 9) 9 == (Right 0, 0)
  , runBudget (spend 10) 9 == (Left "Insufficient balance", 9)
  , runBudget (spend (-2)) 9 == (Left "Negative spend", 9)
  ]

-- 4. Compose your spend action: spend the FIRST amount, then the SECOND.
-- On success return the TOTAL AMOUNT SPENT, not the remaining balance.
-- Reuse spend for validation and state changes; do not duplicate its logic.
-- Let errors propagate normally. Do not catch errors or restore the balance.
-- A failure skips later actions; earlier successful spending remains visible.
spendPair :: Int -> Int -> Budget Int
spendPair first second = do
  spend first
  spend second
  pure (first + second)

checkSpendPair :: Bool
checkSpendPair = and
  [ runBudget (spendPair 3 4) 10 == (Right 7, 3)
  , runBudget (spendPair 0 0) 10 == (Right 0, 10)
  , runBudget (spendPair 3 7) 10 == (Right 10, 0)
  , runBudget (spendPair 3 8) 10 == (Left "Insufficient balance", 7)
  , runBudget (spendPair 3 (-1)) 10 == (Left "Negative spend", 7)
  , runBudget (spendPair 11 (-1)) 10 == (Left "Insufficient balance", 10)
  , runBudget (spendPair (-1) 3) 10 == (Left "Negative spend", 10)
  ]

-- Run only after completing all four functions.
checkAll :: Bool
checkAll = and [checkRunBudget, checkCredit, checkSpend, checkSpendPair]
