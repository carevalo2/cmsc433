import Distribution.Simple.Program.HcPkg (list)
{-
HASKELL EXERCISES -- PART 2
===========================

Complete the exercises in order. This set mixes function implementation,
reading type signatures, and writing functions that match a given type.

Do not change the supplied type signatures. Replace each `undefined` with your
implementation. For type-prediction questions, write your answer in the space
provided as a comment, then check it in GHCi with :t.

From the haskell-intro-hw directory, load this file with:

    stack ghci haskell-exercises-part-2.hs

After editing the file, reload it in GHCi with:

    :reload
-}

--------------------------------------------------------------------------------
-- 1. IMPLEMENT A FUNCTION
--------------------------------------------------------------------------------

-- Return True when an Int is negative.
--
-- Examples:
--   isNegative (-4) == True
--   isNegative 0    == False
--   isNegative 7    == False

isNegative :: Int -> Bool
isNegative x 
    | x >= 0 = False 
    | otherwise = True

--------------------------------------------------------------------------------
-- 2. WHAT IS THIS FUNCTION'S TYPE?
--------------------------------------------------------------------------------

-- Predict the most general type of firstOr before asking GHCi.
-- Replace the question marks in the comment with your prediction.
--
-- firstOr :: a -> [a] -> a

firstOr defaultValue []      = defaultValue
firstOr _            (x : _) = x

--------------------------------------------------------------------------------
-- 3. MAKE A FUNCTION WITH THIS TYPE
--------------------------------------------------------------------------------

-- Write any sensible function matching this type.
-- It must use both arguments.
--
-- Example of the shape of a call:
--   combineText "cat" "dog"

combineText :: String -> String -> String
combineText a b = a ++ b

--------------------------------------------------------------------------------
-- 4. PATTERN MATCHING AND MAYBE
--------------------------------------------------------------------------------

-- Return Just the second element of a list. Return Nothing if the list has
-- fewer than two elements. Do not use head, tail, or (!!).
--
-- Examples:
--   secondMaybe []        == Nothing
--   secondMaybe [10]      == Nothing
--   secondMaybe [10,20,30] == Just 20

secondMaybe :: [a] -> Maybe a
secondMaybe [] = Nothing
secondMaybe [a] = Nothing 
secondMaybe (_: x : _) = Just x

--------------------------------------------------------------------------------
-- 5. WHAT IS THIS FUNCTION'S TYPE?
--------------------------------------------------------------------------------

-- Predict the most general type of applyTwice.
--
-- applyTwice :: (a -> a) -> a -> a

applyTwice f x = f (f x)

--------------------------------------------------------------------------------
-- 6. RECURSION OVER A LIST
--------------------------------------------------------------------------------

-- Multiply every Int in a list by two using recursion. Do not use map.
-- Remember to handle the empty list.
--
-- Examples:
--   doubleAll []      == []
--   doubleAll [1,2,3] == [2,4,6]

doubleAll :: [Int] -> [Int]
doubleAll x = foldr (\x listSoFar -> x * 2 : listSoFar) [] x

--------------------------------------------------------------------------------
-- 7. FILTER WITH A SUPPLIED PREDICATE
--------------------------------------------------------------------------------

-- Keep the elements that do NOT satisfy the supplied predicate. Use filter.
--
-- Examples:
--   reject even [1,2,3,4] == [1,3]
--   reject (> 3) [1,5,2,7] == [1,2]

reject :: (a -> Bool) -> [a] -> [a]
reject p l = filter (\x -> not (p x)) l

--------------------------------------------------------------------------------
-- 8. READ THIS TYPE SIGNATURE
--------------------------------------------------------------------------------

-- In your own words, explain what each part of this signature means:
--
--   findFirst :: (a -> Bool) -> [a] -> Maybe a
--
-- Your explanation: findFirst is a function that takes in a function which takes a value of type a and returns true or false. 
-- the second parameter of findfirst is a list of elements of type a and findFirst returns a Maybe a.
--
--
-- Then implement it recursively. Return the first element satisfying the
-- predicate, or Nothing if no element does.

findFirst :: (a -> Bool) -> [a] -> Maybe a
findFirst _ [] = Nothing
findFirst f (x : xs) =
    if f x then Just x
    else findFirst f xs 

--------------------------------------------------------------------------------
-- 9. FOLDR
--------------------------------------------------------------------------------

-- Use foldr to calculate the sum of only the positive Ints in a list.
--
-- Examples:
--   sumPositive []           == 0
--   sumPositive [-2,3,0,5]   == 8
--   sumPositive [-4,-1]      == 0

sumPositive :: [Int] -> Int
sumPositive l = foldr (\x sumSoFar -> if x > 0 then sumSoFar + x else sumSoFar) 0 l

--------------------------------------------------------------------------------
-- 10. DEFINE A DATA TYPE AND PATTERN-MATCH ON IT
--------------------------------------------------------------------------------

-- This type represents a basic temperature reading.

data Temperature
  = Celsius Double
  | Fahrenheit Double
  deriving (Show, Eq)

-- Convert either kind of reading into Celsius.
-- Fahrenheit to Celsius: (degrees - 32) * 5 / 9
--
-- Examples:
--   toCelsius (Celsius 20)     == 20
--   toCelsius (Fahrenheit 32)  == 0

toCelsius :: Temperature -> Double
toCelsius = undefined

--------------------------------------------------------------------------------
-- 11. WHAT IS THIS FUNCTION'S TYPE?
--------------------------------------------------------------------------------

-- Predict the most general type of pairWith before using :t.
--
-- pairWith :: ???

pairWith x ys = map (\y -> (x, y)) ys

--------------------------------------------------------------------------------
-- 12. CHALLENGE: NESTED LISTS
--------------------------------------------------------------------------------

-- Count the total number of elements across all inner lists. Use recursion;
-- do not use concat or flatten.
--
-- Examples:
--   totalElements []               == 0
--   totalElements [[], []]         == 0
--   totalElements [[1,2],[],[3]]   == 3

totalElements :: [[a]] -> Int
totalElements = undefined

--------------------------------------------------------------------------------
-- SUGGESTED TESTING
--------------------------------------------------------------------------------

-- In GHCi, use :t to inspect types and call each completed function with:
--   * a normal input
--   * an empty list when applicable
--   * a boundary case such as 0, one element, or Nothing
--
-- You can also test equalities, for example:
--
--   doubleAll [1,2,3] == [2,4,6]
--
