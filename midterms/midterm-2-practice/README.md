# Midterm 2: one topic at a time

## Current progress (November 10, 2026)

**Resume from [HANDOFF.md](HANDOFF.md).** Part 01 is completed and cross-checked;
Part 02's guided work and notebook mock have been attempted and its key reviewed.
Some Part 02 questions needed guidance; the notebook has not been independently
graded. Continue from that review, then Part 03 when ready. Parts 03-07 have not
been started in this sequence.

Each folder is **one part**. In that folder:

1. **Practice**: we go through it together, one prompt at a time.
2. **Mock**: a short independent attempt on that topic, with changed questions.
   We wait until you finish the file before giving feedback or hints, unless requested.
3. Review mistakes, then move to the next folder.

There is no combined workbook to finish. Written topics use separate, short
LaTeX/PDF files. Coding topics use Haskell files directly.

| Part | Topic | Guided work | Independent topic mock |
| --- | --- | --- | --- |
| 01 | Type foundations | [Practice.pdf](practice/01-type-foundations/Practice.pdf) | [Mock.pdf](practice/01-type-foundations/Mock.pdf) |
| 02 | Functor, Applicative, and State types | [Practice.pdf](practice/02-context-types/Practice.pdf) | [Mock.pdf](practice/02-context-types/Mock.pdf) |
| 03 | Implement functions from signatures | [Practice.hs](practice/03-type-to-code/Practice.hs) | [Mock.hs](practice/03-type-to-code/Mock.hs) |
| 04 | Trace Maybe/list monadic programs | [Practice.pdf](practice/04-monad-tracing/Practice.pdf) | [Mock.pdf](practice/04-monad-tracing/Mock.pdf) |
| 05 | State programs and function-valued results | [Practice.hs](practice/05-state/Practice.hs) | [Mock.hs](practice/05-state/Mock.hs) |
| 06 | Weakest preconditions and loop VCs | [Practice.pdf](practice/06-verification/Practice.pdf) | [Mock.pdf](practice/06-verification/Mock.pdf) |
| 07 | Lazy summary/list programs | [Practice.hs](practice/07-laziness/Practice.hs) | [Mock.hs](practice/07-laziness/Mock.hs) |

For a new start, begin with Part 01 Practice, Question 1; for this user's current
session, follow the handoff above. We explain and discuss one attempt at a time.
Do not open a topic mock until the guided part makes sense.
Types get two parts because you identified them as a particular difficulty;
they recur in the later topics too. No solutions are included in the mock files.

## Written answers

Edit `Practice.tex` or `Mock.tex` in that topic folder. Replace the text inside
`\answer{...}`. The PDFs are compiled reading copies, not fillable forms.
To rebuild just Part 01 from the repository root:

```powershell
powershell -ExecutionPolicy Bypass -File midterms/midterm-2-practice/build.ps1 -Part 01
```

Use `-Document Practice` or `-Document Mock` to build only one. Omitting `-Part`
builds all written worksheets. The script preserves source files and answers.
The portable compiler and cached packages remain in `.tools/`; an installed
Tectonic/pdfLaTeX is also supported when the portable compiler is absent.

## Coding answers

Edit `Practice.hs` or `Mock.hs` directly. Predictions and explanations go in the
designated comments; implementation answers replace `undefined`. From this folder:

```powershell
& C:\ghcup\bin\ghci.exe -isupport practice/03-type-to-code/Practice.hs
```

Load one file at a time. After edits, use `:reload`. Guided files include `checks`
for example feedback after attempting an implementation. Mock files have no
automatic feedback. Shared State code is supplied in `support/`; you do not
need to implement it. No downloaded Haskell packages are required.

## Basis and difficulty

The topic mocks use the relevant question styles from the Spring 2025 sample:
types, code from signatures, monadic evaluation, induced VCs, and lazy helpers.
The chosen topic lengths, untimed format, and absence of points are practice
choices. They do not establish this year's format, rules, coverage, or weighting.

Estimated difficulty for you, hardest first: contextual/higher-order types;
lazy recursive bindings; verification conditions; polymorphic implementations;
State execution; monadic tracing; basic types. Follow the folder order to build
prerequisites. See [SOURCES.md](SOURCES.md) for the course evidence.

The previous 25-page workbook and every file/answer in its topic folders are
preserved in `archive/2026-11-09-workbook/`. Its extra mixed set and lecture
extensions are optional archived material. The still earlier answered practice
remains in `archive/2026-11-09-original-practice/`. The source sample is in `data/`.
