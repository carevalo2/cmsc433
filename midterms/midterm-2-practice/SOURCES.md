# Sources for the topic sequence

The verified reference is `data/Midterm 2 Example - 2025.pdf`, titled CMSC 433:
Midterm Exam 2 (Spring 2025). Its five physical pages contain Q1-Q5, respectively.
Each original question is worth 20 points. That does not establish Fall 2026
format, weighting, resources, or timing. No current announcement was available.

| Part | Verified sample style | Lecture method |
| --- | --- | --- |
| 01 | Q1, p.1: most general types / ill-typed; comprehensions | `lectures/midterm-2/07-monads/Monads.hs` and `GenericMonads.hs`: operation signatures and polymorphism |
| 02 | Q1, p.1: State operations and function-valued results | `07-monads/Monads.hs`: Functor/Applicative; `08-state/State.hs`: generic State and interface |
| 03 | Q2, p.2: code from signatures; Q4(b), p.4: mapM rewrite | `07-monads/GenericMonads.hs`: traversal, sequence, composition; `EitherMonad.hs`: error propagation |
| 04 | Q4, p.4: same generic collector under Maybe and lists | `07-monads/Monads.hs`: do notation and List Monad; `GenericMonads.hs`: collection |
| 05 | Q1/Q2/Q4, pp.1/2/4: State types, construction, and tracing | `08-state/State.hs`: Accessing and Modifying State; `StateMonad.hs`: state passing |
| 06 | Q3, p.3: three loop obligations for proposed invariants, including a suffix | `lectures/midterm-2/DafnyVerificationConditions.pdf`: physical pp.3-7 assignment, 8-12 sequence, 19-30 loops |
| 07 | Q5, p.5: summary/list helper, two calls, optional one-call version | `dynamic/Dynamic.hs`: broader laziness and self-reference context; exact helper structure adapted from sample |

Abbreviated lecture paths in the table are under `lectures/midterm-2/` at the
repository root. The sample mentions an appendix, but the local PDF has only
five pages and no appendix page. The short reference signatures we supply are
study aids from the used interfaces, not an official appendix reconstruction.

The seven topic splits, lengths, untimed format, lack of point values, guided
examples, and changed questions are supplementary practice choices requested
for this study sequence. Each mock uses its topic's relevant sample question
types; it is not a full exam or a prediction. Feedback waits until the end of a
mock unless requested. No solution key is placed in student files.

Source issues: the sample's Q3 varies `Triangle`/`triangle` capitalization.
The Dafny deck labels itself Spring 2026, and physical p.12 (printed slide 11)
apparently has `forward`/`sp` typos in its backward weakest-precondition rule.
Our questions use consistent names and work backward through sequences.
Part 06 asks only the partial-correctness obligations, as stated in each file.

Transformers, array DP, GADTs, and Agda occur in the local lectures but are not
explicitly asked in the sample. The earlier workbook's extension questions
remain archived, outside the current seven-part route. This is not evidence
that those topics are excluded from the upcoming exam.
