# CMSC433 Midterm 2 practice

**Open [study-guide.pdf](study-guide.pdf) for the actual problems.**
The editable master is [study-guide.tex](study-guide.tex). Each numbered folder
contains its questions and answer areas in `lesson.tex`.

## Answer everything in LaTeX

- Written answers: replace the text inside `\answer{...}` in a folder's `lesson.tex`.
- Coding answers: replace `undefined` inside that question's `codeanswer` block
  with your Haskell function. You do not have to edit `.hs` files.
- Rebuild from this directory with `powershell -ExecutionPolicy Bypass -File .\build.ps1`.
  It compiles your source and **does not replace your answers**.
- Reopen or refresh `study-guide.pdf` after rebuilding. A `.tex` file is source;
  the `.pdf` is its compiled reading copy. The PDF has no interactive form fields.

The portable compiler and downloaded support files are already available locally
under `.tools/` (excluded from Git). The build uses cached resources. If moving
this folder elsewhere without `.tools`, use an installed Tectonic or pdfLaTeX,
which the same build script detects. With pdfLaTeX it runs twice for references.

## Difficulty: decreasing order

Estimated for your reported trouble with types, not instructor difficulty or
exam weighting:

1. Higher-order/contextual **types**, particularly function-valued State actions,
   partial application, unification, and type-class constraints.
2. **Lazy recursive bindings** and the sample's summary/list helper pattern.
3. **Verification conditions**, especially backward substitution and post-loop code.
4. **Code from polymorphic signatures**, including generic traversal/collection
   and explaining when no total implementation is available.
5. **State execution**, separating returned values from stored state.
6. **Monadic tracing**, including list choice order, Maybe failure, and mapM rewrites.
7. **Functor/Applicative**, preserving context and tracking function payloads.
8. Basic type grammar: arrows, pairs, lists, constructors, and constraints.

## Progressive folder order

Study from prerequisites upward; do not start with the hardest question.

| Folder | Actual problem styles | Sample connection |
| --- | --- | --- |
| [01-type-foundations](practice/01-type-foundations/lesson.tex) | Type derivations, constraints, errors, simple implementation | Q1 prerequisite |
| [02-context-types](practice/02-context-types/lesson.tex) | Functor/Applicative/bind and State types | Q1 |
| [03-type-to-code](practice/03-type-to-code/lesson.tex) | Implement collect, traversal, composition, flattening, lifting | Q2; Q4(b) |
| [04-monads](practice/04-monads/lesson.tex) | Evaluate generic programs under Maybe/lists; implement monadic functions | Q4 |
| [05-state](practice/05-state/lesson.tex) | State traces, pair/list/function state, implement actions | Q1/Q2/Q4 |
| [06-verification](practice/06-verification/lesson.tex) | Weakest preconditions and induced loop obligations | Q3 |
| [07-laziness](practice/07-laziness/lesson.tex) | Trace helpers; implement two-pass and one-call reconstruction | Q5 |
| [08-mixed-review](practice/08-mixed-review/lesson.tex) | Five fresh sample-style questions with less scaffolding | Q1-Q5 |
| [09-lecture-extensions](practice/09-lecture-extensions/lesson.tex) | Transformers, arrays/DP, GADTs, Agda | Not explicitly tested in sample |

Types recur throughout. Attempt one part at a time and write your reasoning
before checking it. Discuss it in chat for feedback; no answer key is included.
For an explanation, use [STUDY-NOTES.md](STUDY-NOTES.md) as a side reference.

## Optional Haskell checks

Each coding folder has a `Practice.hs` companion. You can copy your code answers
there to run examples, but this is optional. From this directory:

```powershell
& C:\ghcup\bin\ghci.exe -isupport practice/01-type-foundations/Practice.hs
```

In GHCi, use `:reload`, `:t expression`, or `checks`. Checks report each unfinished
exercise separately. These finite examples are feedback, not proofs or official
grading tests. Function values must be applied before comparing/printing outputs.
For general type inference in GHCi, use `:set -fno-monomorphism-restriction` and
`:set -XNoExtendedDefaultRules`; preserve constraints when writing your answer.
The provided State implementation uses `(result, finalState)`, as in the sample.
The optional Cabal file builds only the shared support library. Load each
`Practice.hs` directly for exercises; no external Haskell packages are required.

## Scope and preservation

This workbook models the Spring 2025 sample and local lectures. No current
Fall 2026 coverage announcement was available. The sample's five 20-point
questions do not establish this year's format, timing, allowed resources, or
weights. Extensions in 09 have unconfirmed coverage. See [SOURCES.md](SOURCES.md)
for verified sections/pages and apparent source typos.

The source sample remains in `data/`. Earlier completed Functor/Applicative
work was preserved verbatim in
`archive/2026-11-09-original-practice/01-functor-applicative/`.
No homework or lecture files were changed. See [VALIDATION.md](VALIDATION.md)
for what was actually compiled and checked.
