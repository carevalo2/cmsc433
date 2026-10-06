# Midterm practice: written questions

The complete exam is split across Written.md, Practice.dfy, and Practice.hs.
Original question numbers and points are preserved: core 100 points,
supplement 60 points. Coding prompts are in their language files.

## Q1. Fold traces and loop explanations (10 points)

Consider `foldr (-) 10` and `foldl (-) 10`, specialized to `[Int]`.
Fully parenthesize both computations on `[6, 2, 1]`, evaluate them, and
explain why they differ (6 points).

For your methods in Practice.dfy, state each loop invariant in terms of
the processed portion of the array. Explain traversal direction and
index safety (4 points).

```text
Right-fold trace: TODO
Left-fold trace: TODO
Why they differ: TODO
RightSubtract invariant and explanation: TODO
LeftSubtract invariant and explanation: TODO
```

## Q2. Most general types (20 points; 2 each)

Give the most general type, including constraints, or write `ill-typed`
and identify the incompatible types. Do not default numbers to `Int`.

```haskell
-- a
\x y -> (y, x)
-- b
\x y -> if x == y then show x else show (x, y)
-- c
\x xs -> x : (xs ++ [x])
-- d
foldr (const 7)
-- e
(, True)
-- f
(,) True
-- g
reverse . reverse
-- h
\xs -> filter (> 5) (xs ++ xs)
-- i
let keep x = x in (keep 'q', keep False)
-- j
fmap (fmap not) [Nothing, Just True]
```

Answers: a ___; b ___; c ___; d ___; e ___;
f ___; g ___; h ___; i ___; j ___.

## Q3. Explanation accompanying expressions from types

The implementation prompts and 20-point allocation are in Practice.hs.
Explain any unavoidable empty result or impossible total implementation.

```text
TODO
```

## Q4. Explanation accompanying the decorated proof

The proof and 20-point allocation are in Practice.dfy.
Explain initialization, preservation, and the exit implication.

```text
Initialization: TODO
Preservation: TODO
Exit implication: TODO
```

## Q5. Explanation accompanying recursive Haskell

The implementation prompts and 20-point allocation are in Practice.hs.
Explain how the recursive result is transformed in chooseOne (Q5b).

```text
TODO
```

## S1. Monadic types and constructions (20 points)

Infer the most general type or identify the type error (2 points each):

```haskell
get >>= put
\xs -> [x | x <- xs, x]
\xs -> [odd x | x <- xs]
modify reverse
put 'z' >> put False
(,) <$> get
```

```text
Types/errors for expressions 1 through 6:
1. TODO
2. TODO
3. TODO
4. TODO
5. TODO
6. TODO
```

## S3. Trace monadic sequencing (15 points)

The supplied `gatherActions` in `Practice.hs` is intentionally provided
code to trace, not a solution to your implementation questions.

Evaluate these (2 points each), retaining unevaluated functions if necessary:

```haskell
gatherActions [[] :: [Int]]
gatherActions [Just 'r']
gatherActions [Just 'r', Nothing]
gatherActions [[1, 2], [7, 8]]
runState (gatherActions [get, get]) (12 :: Int)
runState (gatherActions [get, put 9 >> get]) (4 :: Int)
```

```text
Results for expressions 1 through 6:
1. TODO
2. TODO
3. TODO
4. TODO
5. TODO
6. TODO
Why list branching differs from Maybe failure: TODO
```

## S4. Lazy tuple bindings (10 points)

Trace the provided `scanLargest` on these calls (1 point each):

```haskell
scanLargest [] 8
scanLargest [3] 8
scanLargest [2, 5, 1] 8
scanLargest [2, 5, 1] 0
```

```text
Results for calls 1 through 4:
1. TODO
2. TODO
3. TODO
4. TODO
Optional one-call challenge dependency explanation: TODO
```

## Compact reference sheet


```haskell
foldr :: (a -> b -> b) -> b -> [a] -> b
foldl :: (b -> a -> b) -> b -> [a] -> b
const :: a -> b -> a
(.) :: (b -> c) -> (a -> b) -> a -> c
map :: (a -> b) -> [a] -> [b]
filter :: (a -> Bool) -> [a] -> [a]
fmap :: Functor f => (a -> b) -> f a -> f b
pure :: Applicative f => a -> f a
(<*>) :: Applicative f => f (a -> b) -> f a -> f b
(>>=) :: Monad m => m a -> (a -> m b) -> m b
(>>) :: Monad m => m a -> m b -> m b
mapM :: Monad m => (a -> m b) -> [a] -> m [b]
sequence :: Monad m => [m a] -> m [a]
get :: State s s
put :: s -> State s ()
modify :: (s -> s) -> State s ()
runState :: State s a -> s -> (a, s)
```

Model: `newtype State s a = S {runState :: s -> (a, s)}`.
The runnable file uses the library's equivalent `State` representation.

Hoare assignment: `{Q[x := e]} x := e {Q}`.
Loop: `{I && guard} body {I}` gives
`{I} while guard {body} {I && !guard}` (partial correctness).
Consequence permits strengthening a precondition or weakening a
postcondition when the required implications hold.
