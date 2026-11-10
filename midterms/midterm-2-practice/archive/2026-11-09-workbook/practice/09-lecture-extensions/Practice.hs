{-# LANGUAGE GADTs #-}
module LectureExtensions where

import StudyCheck (check, runChecks)

-- Optional companion for 9.3. See lesson.tex for the written extension questions.
data Expr a where
  Number :: Int -> Expr Int
  Truth :: Bool -> Expr Bool
  Plus :: Expr Int -> Expr Int -> Expr Int
  If :: Expr Bool -> Expr a -> Expr a -> Expr a

evalExpr :: Expr a -> a
evalExpr = undefined

checks :: IO ()
checks = runChecks
  [ check "integer expression" (evalExpr (Plus (Number 4) (Number 7)) == 11)
  , check "Boolean branch" (evalExpr (If (Truth False) (Truth True) (Truth False)) == False)
  , check "lazy conditional" (evalExpr (If (Truth True) (Number 3) (error "unselected branch")) == 3)
  ]
