module Practice where

import Control.Monad.Except (ExceptT, runExceptT, throwError)
import Control.Monad.State (State, get, put, modify, runState)
import Control.Monad.Trans.Class (lift)

-- ExceptT e m a adds error handling to an underlying monad m.
-- runExceptT :: ExceptT e m a -> m (Either e a)
-- Here runExceptT produces a State action. runState then supplies initial state.
-- throwError introduces failure; lift adapts an underlying State action.
-- We use explicit lift initially to make the layers visible.
type Checked a = ExceptT String (State Int) a

runChecked :: Checked a -> Int -> (Either String a, Int)
runChecked action initial = runState (runExceptT action) initial

-- 1. Predict runChecked sample 5. Explain the role of each lift.
-- Your answer:
--
sample :: Checked Int
sample = do
  old <- lift get
  lift (put (old + 2))
  pure old

-- 2. Reject negative amount using throwError "Negative amount".
-- Otherwise add amount to the state and return the NEW state.
-- Use explicit lift for get/put/modify; no runners inside the action.
addChecked :: Int -> Checked Int
addChecked = undefined

checkAddChecked :: Bool
checkAddChecked = and
  [ runChecked (addChecked 3) 10 == (Right 13, 13)
  , runChecked (addChecked 0) 10 == (Right 10, 10)
  , runChecked (addChecked (-1)) 10 == (Left "Negative amount", 10)
  ]

-- 3. Predict runChecked partialFailure 0 BEFORE executing it.
-- Which action is skipped? Does the caller see any state?
-- Your answer:
--
partialFailure :: Checked ()
partialFailure = do
  lift (modify (+ 1))
  throwError "Stopped"
  lift (modify (+ 100))

-- 4. Independent coding transfer: add 1 to an attempt counter FIRST.
-- Then reject a zero denominator with throwError "Division by zero";
-- otherwise return numerator `div` denominator. The state counts attempts.
attemptDivision :: Int -> Int -> Checked Int
attemptDivision = undefined

checkAttemptDivision :: Bool
checkAttemptDivision = and
  [ runChecked (attemptDivision 12 3) 0 == (Right 4, 1)
  , runChecked (attemptDivision 12 0) 0 == (Left "Division by zero", 1)
  , runChecked (attemptDivision 12 3 >> attemptDivision 5 0) 0
      == (Left "Division by zero", 2)
  ]

-- 5. Lecture connection, after explicit lift is comfortable:
-- mtl also supplies MonadState operations directly for this stack.
-- Rewrite addChecked without explicit lift using that interface.
-- Explain why direct get is supported; this does not mean lift unwraps values.
addCheckedMtl :: Int -> Checked Int
addCheckedMtl = undefined
