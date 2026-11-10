module TypeCodeMock where

-- TOPIC MOCK: complete this file independently; feedback after the whole file.
-- Untimed practice, no points. Sample styles: Q2 (p.2) and Q4(b) (p.4).
-- No undefined/error/intentional nontermination as answers.
-- Current exam scope/rules remain unconfirmed. These are changed topic questions.

-- 1. Collect Right values in order, or return the first Left error encountered
-- left-to-right. Empty input succeeds with an empty list. Explicit recursion;
-- no sequence/mapM/traverse or equivalent helpers.
collectEither :: [Either e a] -> Either e [a]
collectEither = undefined

-- 2. Sequence actions left-to-right and collect results in order. Use exactly
-- one call to library mapM, without explicit recursion.
-- mapM :: Monad m => (a -> m b) -> [a] -> m [b]
sequenceViaMapM :: Monad m => [m a] -> m [a]
sequenceViaMapM = undefined

-- 3. Is a total definition possible for this type for ALL m and a?
--     Monad m => m a
-- Give a justification, considering more than just one convenient monad.
-- Your written answer:

-- Assistance used (fill after completing the mock):
