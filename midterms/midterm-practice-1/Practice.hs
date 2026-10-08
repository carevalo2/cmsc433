module Practice where

import Control.Monad.State.Lazy
import Data.List (delete)

-- Replace undefined placeholders; written answers belong in Written.md.

{-
Q3. Expressions from types (20 points; 2 each)

Implement q3a through q3j below. Use meaningful, total
expressions: avoid constant empty outputs when a useful construction exists.
If the type prevents you from constructing an output, explain why and use
an appropriate total result when one exists. If no total implementation
exists, give the explanation in Written.md instead of pretending it does.
You may use Prelude functions, lambdas, comprehensions, and `do` syntax.

For q3c, use all pairs from the two lists, not just corresponding positions.
For q3g, remove occurrences of the supplied element, preserving order.
For q3h, print each element's representation and return the representation
of the whole list. Other behavior is determined by your meaningful choice.
-}

-- | Builds a meaningful list from a Boolean.
q3a :: Bool -> [Bool]
q3a = \x -> if x then [x] else []

-- | Investigates what can be produced from an unrelated input type.
q3b :: a -> Maybe b
q3b x = Nothing

-- | Applies a predicate to every pair drawn from two lists.
q3c :: (Int -> Char -> Bool) -> [Int] -> [Char] -> [Bool]
q3c p a b = [p i c | i <- a, c <- b]

-- | Combines two optional inputs.
q3d :: (a -> b -> c) -> Maybe a -> Maybe b -> Maybe c
q3d = liftA2

-- | Maps inputs and retains outputs satisfying a predicate.
q3e :: (a -> b) -> (b -> Bool) -> [a] -> [b]
q3e f1 f2 xs = filter f2 (map f1 xs)

-- | Pairs an optional input with each of its generated outputs.
q3f :: Maybe a -> (a -> [b]) -> [(a, b)]
q3f ma f = maybe [] (\x -> map (\y -> (x, y)) (f x)) ma

-- | Removes occurrences of a given value while preserving order.
q3g :: Eq a => a -> [a] -> [a]
q3g a xs = filter (\x -> x /= a) xs

-- | Prints each value and returns the representation of the whole list.
q3h :: Show a => [a] -> IO String
q3h xs = return (map show xs)

-- | Applies a curried function to a pair.
q3i :: (a, b) -> (a -> b -> c) -> c
q3i = undefined

-- | Investigates whether this type has a total implementation.
q3j :: ((a, b) -> c) -> c
q3j = undefined

{-
Q5. Recursive Haskell (20 points)

Implement the functions below. No list library functions, folds, or
comprehensions: use explicit recursion, pattern matching, `[]`, and `(:)`.
You may define your own recursive helpers.

1. `interleaveRemainder`: alternate elements starting with the first list;
   when either ends, retain all remaining elements of the other. (10 points)
2. `chooseOne`: produce every way to select one element and retain the
   remaining elements in their original order. Return one result per input
   position, including duplicate results for duplicate values. (10 points)

interleaveRemainder [1,2,3] [8] = [1,8,2,3]
interleaveRemainder [] [8,9] = [8,9]
chooseOne [1,2,3] = [(1,[2,3]), (2,[1,3]), (3,[1,2])]
chooseOne [] = []

Write at least three test cases per function after your first paper attempt.
Include empty and unequal-length inputs for the first, and duplicate values
for the second. Explain how the recursive result is transformed in Q5b.
-}

-- | Alternates two lists and retains any remaining elements.
interleaveRemainder :: [a] -> [a] -> [a]
interleaveRemainder = undefined

-- | Selects each position together with the remaining elements.
chooseOne :: [a] -> [(a, [a])]
chooseOne = undefined

{-
S1. Monadic constructions (8 of 20 points)

Implement these signatures below (2 points each). The
same meaningful/total-expression policy as Q3 applies.

For s1a, fail if any element is `Nothing`; otherwise preserve all values
in order. For s1b, execute actions left to right and collect their results.
For s1c, read the state and return the function's result without changing
the state. For s1d, return the swapped pair without changing the state.
-}

-- | Collects optional values, failing if any input is absent.
s1a :: [Maybe a] -> Maybe [a]
s1a = undefined

-- | Runs an action for each input and collects results in order.
s1b :: Monad m => [a] -> (a -> m b) -> m [b]
s1b = undefined

-- | Computes a result from the state without changing the state.
s1c :: (a -> b -> c) -> b -> State a c
s1c = undefined

-- | Returns the swapped state pair without changing the state.
s1d :: State (a, b) (b, a)
s1d = undefined

-- | Provided tracing code: collects the results of monadic actions.
gatherActions :: Monad m => [m a] -> m [a]
gatherActions [] = return []
gatherActions (action : actions) = do
  x <- action
  xs <- gatherActions actions
  return (x : xs)

{-
S3. Implementation (3 of 15 points)

Implement gatherViaMapM using mapM, with no explicit recursion.
The evaluation questions are in Written.md.
-}

-- | Collects action results using mapM rather than explicit recursion.
gatherViaMapM :: Monad m => [m a] -> m [a]
gatherViaMapM = undefined

-- | Provided tracing code: returns a largest value and a rebuilt list.
scanLargest :: [Int] -> Int -> (Int, [Int])
scanLargest [] seed = (seed, [])
scanLargest [x] seed = (x, [seed])
scanLargest (x : xs) seed = (max largest x, seed : rebuilt)
  where
    (largest, rebuilt) = scanLargest xs seed

{-
S4. Lazy tuple bindings: implementation (6 of 10 points)

Implement `replaceByLargest`, replacing every element with the list's
maximum and preserving length. The empty list must return `[]`. Use only
calls to `scanLargest`, pattern matching, and tuple/`let`/`where` bindings;
do not use explicit recursion, folds, `maximum`, `map`, or `replicate`.
At most two calls to `scanLargest` are allowed. (6 points)

replaceByLargest [2,5,1] = [5,5,5]
replaceByLargest [-4,-9] = [-4,-4]
replaceByLargest [] = []

Optional ungraded challenge: use one call with a recursive `let` binding.
Explain which dependencies allow useful output rather than a demand cycle.
-}

-- | Replaces every element with the largest element of the input.
replaceByLargest :: [Int] -> [Int]
replaceByLargest = undefined

-- Add test drivers after your paper attempt. Give each a type signature.

weave :: [a] -> [a] -> [a]
weave [] [] = []
weave (x : xs) (y : ys) = 
  x : y : weave xs ys 

powerset :: [a] -> [[a]]
powerset [] = [[]]
powerset (x : xs) = (map (x :) (powerset xs)) ++ powerset xs