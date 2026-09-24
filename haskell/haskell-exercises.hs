-- Haskell exercises (haskell/haskell-exercises.hs)
-- Implement the functions marked TODO. Hints are provided before each exercise.

module HaskellExercises where

{- Basic Haskell syntax (quick reference for OCaml users)

    - Definitions: `name :: Type` for annotations, `name = expr` for values.
        Example: `x :: Int; x = 3`

    - Functions use `->` for types and are curried by default:
        `add :: Int -> Int -> Int; add x y = x + y`

    - Lambdas: `\x -> x + 1` (escaped backslash).

    - Pattern matching on lists/ADTs:
        `case xs of [] -> ...; (y:ys) -> ...` or top-level equations

    - Let/where expressions:
        `let a = 1 in a + 2`  and  `f x = y where y = x * 2`

    - Lists: `[1,2,3]`, ranges `[1..5]`, cons `x:xs`.

    - Comments: `-- single line` and `{- block -}`.

    Small examples:
        > :t (+)        -- (+) :: Num a => a -> a -> a
        > map (+1) [1,2] -- [2,3]
        > let y = \x -> x * 2 in y 3 -- 6

    Use `:t`, `:i`, `:reload` in GHCi to explore.

-}

-- To test, run in ghci:
-- :load haskell/haskell-exercises.hs
-- :reload after edits

-- 1) Easy — Basic functions and types
-- Goal: practice type annotations, pattern matching and recursion.
-- Hint: This is like OCaml `let rec sum lst = match lst with [] -> 0 | x::xs -> x + sum xs`.
sumList :: [Int] -> Int
sumList []     = 0
sumList (x:xs) = x + sumList xs

-- 2) Easy — Option (Maybe) handling
-- Goal: implement safeHead which returns the first element or Nothing.
-- Hint: pattern match on the list constructors.
safeHead :: [a] -> Maybe a
safeHead = undefined

-- 3) Medium — Binary tree and map
-- Goal: implement treeHeight and treeMap for the provided Tree type.
-- Hints:
--  - Height of Empty is 0; of Node is 1 + max (height left) (height right).
--  - treeMap applies a function to every element, preserving structure.

data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Eq, Show)

treeHeight :: Tree a -> Int
treeHeight = undefined

treeMap :: (a -> b) -> Tree a -> Tree b
treeMap = undefined

-- 4) Medium — Folding over lists
-- Goal: implement map using foldr (no explicit recursion).
-- Hint: map f = foldr (\x acc -> f x : acc) []
mapWithFoldr :: (a -> b) -> [a] -> [b]
mapWithFoldr = undefined

-- 5) Medium-Hard — Implement Maybe-based composition
-- Goal: compose two functions that may fail, i.e., (a -> Maybe b) and (b -> Maybe c)
-- Given f and g, return a function that applies f, then g on the result if present.
-- Hint: use case analysis or monadic `>>=` for Maybe.
maybeCompose :: (a -> Maybe b) -> (b -> Maybe c) -> a -> Maybe c
maybeCompose = undefined

-- 6) Hard — Functor instance for a custom datatype
-- Goal: make Two a Functor (Two a = MkTwo a a).
-- Hint: fmap f (MkTwo x y) = MkTwo (f x) (f y)

data Two a = MkTwo a a deriving (Eq, Show)

instance Functor Two where
    fmap = undefined

-- 7) Hard — Implement a simple parser combinator
-- Goal: a tiny Parser type `newtype Parser a = Parser { runParser :: String -> Maybe (a, String) }`
-- Implement `satisfy :: (Char -> Bool) -> Parser Char` that consumes one char if it satisfies the predicate.
-- Hint: Inspect the input string: if empty, fail; otherwise check the head.

newtype Parser a = Parser { runParser :: String -> Maybe (a, String) }

satisfy :: (Char -> Bool) -> Parser Char
satisfy = undefined

-- Helper to run and show parser results (optional)
parseTest :: Parser a -> String -> Maybe (a, String)
parseTest p s = runParser p s

-- 8) Stretch — Implement a small expression evaluator
-- Goal: parse and evaluate tiny expressions consisting of integers and `+` (no spaces), e.g., "1+2+3" -> 6
-- Hint: split by '+' (or recursively parse digits and plus signs). Use `reads` or `span`.

evalSumExpr :: String -> Maybe Int
evalSumExpr = undefined

-- End of exercises
