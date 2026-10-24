# Functor and Applicative practice

Start with Exercise 1 in `Practice.hs`. Work through one part at a time;
bring your answers back to the chat for feedback.

From the repository root:

```sh
cd midterms/midterm-2-practice/01-functor-applicative
stack ghci
```

Or load the self-contained file directly:

```sh
ghci Practice.hs
```

Useful GHCi commands:

```haskell
:t (<$>)
:t (<*>)
:t exampleWaiting
exampleEven
exampleApplied
:reload
```

Write your prediction before running an expression. For functions, inspect
the type instead of trying to print the value.

After implementing an exercise, evaluate its corresponding check:
`checkDescribeNumber`, `checkMultiplyMaybe`, or `checkMakeScore`.
Each should evaluate to `True`. These checks cover examples, rather than
proving correctness. They will raise an error while their exercise still
contains `undefined`.

The parser questions are written exercises based on HW3's interfaces;
this project does not import or change your homework.
