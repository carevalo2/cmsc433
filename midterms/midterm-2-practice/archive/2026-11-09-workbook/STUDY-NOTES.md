# Short side reference

The actual questions are in `study-guide.pdf`, with editable answers in the
numbered folders' `lesson.tex`. Use this only when you need an explanation.
These are supplementary teaching examples based on the lecture interfaces;
they are not solutions to workbook questions.

## A type ledger

1. Copy known signatures with fresh variable names.
2. Label each input's type.
3. Match the argument against the function's expected input shape.
4. Apply the resulting substitutions consistently.
5. Restore lambda arguments, the outer context, and all necessary constraints.

Example: `\h x -> h (Just x)`.

```text
x        :: a
Just x   :: Maybe a
h        :: Maybe a -> b
h (Just x) :: b
whole lambda :: (Maybe a -> b) -> a -> b
```

Example: `(:) <$> Just 'm'`.

```text
(:)        :: a -> [a] -> [a]
after 'm'  :: String -> String
outer context: Maybe
whole type :: Maybe (String -> String)
```

The payload can be a function. Don't erase either the `Maybe` or the arrows.
For `State s a`, fix the first parameter `s` while tracing the computation;
`fmap` changes the returned `a`, not the stored type `s`.

## State: two different outputs

```haskell
demo :: State Int Int
demo = do
  old <- get
  put (old + 4)
  return (old * 2)
```

`runState demo 3 == (6,7)`: returned value first, final state second.
`return` builds an action and does not exit a `do` block.

## Generic monadic code

`Maybe` can fail; lists enumerate possibilities; State threads stored values.
The same generic function follows different combination rules in each context.
With lists, finish all later choices for an earlier choice before advancing it.

```haskell
do x <- [2,5 :: Int]
   y <- [1,3]
   return (x-y)
-- [1,-1,4,2]
```

## Verification

For `x := x - 2` and postcondition `x >= 4`, substitute to get `x - 2 >= 4`,
equivalently `x >= 6`. For a sequence, do the last assignment first.
For a loop, distinguish initialization, preservation, and exit. If there is
code after the loop, work backward through it before writing the exit condition.
Deriving an implication does not establish that it is valid. See the sources
and reference sheet for the precise partial-correctness convention used here.

## Laziness

A pair's first component can be demanded without evaluating its second component.
To assess a recursive binding, follow what must be evaluated to produce the
part you need. Circular notation alone establishes neither productivity nor
nontermination. The helper equations in the worksheet are the evidence to use.
