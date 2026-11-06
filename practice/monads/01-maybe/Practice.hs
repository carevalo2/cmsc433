module Practice where

-- 1. Predict exampleSuccess and exampleFailure. Explain whether the
-- function after >>= receives an input in each case. Answer before running.
-- Your answer:
--
exampleSuccess :: Maybe Int
exampleSuccess = Just 7 >>= (\n -> Just (n + 2))

exampleFailure :: Maybe Int
exampleFailure = Nothing >>= (\n -> Just (n + 2))

-- 2. Inspect :t (>>=) and :t (pure :: Int -> Maybe Int).
-- What are a, b, and m in exampleSuccess? What does pure do for Maybe?
-- Your answer:
--

-- 3. After discussing bind, implement this using >>= and pure, without
-- pattern matching. Both inputs must succeed; add their contained integers.
addMaybe :: Maybe Int -> Maybe Int -> Maybe Int
addMaybe mx my = mx >>= (\x -> my >>= (\y -> pure (x + y)))

checkAddMaybe :: Bool
checkAddMaybe = and
  [ addMaybe (Just 4) (Just 6) == Just 10
  , addMaybe Nothing (Just 6) == Nothing
  , addMaybe (Just 4) Nothing == Nothing
  , addMaybe Nothing Nothing == Nothing
  ]

-- 4. Independent transfer: describe how you would chain three fallible
-- steps. What happens if the middle step fails? No code needed yet.
-- Your answer:
--

addMaybe' :: Maybe Int -> Maybe Int -> Maybe Int
addMaybe' mx my = do 
  x <- mx
  y <- my
  pure (x + y)
