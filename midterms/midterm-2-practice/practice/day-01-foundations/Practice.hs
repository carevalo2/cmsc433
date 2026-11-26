module Day01 where

import StudyCheck (check, runChecks)

-- Day 1. See the practice guide for the GHCi command and lecture links.
-- Work one prompt at a time. Predict and explain before checking.

-- Worked: (,) 'x' :: b -> (Char, b). Applying one argument leaves an arrow.
-- Worked: [n + 1 | n <- [1,2,3 :: Int], n > 1] yields [3,4].

-- 1.1 TYPE: \xs -> [b | b <- xs, not b]
-- Reason from the guard to the input, then from the expression to the output.
-- Your type and reason: 

-- 1.2 TYPE AND OUTPUT: (,) <$> Just 'x', then ((,) <$> Just 'x') <*> Just True.
-- Say what is inside Maybe after each operation. For the first expression,
-- describe the function inside Just without trying to print it.
-- Your types and outputs:

-- 1.3 IMPLEMENT: Keep the False values using a list comprehension.
-- Then predict the output on [False, True, False, True].
keepFalse :: [Bool] -> [Bool]
keepFalse xs = [x | x <- xs, not x]

-- 1.4 OUTPUT: [(x,y) | x <- [1,3 :: Int], y <- [0,2,4], x < y, even y]
-- Show which y values survive for each x and give the output in order.
-- Your trace: [(1,2),(1,4),(3,4)]

-- 1.5 TYPE: \f x -> [f (Just x), f Nothing]
-- Explain why the two calls use the same input and output types for f.
-- Your type and reason: (Maybe a -> b) -> a -> [b]

checkKeepFalse :: IO ()
checkKeepFalse = runChecks
  [check "keep false values" (keepFalse [True, False, False] == [False, False])]
