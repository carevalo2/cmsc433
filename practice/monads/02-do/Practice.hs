module Practice where

import Text.Read (readMaybe)

-- 1. Predict parseAndAdd "8" "3" and parseAndAdd "eight" "3".
-- Identify the types of x, y, and the whole do block.
-- Your answer:
--
parseAndAdd :: String -> String -> Maybe Int
parseAndAdd first second = do
  x <- readMaybe first
  y <- readMaybe second
  let total = x + y
  pure total

-- 2. Rewrite parseAndAdd on paper using >>= and lambdas.
-- Explain the difference between <- and let. Does pure exit a function
-- like return in an imperative language?
-- Your answer:
--

-- 3. Use do notation to parse an integer, reject negative values with
-- Nothing, and return twice the value otherwise. Zero is allowed.
parseDouble :: String -> Maybe Int
parseDouble = undefined

checkParseDouble :: Bool
checkParseDouble = and
  [ parseDouble "5" == Just 10
  , parseDouble "0" == Just 0
  , parseDouble "-1" == Nothing
  , parseDouble "hello" == Nothing
  ]

-- 4. Predict both expressions. How does >> differ from >>= ?
-- (Just 9 >> Just 2) :: Maybe Int
-- (Nothing >> Just 2) :: Maybe Int
-- Your answer:
--
