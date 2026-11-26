module Day08 where

import StudyState

-- Day 8. See the practice guide for the GHCi command and lecture links.
-- Attempt the set independently before evaluating code or requesting feedback.

-- 8.1 IMPLEMENT: If the stored list is nonempty, remove its head and return
-- Just the result of applying f to that head. If empty, return Nothing and
-- keep the state. First predict runState (popWith length) ["cat","hi"].
-- Your prediction and the types of both output components:
popWith :: (a -> b) -> State [a] (Maybe b)
popWith = undefined

-- 8.2 TYPE AND OUTPUT: Infer the type of this action before running it.
-- sequence [popWith length, popWith length, popWith length]
-- Then run it with ["cat", "hi"]. Explain where each Nothing or Just lives.
-- Your type, trace, and output:

-- 8.3 TYPE OR ILL-TYPED: Give reasons for both.
--   (:) <$> (modify reverse >> get)
--   \xs -> [x | x <- xs, x + 1]
-- Your types or conflicts:

-- 8.4 IMPLEMENT: Apply f to each input, sequence the resulting Maybe
-- actions, then map g over the successful list of payloads. Give the type
-- of the expression before the final mapping. Use mapM and fmap.
collectAndMap :: (a -> Maybe b) -> (b -> c) -> [a] -> Maybe [c]
collectAndMap = undefined

-- 8.5 LAZINESS: Write a one-call implementation using build to replace all
-- entries with the product. Use no other recursive helper. Predict the
-- empty output and a nonempty output, then explain why the binding works.
build :: [Int] -> Int -> (Int, [Int])
build [] _ = (1, [])
build (x:xs) fill = (x * productSoFar, fill : rest)
  where (productSoFar, rest) = build xs fill

fillWithProduct :: [Int] -> [Int]
fillWithProduct = undefined
