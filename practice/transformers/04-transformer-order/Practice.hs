module Practice where

import Control.Monad.Except (ExceptT, runExceptT, throwError)
import Control.Monad.State (State, StateT, modify, runState, runStateT)

-- Discuss the types BEFORE running the examples.
-- Same features, different order:
type StateOutside a = StateT Int (Either String) a
type ErrorOutside a = ExceptT String (State Int) a

-- 1. Expand each runner output type for a = Bool.
-- runStateT action initial :: ...
-- runState (runExceptT action) initial :: ...
-- Which output shape has a state even when the result is Left?
-- Your answer:
--

failStateOutside :: StateOutside ()
failStateOutside = do
  modify (+ 1)
  throwError "Stopped"
  modify (+ 100)

failErrorOutside :: ErrorOutside ()
failErrorOutside = do
  modify (+ 1)
  throwError "Stopped"
  modify (+ 100)

-- 2. Predict values BEFORE running:
--   runStateT failStateOutside 10
--   runState (runExceptT failErrorOutside) 10
-- Explain which updates occur and which states are exposed to the caller.
-- These examples involve pure State, not external effects or IO rollback.
-- Your answer:
--

-- 3. Implement the same behavior in both stacks using modify and throwError:
-- increment an attempt counter BEFORE checking the denominator;
-- reject zero with "Division by zero"; otherwise return integer division.
attemptStateOutside :: Int -> Int -> StateOutside Int
attemptStateOutside = undefined

attemptErrorOutside :: Int -> Int -> ErrorOutside Int
attemptErrorOutside = undefined

-- 4. Once implemented, predict both success and failure runs with initial
-- state 0, using arguments (12,3) and (12,0). Then compare their output shapes.
-- Your answer:
--

checkAttempts :: Bool
checkAttempts = and
  [ runStateT (attemptStateOutside 12 3) 0 == Right (4, 1)
  , runState (runExceptT (attemptErrorOutside 12 3)) 0 == (Right 4, 1)
  , runStateT (attemptStateOutside 12 0) 0 == Left "Division by zero"
  , runState (runExceptT (attemptErrorOutside 12 0)) 0
      == (Left "Division by zero", 1)
  ]

-- 5. Advanced independent transfer:
-- Write a division evaluator in EACH stack (define your own Val/Div type).
-- Evaluate left before right; count attempted divisions after evaluating both
-- operands, before checking the denominator. Trace a nested expression that
-- performs one successful division and then fails. Explain your choice of
-- stack if the caller needs the attempt count even after failure.
-- Your code and explanation:
--
