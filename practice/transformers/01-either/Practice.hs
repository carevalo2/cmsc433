module Practice where

import Text.Read (readMaybe)

-- Read with your tutor before Question 1:
-- data Either e a = Left e | Right a
-- Either chooses between two kinds of value. For error handling we conventionally
-- use Left for an error and Right for success. Either String Int therefore holds
-- either an error message or a successful integer. This convention is not a
-- restriction on what the datatype can represent.
-- Bind passes a Right value to the next function; Left skips that function.
-- pure wraps a success with Right. fmap transforms only a Right's contents.

-- 1. Give the type of the contents of each constructor in Either String Int.
-- Then predict these VALUES (not just their types), explaining each:
--   (+ 2) <$> (Right 5 :: Either String Int)
--   (+ 2) <$> (Left "missing" :: Either String Int)
-- Your answer:
--

-- 2. Return Right n when n > 0, otherwise Left "Must be positive".
checkPositive :: Int -> Either String Int
checkPositive n = 
  if n <= 0 then Left "Must be positive"
  else Right n

checkPositiveCases :: Bool
checkPositiveCases = and
  [ checkPositive 7 == Right 7
  , checkPositive 0 == Left "Must be positive"
  , checkPositive (-2) == Left "Must be positive"
  ]

-- 3. Convert readMaybe's failure into Left "Not an integer".
-- On success, use checkPositive. Pattern matching on readMaybe is allowed.
parsePositive :: String -> Either String Int
parsePositive xs = 
  case readMaybe xs of 
    Nothing -> Left "Not an integer"
    Just n -> checkPositive n

checkParsePositive :: Bool
checkParsePositive = and
  [ parsePositive "12" == Right 12
  , parsePositive "bad" == Left "Not an integer"
  , parsePositive "-1" == Left "Must be positive"
  ]

-- 4. Predict both the type and value of each, with Int as the parsed type:
--   parsePositive <$> (Right "8" :: Either String String)
--   (Right "8" :: Either String String) >>= parsePositive
--   (Right "bad" :: Either String String) >>= parsePositive
-- Your answer
--

-- 5. Parse left, then right, using do notation; return their sum.
-- Preserve the first encountered error. Then rewrite using >>= in chat.
sumPositiveText :: String -> String -> Either String Int
sumPositiveText left right = do 
  leftRes <- parsePositive left
  rightRes <- parsePositive right 
  pure (leftRes + rightRes)


checkSumPositiveText :: Bool
checkSumPositiveText = and
  [ sumPositiveText "4" "7" == Right 11
  , sumPositiveText "bad" "-1" == Left "Not an integer"
  , sumPositiveText "0" "bad" == Left "Must be positive"
  ]

-- 6. Advanced transfer, modeled on the lecture evaluator.
-- Evaluate left operand before right. Reject a zero denominator with
-- Left "Division by zero". Use do notation and recursive calls.
data Expr = Val Int | Div Expr Expr deriving (Eq, Show)

evalEither :: Expr -> Either String Int
evalEither (Val n) = Right n
evalEither (Div left right) = do
  leftRes <- evalEither left 
  rightRes <- evalEither right 
  if rightRes == 0 then Left "Division by zero"
  else pure (leftRes `div` rightRes)
  

checkEvalEither :: Bool
checkEvalEither = and
  [ evalEither (Val 9) == Right 9
  , evalEither (Div (Div (Val 24) (Val 2)) (Val 3)) == Right 4
  , evalEither (Div (Val 3) (Val 0)) == Left "Division by zero"
  , evalEither (Div (Val 9) (Div (Val 1) (Val 2)))
      == Left "Division by zero"
  ]
