# Haskell Beginner Guide

Purpose: a compact, practical introduction for programmers (OCaml background welcome).

---

## 1 — Install and run

Recommended: ghcup (manages GHC and tools).

macOS:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
# follow prompts, then:
source ~/.ghcup/env
ghc --version
ghci --version
```

Alternative: Homebrew `brew install ghc cabal-install`.

Start interactive REPL (GHCI):

```bash
ghci                 # empty REPL
ghci file.hs         # load a file
:c file.hs            # inside ghci to load
:r                   # reload after edits
:q                   # quit
```

Common GHCI commands: `:t expr`, `:i Name`, `:k Type`, `:browse`, `:set +s` (timing).

---

## 2 — Basic syntax and expressions

- Type annotation: `name :: Type`
- Definition: `name = expr`
- Functions: `f :: Int -> Int -> Int; f x y = x + y`
  - Arrow is right-associative: `Int -> Int -> Int` ≡ `Int -> (Int -> Int)`
- Lambda: `\x -> x + 1` (escaped backslash)
- Let / where:
  - `let a = 1 in a + 2`
  - `f x = 2 * y where y = x + 1`
- Comments: `-- single` and `{- multi -}`

Example:

```haskell
add :: Int -> Int -> Int
add x y = x + y
-- equivalent: add = \x -> \y -> x + y
```

Partial application:

```haskell
inc = add 1   -- inc :: Int -> Int
inc 5         -- 6
```

---

## 3 — Types, inference and annotations

Haskell infers types, but you can annotate.

- Polymorphic identity: `id :: a -> a; id x = x`
- Type variables are lowercase (`a`, `b`).
- Kinds: `Int` has kind `Type`; constructors like `Maybe` have kind `Type -> Type`.

Use `:t` in GHCI to inspect types.

---

## 4 — Algebraic data types & pattern matching

Define ADT:

```haskell
data Tree a = Empty | Node a (Tree a) (Tree a)
```

Pattern match:

```haskell
inorder Empty = []
inorder (Node x l r) = inorder l ++ [x] ++ inorder r
```

Deriving utilities:

```haskell
data Day = Sun | Mon deriving (Eq, Ord, Show, Enum, Bounded)
```

---

## 5 — Lists, tuples, comprehensions

- Lists: `[1,2,3]`, cons `x:xs`, empty `[]`.
- Range: `[1..10]` (requires `Enum`).
- Comprehension: `[x*2 | x <- [1..5], x `mod` 2 == 0]`.
- Tuples: `(1, 'a')` — fixed size heterogeneous containers.

---

## 6 — Recursion and higher-order functions

Recursion is the main looping mechanism.
Use `map`, `filter`, `foldr`, `foldl` for common patterns.

```haskell
sumList :: [Int] -> Int
sumList [] = 0
sumList (x:xs) = x + sumList xs

mapWithFoldr f = foldr (\x acc -> f x : acc) []
```

---

## 7 — Currying, sections, and closures

Functions are curried: `f a b` is `((f a) b)`.
Sections: `(1+)` or `(+1)` are shorthand for partial application.
Lambdas create closures that capture variables.

---

## 8 — Type classes (ad-hoc polymorphism)

Common classes: `Eq`, `Ord`, `Show`, `Read`, `Functor`, `Monad`, `Num`.
Example: `class Eq a where (==) :: a -> a -> Bool`.
Derive instances automatically: `deriving (Eq, Show)`.

Functor example:

```haskell
instance Functor Maybe where
  fmap f (Just x) = Just (f x)
  fmap _ Nothing  = Nothing
```

---

## 9 — Purity, laziness, and IO

- Functions are pure (no side effects) unless using a monad such as `IO`.
- Laziness: expressions evaluate only when needed (infinite lists allowed).
- IO uses `do` notation:

```haskell
main :: IO ()
main = do
  putStrLn "Name?"
  name <- getLine
  putStrLn $ "Hello " ++ name
```

`do` desugars to uses of `(>>=)` (bind) and `return`.

---

## 10 — Debugging and workflow

- Use `:set +s` to see time/memory.
- Use `trace` from `Debug.Trace` sparingly for quick prints.
- For projects, use `cabal repl` or `stack ghci` to load dependencies.

---

## 11 — Practice exercises (next steps)

- Complete `haskell/haskell-exercises.hs` (sumList done). Implement `safeHead`, `treeHeight`, `treeMap`, `mapWithFoldr`, `maybeCompose`, `Functor Two`, simple `Parser` helper and `evalSumExpr`.
- Try writing `fibs = 0 : 1 : zipWith (+) fibs (tail fibs)` and `take 10 fibs` in GHCI.

---

## 12 — Suggested learning path

1. Play in GHCI: inspect types `:t`, info `:i`, load/reload.
2. Implement exercises in `haskell/haskell-exercises.hs` and run in GHCI.
3. Read about `Monads` once comfortable with functions and Functor/Applicative.
4. Explore `Real World Haskell` or `Learn You a Haskell for Great Good`.

---

If you want, I can: implement the remaining exercises, add step-by-step GHCI transcripts, or walk through any section interactively. Tell me which one to do next.
