{-
HASKELL BASICS -- A HANDS-ON GUIDE
===================================

This file is both a tutorial and a valid Haskell program. Read it from top to
bottom, experiment with it in GHCi, and then try the exercises at the end.

From the haskell-intro-hw directory, start GHCi with:

    stack ghci haskell-basics.hs

At the GHCi prompt, try:

    main
    double 6
    :type double
    :type map
    :info Maybe
    :reload
    :quit

After changing this file, use :reload to load your changes.
-}

module Main where

--------------------------------------------------------------------------------
-- 1. VALUES, TYPES, AND FUNCTIONS
--------------------------------------------------------------------------------

-- Haskell infers types, but writing a type signature is good documentation.
-- Read "::" as "has type" and "->" as "takes ... and returns ...".
answer :: Int
answer = 42

courseName :: String
courseName = "CMSC 433"

isFun :: Bool
isFun = True

-- A function definition resembles a mathematical equation.
double :: Int -> Int
double x = x * 2

-- Function application uses spaces--usually no parentheses or commas.
-- This means add 3 4, not add(3, 4).
add :: Int -> Int -> Int
add x y = x + y

-- Technically, add takes one argument and returns another function. This is
-- called currying, and it makes partial application possible.
addTen :: Int -> Int
addTen = add 10

-- Common types:
--   Int       fixed-size whole numbers
--   Integer   whole numbers of arbitrary size
--   Double    floating-point numbers
--   Bool      True or False
--   Char      one character, such as 'a'
--   String    a list of characters; String is the same as [Char]

--------------------------------------------------------------------------------
-- 2. EXPRESSIONS, IF, LET, AND WHERE
--------------------------------------------------------------------------------

-- Haskell is expression-oriented: an if produces a value. It must have both
-- then and else branches, and those branches must have the same type.
absoluteValue :: Int -> Int
absoluteValue x = if x < 0 then -x else x

-- Guards are often clearer than nested if expressions.
describeNumber :: Int -> String
describeNumber x
  | x < 0     = "negative"
  | x == 0    = "zero"
  | otherwise = "positive"

-- let introduces local names inside an expression.
hypotenuse :: Double -> Double -> Double
hypotenuse a b =
  let squaredA = a * a
      squaredB = b * b
  in sqrt (squaredA + squaredB)

-- where introduces names after the expression that uses them.
circleArea :: Double -> Double
circleArea radius = pi * radiusSquared
  where
    radiusSquared = radius * radius

-- Indentation is syntax in Haskell. Keep related definitions aligned.

--------------------------------------------------------------------------------
-- 3. IMMUTABILITY AND RECURSION
--------------------------------------------------------------------------------

-- Names do not represent mutable boxes. Once a name is defined, you do not
-- assign a new value to it. Repetition is commonly expressed with recursion
-- or higher-order functions such as map and foldr.

factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n - 1)

-- The two equations above use pattern matching. The first matching equation
-- is chosen, so factorial 0 reaches the base case.

--------------------------------------------------------------------------------
-- 4. LISTS AND PATTERN MATCHING
--------------------------------------------------------------------------------

numbers :: [Int]
numbers = [10, 20, 30]

-- Every element of a list has the same type.
-- [] is the empty list. The : operator adds one item to the front.
moreNumbers :: [Int]
moreNumbers = 5 : numbers             -- [5,10,20,30]

-- Pattern matching safely separates an empty list from a nonempty list.
listDescription :: [a] -> String
listDescription []      = "empty"
listDescription [_]     = "one element"
listDescription (_ : _) = "two or more elements"

-- x : xs means "the first element x, followed by the remaining list xs".
myLength :: [a] -> Int
myLength []       = 0
myLength (_ : xs) = 1 + myLength xs

sumList :: [Int] -> Int
sumList []       = 0
sumList (x : xs) = x + sumList xs

-- Useful standard list functions include:
--   head [1,2]       == 1       (but head [] crashes)
--   tail [1,2]       == [2]     (but tail [] crashes)
--   take 2 [1,2,3]   == [1,2]
--   drop 2 [1,2,3]   == [3]
--   [1,2] ++ [3,4]   == [1,2,3,4]
-- Prefer pattern matching over head and tail when writing recursive code.

--------------------------------------------------------------------------------
-- 5. TUPLES, MAYBE, AND CUSTOM DATA TYPES
--------------------------------------------------------------------------------

-- A tuple has a fixed size and may mix types.
student :: (String, Int)
student = ("Ada", 95)

studentMessage :: (String, Int) -> String
studentMessage (name, score) = name ++ " scored " ++ show score

-- Maybe represents a value that might not exist. It is safer than using a
-- magic value such as -1 or allowing a function to crash.
safeHead :: [a] -> Maybe a
safeHead []      = Nothing
safeHead (x : _) = Just x

showPossibleNumber :: Maybe Int -> String
showPossibleNumber Nothing  = "There was no number"
showPossibleNumber (Just x) = "The number was " ++ show x

-- You can define your own algebraic data types with data.
data TrafficLight = Red | Yellow | Green
  deriving (Show, Eq)

lightAction :: TrafficLight -> String
lightAction Red    = "stop"
lightAction Yellow = "slow down"
lightAction Green  = "go"

--------------------------------------------------------------------------------
-- 6. HIGHER-ORDER FUNCTIONS AND LAMBDAS
--------------------------------------------------------------------------------

-- Functions are values: they can be passed to and returned from functions.
doubledNumbers :: [Int]
doubledNumbers = map double [1, 2, 3]           -- [2,4,6]

onlyEvenNumbers :: [Int]
onlyEvenNumbers = filter even [1, 2, 3, 4]      -- [2,4]

-- A lambda is an anonymous function. Read \x -> x * x as "given x, return
-- x * x".
squares :: [Int]
squares = map (\x -> x * x) [1, 2, 3]          -- [1,4,9]

-- Function composition (.) connects output from the right-hand function to
-- input of the left-hand function: (f . g) x == f (g x).
shout :: String -> String
shout = (++ "!") . (++ "Hello, ")

-- $ means low-precedence function application. These are equivalent:
--   sqrt (3 * 3 + 4 * 4)
--   sqrt $ 3 * 3 + 4 * 4

--------------------------------------------------------------------------------
-- 7. FOLDS AND LIST COMPREHENSIONS
--------------------------------------------------------------------------------

-- foldr replaces (:) with a combining function and [] with a starting value.
-- For [1,2,3], this becomes 1 + (2 + (3 + 0)).
sumWithFold :: [Int] -> Int
sumWithFold = foldr (+) 0

-- A list comprehension describes how to produce and filter values.
evenSquares :: [Int]
evenSquares = [x * x | x <- [1 .. 10], even x]

-- Haskell is lazy: values are computed only when needed. This permits
-- infinite lists, provided you consume only a finite part.
firstFiveEvenNumbers :: [Int]
firstFiveEvenNumbers = take 5 [0, 2 ..]         -- [0,2,4,6,8]

--------------------------------------------------------------------------------
-- 8. IO: INTERACTING WITH THE OUTSIDE WORLD
--------------------------------------------------------------------------------

-- Most functions above are pure: the same inputs always produce the same
-- outputs and have no side effects. IO actions are described using IO types.
-- "IO ()" is an action that eventually produces no meaningful result.
main :: IO ()
main = do
  putStrLn "Welcome to the Haskell basics guide!"
  putStrLn (studentMessage student)
  putStrLn ("double 6 = " ++ show (double 6))
  putStrLn ("even squares = " ++ show evenSquares)
  putStrLn "Load this file in GHCi and try the exercises at the bottom."

-- In a do block, <- extracts the result produced by an IO action. It is not
-- ordinary assignment. This function is not called by main, but try it in
-- GHCi by entering: greet
greet :: IO ()
greet = do
  putStrLn "What is your name?"
  name <- getLine
  putStrLn ("Hello, " ++ name ++ "!")

--------------------------------------------------------------------------------
-- 9. OPERATORS, PRECEDENCE, AND COMMON SURPRISES
--------------------------------------------------------------------------------

--   =    defines a name; it is not assignment
--   ==   tests equality
--   /=   tests inequality
--   &&   Boolean AND
--   ||   Boolean OR
--   not  Boolean negation
--   :    puts one item at the front of a list
--   ++   concatenates two lists
--   !!   indexes a list (partial and usually best avoided)
--   `f`  uses a two-argument function as an infix operator
--
-- Parentheses group expressions; they do not create argument lists.
-- Function application binds more tightly than operators:
--   double 3 + 1       means (double 3) + 1
--   double (3 + 1)     means double 4
--
-- Negative literals sometimes need parentheses:
--   double (-3)
--
-- Type variables such as a and b mean a function is polymorphic:
--   id :: a -> a
-- It works for every type, but must return the same type it receives.

--------------------------------------------------------------------------------
-- 10. READING TYPE SIGNATURES
--------------------------------------------------------------------------------

--   not    :: Bool -> Bool
--     takes a Bool and returns a Bool
--
--   length :: [a] -> Int
--     takes a list of any element type and returns an Int
--
--   map    :: (a -> b) -> [a] -> [b]
--     takes a function from a to b, then a list of a values, and returns a
--     list of b values
--
--   (,)    :: a -> b -> (a, b)
--     takes two values and makes a pair
--
-- The parentheses in (a -> b) matter: map's first argument is itself a
-- function.

--------------------------------------------------------------------------------
-- 11. ERRORS AND DEBUGGING HABITS
--------------------------------------------------------------------------------

-- Compile errors often look intimidating. Start at the FIRST error and ask:
--   1. What type did GHC expect?
--   2. What type did it actually find?
--   3. Is indentation changing how the code is grouped?
--   4. Did I forget a base case or a pattern?
--
-- Helpful GHCi commands:
--   :type expression       display its inferred type
--   :info name             show information about a name or type
--   :load file.hs          load a file
--   :reload                reload after edits
--   :set +t                show types after evaluating expressions
--
-- Warnings about incomplete patterns mean some possible input can crash your
-- function. For example, a definition only for (x : xs) forgets the [] case.

--------------------------------------------------------------------------------
-- 12. PRACTICE EXERCISES
--------------------------------------------------------------------------------

{-
Solve these in order. Add your definitions below this comment and test each in
GHCi. Example tests are supplied, but invent edge cases of your own too.

Do not uncomment every type signature at once unless you also provide every
definition: a signature without a definition is an error.

1. Define triple, which multiplies an Int by 3.

   -- triple :: Int -> Int
   -- triple x = ...
   -- Tests: triple 4 == 12; triple (-2) == -6

2. Define isLong, which is True when a String has more than five characters.

   -- isLong :: String -> Bool
   -- Tests: isLong "Haskell" == True; isLong "hi" == False

3. Define gradeLetter with guards. Use A for scores >= 90, B for >= 80,
   C for >= 70, D for >= 60, and F otherwise.

   -- gradeLetter :: Int -> Char

4. Define productList recursively using [] and (x : xs). The product of an
   empty list should be 1. Why is 1 the useful base value?

   -- productList :: [Int] -> Int
   -- Tests: productList [2,3,4] == 24; productList [] == 1

5. Define contains recursively. It should report whether a value occurs in a
   list. The Eq a constraint means values of type a can be compared with ==.

   -- contains :: Eq a => a -> [a] -> Bool
   -- Tests: contains 3 [1,2,3] == True; contains 'x' "cat" == False

6. Define lastMaybe using pattern matching. Return Nothing for an empty list
   and Just the final value otherwise. Do not use last.

   -- lastMaybe :: [a] -> Maybe a

7. Define keepPositive using filter.

   -- keepPositive :: [Int] -> [Int]
   -- Test: keepPositive [-2,0,3,5] == [3,5]

8. Define addOneToAll twice: once using recursion and once using map.

   -- addOneToAllRecursive :: [Int] -> [Int]
   -- addOneToAllMap :: [Int] -> [Int]

9. Define count using foldr. It should count how many elements satisfy a
   predicate.

   -- count :: (a -> Bool) -> [a] -> Int
   -- Test: count even [1,2,3,4,6] == 3

10. Define safeDivide. Division by zero should produce Nothing; otherwise it
    should produce Just the quotient.

    -- safeDivide :: Double -> Double -> Maybe Double

11. Define a Shape type with Circle and Rectangle constructors, then define
    area :: Shape -> Double using pattern matching.

12. Challenge: define myMap recursively without using map.

    -- myMap :: (a -> b) -> [a] -> [b]

13. Challenge: define flatten, which converts a list of lists into one list,
    recursively using only [] and (:). This resembles one homework skill, so
    work it out yourself rather than searching for the library implementation.

    -- flatten :: [[a]] -> [a]
    -- Test: flatten [[1,2], [], [3,4]] == [1,2,3,4]

Suggested workflow for every exercise:
  1. Write the type signature.
  2. Write examples before the implementation.
  3. Identify the patterns or base case.
  4. Implement the smallest case first.
  5. Reload and test normal cases plus empty, zero, or negative inputs.
-}
