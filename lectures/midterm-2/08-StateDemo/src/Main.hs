module Main where

-- Make sure you run this via `stack run` in the top-level folder.

import qualified ParserLib as P

import Control.Monad
import System.Environment
import Test.QuickCheck

import Control.Monad.Identity 
    ( Identity(runIdentity) )
import Control.Monad.State
    ( StateT(runStateT), MonadState(put, get), lift )
import Control.Monad.Except
    ( ExceptT, MonadError(throwError), runExceptT )


import Data.Map (Map)
import qualified Data.Map as Map

data Term = Const Int 
          | Add Term Term
          | Var String
--          | Inc String -- x++
--          | Div Term Term

-- 1. FP
-- 2. Maybe (no state)
-- 3. State (no maybe)
-- 4. Combine? not yet
-- 5. Generic Monad
-- 6. Identity
-- 7. Monad Error
-- 8. Monad State
-- 9. StateT Store Maybe

-- type Store = Map String Int

main :: IO ()
main = do
  putStrLn "Hi"

