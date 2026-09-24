-- Haskell practice notes for OCaml users
-- File: haskell-practice.hs

{- Quick map:
   OCaml            Haskell
   let x = 3        x = 3
   fun f x -> ...   \x -> ...   (lambda)
   match e with ... case e of ...
   type t = A | B   data T = A | B
   List.map f lst   map f lst
-}

-- 1. Types and annotations
-- Haskell uses `::` for type annotations. Types are inferred by default.
add :: Int -> Int -> Int
add x y = x + y

-- Polymorphic function (like OCaml):
id :: a -> a
id x = x

-- Currying: every multi-arg function is curried by default
addThree :: Int -> Int -> Int -> Int
addThree x y z = x + y + z
-- partial application: `addThree 1 2` is `\z -> 3 + z`

-- 2. Let / where and expressions
squareLet = let x = 5 in x * x
squareWhere = sq
  where sq = 5 * 5

-- 3. Algebraic Data Types and pattern matching
-- Like OCaml `type tree = Empty | Node of 'a * tree * tree`:
data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Eq, Show)

-- pattern matching function (inorder traversal)
inorder :: Tree a -> [a]
inorder Empty = []
inorder (Node x l r) = inorder l ++ [x] ++ inorder r

-- 4. Lists and tuples (syntax differs slightly)
firstTwo :: [a] -> Maybe (a,a)
firstTwo (x:y:_) = Just (x,y)
firstTwo _       = Nothing

-- list comprehensions (similar idea to OCaml's list comprehensions in Batteries)
squares :: [Int]
squares = [ x*x | x <- [1..10] ]

-- infinite lists + laziness
nats :: [Integer]
nats = [0..]
firstTen = take 10 nats

-- 5. Higher-order functions and common helpers
-- map, filter, foldr, foldl exist in Prelude
sumList :: [Int] -> Int
sumList = foldr (+) 0

-- lambda, composition, sections
incrementAll :: [Int] -> [Int]
incrementAll = map (\x -> x + 1)

applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

-- function composition (.) and ($) for application
composeExample = (map (*2) . filter (>3)) [1..10]

-- 6. Type classes (OCaml typeclasses? typeclasses ≈ ad-hoc polymorphism)
-- `Eq`, `Ord`, `Show`, `Read`, `Functor`, etc.
-- Example: deriving instances above for Tree.

-- Functor example for a Two-like type
data Two a = Two a a deriving (Eq, Show)
instance Functor Two where
  fmap f (Two x y) = Two (f x) (f y)

-- 7. Purity and laziness
-- Haskell is pure: functions have no side effects unless in a monad (e.g., IO).
-- Laziness means values compute when needed. Beware space leaks but enjoy
-- elegant infinite-structure code.

-- 8. IO and do-notation (roughly analogous to imperative sections)
main :: IO ()
main = do
  putStrLn "Haskell practice running. What's your name?"
  name <- getLine
  putStrLn $ "Hello, " ++ name ++ "!"
  putStrLn $ "First ten naturals: " ++ show firstTen

-- 9. Useful GHCi commands (run in terminal: `ghci haskell-practice.hs`)
-- :t <expr>     -- show type
-- :i <name>     -- show info about a type/class/constructor
-- :k <type>     -- show kind
-- :reload       -- reload file after edits
-- :l file.hs    -- load a file

-- 10. Quick exercises
-- 1) Implement `treeHeight :: Tree a -> Int`.
-- 2) Write `mapMaybe :: (a -> Maybe b) -> [a] -> [b]` using `foldr`.
-- 3) Compare strict sum with lazy sum: try `foldl` vs `foldl'` from Data.List.

-- End of primer
