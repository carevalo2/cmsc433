module HaskellCodingPractice where

import Data.List (sort)

{-
CMSC 433: Haskell coding practice (20 points + 40-point extra practice)
Modeled on Question 5 of the Spring 2024 midterm.
Suggested practice time: 30 minutes; this is not an official exam limit.

Implement the two main functions and the extra practice below.
You may use standard library functions,
list comprehensions, and helper functions, as in the original exam.
Follow the course style guide: complete pattern matches, explicit signatures
for helpers, and no head, tail, or fromJust. Replace the undefined stubs.

Question (a): unweave (10 points)

Given one list, return two lists: the first contains elements at positions
1, 3, 5, ...; the second contains elements at positions 2, 4, 6, ... .
Preserve order within each result list. Handle odd lengths and the empty list.

unweave [1,4,2,5,3,6] = ([1,2,3], [4,5,6])
unweave [8,9,10]      = ([8,10], [9])
unweave [7]           = ([7], [])
unweave []            = ([], [])
-}

-- | Splits alternating positions into two lists, preserving their order.
unweave :: [a] -> ([a], [a])
unweave [] = ([], [])
unweave [x] = ([x], [])
unweave (x : y : rest) = let (xs, ys) = unweave rest in (x : xs, y : ys)


{-
Question (b): subsetsOfSize (10 points)

Given an integer k and a list, produce every sublist containing exactly k
elements. Each sublist must preserve the original order. The outer result
list may be in any order.

Choose by position: equal values at different positions count as different
choices, so duplicate result lists must be retained. You do not need Eq a.
For k < 0 or k greater than the input length, return no sublists.
For k == 0, there is exactly one choice: the empty sublist.

subsetsOfSize 2 [1,2,3] = [[1,2], [1,3], [2,3]]  (in any order)
subsetsOfSize 1 [4,4]   = [[4], [4]]
subsetsOfSize 0 [1,2]   = [[]]
subsetsOfSize 3 [1,2]   = []
subsetsOfSize (-1) [1]  = []
-}

-- | Generates all order-preserving sublists with exactly k elements.
subsetsOfSize :: Int -> [a] -> [[a]]
subsetsOfSize 0 _ = [[]]
subsetsOfSize _ [] = []
subsetsOfSize n (x : xs) 
  | n < 0 = []
  | n > length (x : xs) = []
  | otherwise = map (x :) (subsetsOfSize (n - 1) xs) ++ (subsetsOfSize n xs)




{-
Extra practice: subsetsWithSum (10 points)

Given a target sum and a finite list of integers, return every sublist whose
elements add up to the target. Preserve the original order within each
sublist. The outer result list may be in any order.

Choose by position: duplicate values at different positions count as
different choices, and duplicate result lists must be retained. Inputs may
contain zero and negative values. A sublist may have any length, including
zero. Return no results when no sublist has the requested sum.

subsetsWithSum 3 [1,2,3] = [[1,2], [3]]       (in any order)
subsetsWithSum 2 [1,1,2] = [[1,1], [2]]       (in any order)
subsetsWithSum 1 [1,1]   = [[1], [1]]
subsetsWithSum 0 []      = [[]]
subsetsWithSum 4 [1,2]   = []
subsetsWithSum 0 [0]     = [[], [0]]          (in any order)
subsetsWithSum 0 [1,-1]  = [[], [1,-1]]       (in any order)

Implement the function below. Run runSumTests after replacing its stub.
-}

-- | Generates all order-preserving sublists with the requested sum.
subsetsWithSum :: Int -> [Int] -> [[Int]]
subsetsWithSum n [] 
  | n == 0 = [[]]
  | otherwise = []
subsetsWithSum n (y : ys) = 
  map (y :) (subsetsWithSum (n - y) ys) ++ subsetsWithSum n ys

{-
Extra practice: interleavings (10 points)

Given two finite lists, return every way to merge them into one list while
preserving the order of the elements from each original list. Every result
must contain all elements from both lists. The outer result list may be in
any order. The input lists may have different lengths.

Different choices of input positions count separately, even when they
produce identical results. Retain those duplicates; no Eq constraint is
needed. You may use the library functions and techniques allowed above.

interleavings [1,2] [3]
  = [[1,2,3], [1,3,2], [3,1,2]]              (in any order)
interleavings [1] [2]
  = [[1,2], [2,1]]                          (in any order)
interleavings [] [4,5] = [[4,5]]
interleavings [4,5] [] = [[4,5]]
interleavings [] []    = [[]]
interleavings [1] [1] = [[1,1], [1,1]]

Implement the function below. Run runInterleavingTests after replacing
its stub.
-}

-- | Generates all merges that preserve each input list's element order.
interleavings :: [a] -> [a] -> [[a]]
interleavings [] [] = [[]]
interleavings a [] = [a]
interleavings [] b = [b]
interleavings (x : xs) (y : ys) = 
  map (x :) (interleavings (xs) (y : ys)) ++ map (y : ) (interleavings (x : xs) (ys))


-- Supplied checks for the two main questions.
-- Sorting compares only outer order and still detects missing duplicates.

-- | Checks the examples and boundary cases for both practice functions.
practiceTests :: [(String, Bool)]
practiceTests =
  [ ("unweave: empty", unweave ([] :: [Int]) == ([], []))
  , ("unweave: singleton", unweave [7 :: Int] == ([7], []))
  , ("unweave: even", unweave [1,4,2,5,3,6 :: Int] == ([1,2,3], [4,5,6]))
  , ("unweave: odd", unweave [8,9,10 :: Int] == ([8,10], [9]))
  , ("subsets: pairs", sort (subsetsOfSize 2 [1,2,3 :: Int])
      == sort [[1,2], [1,3], [2,3]])
  , ("subsets: duplicates", subsetsOfSize 1 [4,4 :: Int] == [[4], [4]])
  , ("subsets: zero", subsetsOfSize 0 [1,2 :: Int] == [[]])
  , ("subsets: zero and empty", subsetsOfSize 0 ([] :: [Int]) == [[]])
  , ("subsets: positive and empty", subsetsOfSize 1 ([] :: [Int]) == [])
  , ("subsets: too large", subsetsOfSize 3 [1,2 :: Int] == [])
  , ("subsets: negative", subsetsOfSize (-1) [1 :: Int] == [])
  , ("subsets: whole list", subsetsOfSize 3 [1,2,3 :: Int] == [[1,2,3]])
  ]

-- | Prints the result of each supplied check after the stubs are implemented.
runTests :: IO ()
runTests = mapM_ report practiceTests
  where
    report :: (String, Bool) -> IO ()
    report (label, passed) =
      putStrLn (label ++ if passed then ": PASS" else ": FAIL")

-- | Checks sum-based choices, duplicates, zeros, and negative values.
sumTests :: [(String, Bool)]
sumTests =
  [ ("sum: ordinary", sort (subsetsWithSum 3 [1,2,3])
      == sort [[1,2], [3]])
  , ("sum: different lengths", sort (subsetsWithSum 2 [1,1,2])
      == sort [[1,1], [2]])
  , ("sum: duplicates", subsetsWithSum 1 [1,1] == [[1], [1]])
  , ("sum: zero and empty", subsetsWithSum 0 [] == [[]])
  , ("sum: nonzero and empty", subsetsWithSum 3 [] == [])
  , ("sum: impossible", subsetsWithSum 4 [1,2] == [])
  , ("sum: zero element", sort (subsetsWithSum 0 [0]) == sort [[], [0]])
  , ("sum: two zeros", sort (subsetsWithSum 0 [0,0])
      == sort [[], [0], [0], [0,0]])
  , ("sum: canceling values", sort (subsetsWithSum 0 [1,-1])
      == sort [[], [1,-1]])
  , ("sum: negative target", sort (subsetsWithSum (-2) [-3,1,-2])
      == sort [[-3,1], [-2]])
  ]

-- | Prints the extra practice results after subsetsWithSum is implemented.
runSumTests :: IO ()
runSumTests = mapM_ report sumTests
  where
    report :: (String, Bool) -> IO ()
    report (label, passed) =
      putStrLn (label ++ if passed then ": PASS" else ": FAIL")

-- | Checks ordered merges, empty inputs, unequal lengths, and duplicates.
interleavingTests :: [(String, Bool)]
interleavingTests =
  [ ("merge: unequal", sort (interleavings [1,2 :: Int] [3])
      == sort [[1,2,3], [1,3,2], [3,1,2]])
  , ("merge: singletons", sort (interleavings [1 :: Int] [2])
      == sort [[1,2], [2,1]])
  , ("merge: left empty", interleavings [] [4,5 :: Int] == [[4,5]])
  , ("merge: right empty", interleavings [4,5 :: Int] [] == [[4,5]])
  , ("merge: both empty", interleavings ([] :: [Int]) [] == [[]])
  , ("merge: duplicates", interleavings [1 :: Int] [1] == [[1,1], [1,1]])
  , ("merge: order", sort (interleavings [1,2 :: Int] [3,4])
      == sort [[1,2,3,4], [1,3,2,4], [1,3,4,2],
               [3,1,2,4], [3,1,4,2], [3,4,1,2]])
  ]

-- | Prints the extra practice results after interleavings is implemented.
runInterleavingTests :: IO ()
runInterleavingTests = mapM_ report interleavingTests
  where
    report :: (String, Bool) -> IO ()
    report (label, passed) =
      putStrLn (label ++ if passed then ": PASS" else ": FAIL")

{-
Extra practice: weaveThree (10 points)
Directly modeled on Question 5(a), weave, in the Spring 2024 midterm.

Implement a function weaveThree that, given three lists with elements of
the same type, returns a list with elements alternating between the three
lists: one from the first, one from the second, one from the third, then
repeat. Preserve the order of elements from each input list.

For example:
  weaveThree [1,2,3] [4,5,6] [7,8,9] = [1,4,7,2,5,8,3,6,9]
  weaveThree ['a','b'] ['c','d'] ['e','f'] = "acebdf"

You can assume that all three lists have the same length, including zero.
Keep your pattern matches exhaustive; behavior outside that assumption
is not assessed. The same permitted techniques and style rules apply.

Implement the function below. Run runWeaveThreeTests after replacing
its stub.
-}

-- | Alternates elements from three equal-length lists in input order.
weaveThree :: [a] -> [a] -> [a] -> [a]
weaveThree [] [] [] = []
weaveThree (x : xs) (y : ys) (z : zs) = 
  x : y : z : weaveThree xs ys zs

-- | Checks the three-list weaving examples and equal-length boundaries.
weaveThreeTests :: [(String, Bool)]
weaveThreeTests =
  [ ("weaveThree: empty", weaveThree ([] :: [Int]) [] [] == [])
  , ("weaveThree: singletons", weaveThree [1 :: Int] [2] [3] == [1,2,3])
  , ("weaveThree: three rounds", weaveThree [1,2,3 :: Int] [4,5,6] [7,8,9]
      == [1,4,7,2,5,8,3,6,9])
  , ("weaveThree: characters", weaveThree "ab" "cd" "ef" == "acebdf")
  , ("weaveThree: duplicates", weaveThree [1,1 :: Int] [2,2] [1,1]
      == [1,2,1,1,2,1])
  ]

-- | Prints weaving results after weaveThree is implemented.
runWeaveThreeTests :: IO ()
runWeaveThreeTests = mapM_ report weaveThreeTests
  where
    report :: (String, Bool) -> IO ()
    report (label, passed) =
      putStrLn (label ++ if passed then ": PASS" else ": FAIL")

{-
Extra practice: allSplits (10 points)
Modeled on Question 5(b), powerset, in the Spring 2024 midterm.

Implement a function allSplits that, given a list, returns every way to
distribute its elements between two lists. Each input element must appear
in exactly one of the two lists. Preserve the original order within each
list. The outer result list may be in any order.

The two output lists do not have to be contiguous pieces of the input.
The first and second lists are distinct positions in the result tuple:
([1], [2]) and ([2], [1]) are different results.

For example:
  allSplits [1,2]
    = [([1,2], []), ([1], [2]), ([2], [1]), ([], [1,2])]
      (in any order)
  allSplits [7] = [([7], []), ([], [7])]      (in any order)
  allSplits []  = [([], [])]

Choose by input position. If identical values produce duplicate result
pairs, retain those duplicates. No Eq constraint is needed.
The same permitted techniques and style rules apply.

Implement the function below. Run runSplitTests after replacing its stub.
-}

-- | Generates all distributions into two lists, preserving element order.
allSplits :: [a] -> [([a], [a])]
allSplits [] = [([], [])]
allSplits (x: xs) = 
  map (\(left, right) -> (x : left, right)) (allSplits xs) 
  ++ 
  map (\(left, right) -> (left, x : right)) (allSplits xs)

-- | Checks empty input, complete distributions, order, and duplicates.
splitTests :: [(String, Bool)]
splitTests =
  [ ("split: empty", allSplits ([] :: [Int]) == [([], [])])
  , ("split: singleton", sort (allSplits [7 :: Int])
      == sort [([7], []), ([], [7])])
  , ("split: pair", sort (allSplits [1,2 :: Int])
      == sort [([1,2], []), ([1], [2]), ([2], [1]), ([], [1,2])])
  , ("split: three", sort (allSplits [1,2,3 :: Int])
      == sort [([1,2,3], []), ([1,2], [3]), ([1,3], [2]), ([1], [2,3]),
               ([2,3], [1]), ([2], [1,3]), ([3], [1,2]), ([], [1,2,3])])
  , ("split: duplicates", sort (allSplits [1,1 :: Int])
      == sort [([1,1], []), ([1], [1]), ([1], [1]), ([], [1,1])])
  ]

-- | Prints distribution results after allSplits is implemented.
runSplitTests :: IO ()
runSplitTests = mapM_ report splitTests
  where
    report :: (String, Bool) -> IO ()
    report (label, passed) =
      putStrLn (label ++ if passed then ": PASS" else ": FAIL")

-- Workflow:
-- ghci Haskell-Coding-Practice-2026-10-08.hs
-- In GHCi, enter runTests after implementing both functions.
-- Enter runSumTests separately after implementing subsetsWithSum.
-- Enter runInterleavingTests separately after implementing interleavings.
-- Enter runWeaveThreeTests separately after implementing weaveThree.
-- Enter runSplitTests separately after implementing allSplits.
-- ghc -Wall -fno-code Haskell-Coding-Practice-2026-10-08.hs
