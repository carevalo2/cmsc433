module Practice where

import Control.Monad.State (StateT, get, put, modify, runStateT)
import Control.Monad.Trans.Class (lift)

-- StateT s m a adds state to an underlying monad m.
-- Here runStateT :: Counter a -> Int -> Either String (a, Int).
-- lift adapts an underlying Either action into Counter; it does not unwrap it.
-- Explain this shape before tracing anything.
type Counter a = StateT Int (Either String) a

-- 1. Predict both runs. Label returned value and final state.
--   runStateT bump 4
--   runStateT (bump >> bump) 4
-- Your answer:
--
bump :: Counter Int
bump = do
  old <- get
  put (old + 1)
  pure old

-- 2. Fail via lift (Left "Negative amount") if amount < 0;
-- fail via lift (Left "Insufficient balance") if amount exceeds balance.
-- Otherwise subtract amount and return the ORIGINAL balance.
withdraw :: Int -> Counter Int
withdraw amount = do 
  balance <- get 
  if amount < 0 then lift (Left "Negative amount")
  else if amount > balance then lift (Left "Insufficient balance")
  else put (balance - amount) >> pure balance

checkWithdraw :: Bool
checkWithdraw = and
  [ runStateT (withdraw 3) 10 == Right (10, 7)
  , runStateT (withdraw 0) 10 == Right (10, 10)
  , runStateT (withdraw (-1)) 10 == Left "Negative amount"
  , runStateT (withdraw 11) 10 == Left "Insufficient balance"
  ]

-- 3. After implementing withdraw, predict:
--   runStateT (withdraw 3 >> withdraw 8) 10
-- Is a final balance exposed? Explain using the runner's type.
-- Your answer:
--

-- 4. Advanced transfer: evaluate left then right; count each SUCCESSFUL
-- division with modify (+1). Check for zero before incrementing.
-- Literals do not change the counter. Reject zero with "Division by zero".
-- Do not call a runner inside the evaluator.
data Expr = Val Int | Div Expr Expr deriving (Eq, Show)

evalCount :: Expr -> Counter Int
evalCount (Val n) = pure n
evalCount (Div left right) = do 
  leftRes <- evalCount left 
  rightRes <- evalCount right 
  if rightRes == 0 then lift (Left "Division by zero")
  else modify (+1) >> pure (leftRes `div` rightRes)

checkEvalCount :: Bool
checkEvalCount = and
  [ runStateT (evalCount (Val 7)) 0 == Right (7, 0)
  , runStateT (evalCount (Div (Div (Val 24) (Val 2)) (Val 3))) 0
      == Right (4, 2)
  , runStateT (evalCount (Div (Val 2) (Val 0))) 0
      == Left "Division by zero"
  ]

-- 5. Independent explanation: why does pure not update the counter,
-- and why can an error branch have the same action type as a success branch?
-- Your answer:
--
