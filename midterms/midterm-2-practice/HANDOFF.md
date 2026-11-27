# CMSC433 Midterm 2 study handoff

## Resume here · November 27, 2026

- **Active route.** Days 1–5 of the [nine-day practice sequence](practice/README.md) have been worked through in chat. Day 5 covered recursive collection, traversal, monadic composition, and the value `pure` requires. The plan assumes a December 2 exam.
- **Next lesson.** Resume [Day 6, Q6.1](practice/day-06-monad-tracing/Practice.hs#L13). The user saw the successful example `sequence [Just 'p', Just 'q']` and paused before attempting Q6.1. Ask for the full result, its type, and what happens at the middle action. Then work through Day 6 one prompt at a time.
- **Final review.** After covering all scheduled material and finishing Day 9 recall, return to [Day 4 verification practice](practice/day-04-dafny/Practice.md#study-notes-and-final-review). Extra Practice Q4.3 Candidate B and Q4.4 are available for an independent attempt. Prioritize deriving the exit implication and checking both sides of a counterexample.

## Day 5 learning evidence

- **Q5.1 · `gatherActions`.** Correctly identified the value bound from `Just 7` and wrote `pure []` and `pure (x : xs)` after the recursive bindings were scaffolded. Correctly predicted failure for a list with a middle `Nothing`. Initially gave concrete `Maybe Int` and `Int` when asked for the polymorphic types, and called the recursive result bound by `<-` `[Maybe a]`. After feedback, correctly typed a fresh binding from `Just [True, False]` as `[Bool]`. Recheck `m [a]` versus `[a]`, especially with nested `Maybe` in Day 6.
- **Q5.2 · `walkActions`.** Correctly inferred `map f inputs :: [m b]`. Initially tried gathering `inputs` before `map`. After a type-based hint, wrote `gatherActions (map f inputs)`. Revisit the intermediate type when expressing collection with `mapM` in Q6.3.
- **Q5.3 · `composeActions`.** Correctly bound the result of `f x`. Initially called `f` again on that result, then correctly called `g` but used the plain payload as the final `do` line. Reviewed ordinary `(.)` and why the final line needs an action. The assistant showed the direct `g res` form. The user then correctly predicted the full `Just True` result on a fresh input.
- **Q5.4 · Polymorphic results.** Recognized that a counterexample could rule out a universal construction. Needed help choosing an empty payload type under `Identity` and explaining why `pure` needs a value of that type. Correctly answered `pure x` when given `x :: a`. Recheck which type is the monad and which is the payload.
- **Saved work.** The three implementations are in [Day 5 Practice.hs](practice/day-05-types-to-code/Practice.hs). All six supplied checks passed in GHCi on November 27 (`checkGather`, `checkWalk`, and `checkCompose`). Q5.4 was discussed in chat and remains a reasoning prompt in the file.

## Day 4 worksheet and setup

- The user worked through Extra Practice Q4.1, Q4.2, and Q4.3 Candidate A on November 26.
- Use [Practice.tex](practice/day-04-dafny/Practice.tex) to edit answers and [Practice.pdf](practice/day-04-dafny/Practice.pdf) to follow the worksheet. Each `\answer` takes the student's text in its last pair of braces. An empty answer becomes a fillable PDF field. The [original Markdown prompts](practice/day-04-dafny/Practice.md) are also available.
- Both Q4.1 substitutions are saved in the LaTeX. The rebuilt four-page PDF shows both answers and has 15 fillable fields for the remaining questions. In discussion, the whole-sequence condition simplified to `y >= -1`.
- In the Windows VS Code workspace, Ctrl+S now rebuilds the PDF with the cached Tectonic recipe. The `.vscode/settings.json` recipe is local and Git-ignored. Manual rebuild commands are in the LaTeX header. Save a separate PDF copy for answers entered directly into PDF fields.

## Current learning evidence

| Lesson | Demonstrated | Revisit with a fresh example |
| --- | --- | --- |
| [Day 1 · Foundations](practice/day-01-foundations/Practice.hs) | Correctly inferred `[Bool] -> [Bool]` and `(Maybe a -> b) -> a -> [b]`, wrote a correct `keepFalse`, and gave the right result and type after applying a wrapped pair constructor. | Initially wrote a type with `Just` where `Maybe` belongs. Initially paired two comprehension generators as if zipped. After tracing a fixed `x` through every `y`, got the ordered result right. |
| [Day 2 · State](practice/day-02-state/Practice.hs) | Wrote correct `lessThanSaved`, `beforeAndAfter`, and `updateSecond` in chat. Got a shorter `sequence` trace right after feedback and derived the changed `reverse`/`<*>` type with scaffolding. | Needed help keeping the remaining arrow in a function-valued result, distinguishing `put value` from `modify function`, and separating the action's return value from the final stored state. Initially returned only the last `sequence` result and omitted the outer `runState` pair on the applicative example. The original `Num s` derivation was worked by the assistant. |
| [Day 3 · Laziness](practice/day-03-laziness/Practice.hs) | Correctly traced the sum and repeated seed once their roles were separated. After a restart, independently predicted a fresh helper pair and selected the filled list with `snd`. Explained that the sum uses only the input list and chose `total` as the seed in the guided one-call binding. Correctly predicted `10` for a productive recursive binding and an error when `sum` demands undefined seed values. | Two-call implementation was shown after hints. The one-call implementation was reproduced with scaffolding. On initial output attempts, the user gave the sum instead of `filled`, expected `fst` and `length` to force an undefined seed, and expected a cycle inside list elements to block `length`. The recorded minimum helper's empty and singleton cases were walked through with substantial help. Treat all of these as retention targets. |
| [Day 4 · Dafny](practice/day-04-dafny/Practice.md#study-notes-and-final-review) | Correctly wrote and simplified the Extra Practice Q4.1 substitutions after guidance, derived the initialization target and preservation target for Q4.2, and gave valid counterexamples for Candidate A's initialization and preservation. Completed the exit reasoning with guidance. | Recheck inequality direction, which assumptions belong on the left, and how the suffix changes the right-hand side of the exit implication. |

### Related Haskell review

Before switching to the current checkout, we worked through the archived Part 03 material in chat. This covered `collectMaybe`, `walkM`, `composeM`, and the mock's `collectEither`, `mapM id`, and `Identity Empty` counterexample. The user needed guidance on the payload bound by `<-`, the difference between passing an action through and wrapping it with `pure`, and why one counterexample monad and payload type disprove the universal result type. The Day 5 notes above record the latest attempts.

### Teaching notes for the next agent

- Ask one prompt at a time. Start with a concrete value or worked example, then let the user try a fresh variation. Explicitly name whether you want a whole type, a returned value, a `runState` pair, or one field of a tuple. When confusion repeats, shrink the question to one operation or one field.
- For laziness, begin from the final consumer. Have the user identify whether it asks for a tuple field, the list constructors, or the values inside those constructors. Then trace the dependency. A cycle in an element matters when that element is demanded. Give the intended input/output behavior before asking for another implementation.
- The user pasted a GHCi run where printing the whole pair from `spreadSum [4,-1,2] undefined` printed the sum and then raised `Prelude.undefined` in the list. On November 26, all nine supplied checks for the saved Days 1–3 implementations passed in GHCi. Use the chat evidence above for the reasoning prompts.

## Historical handoff · November 10, 2026

Saved November 10, 2026. Evidence comes from this chat and the current files.
The user asked to omit the specific pending question; it is not recorded here.
This record predates the [nine-day practice sequence](practice/README.md).

### Position at that handoff

- **Part 01, type foundations:** guided practice completed; notebook mock
  attempted and answer key reviewed. User reported that all six answers matched.
  This is self-reported cross-checking, not inspection of the notebook or an
  independently assigned score. The Boolean-guard question required guidance.
- **Part 02, context types:** guided worksheet completed with substantial
  scaffolding; notebook mock attempted and full answer key reviewed at the
  user's request. Do not claim all answers were independently correct.
  Mock (d), `(:) <$> get`, and (e), generic fmap typing, were guided in chat.
  The user's other notebook answers were not shown or individually graded.
- **Parts 03-07:** not started in this study sequence. Do not infer completion
  from the existence of files or older practice from another session.

Resume with the user at the transition out of Part 02. Offer a short targeted
review if needed, then proceed to Part 03's guided `Practice.hs` when ready.
Do not automatically restart Parts 01-02 or open the next mock before teaching.
There is no saved pending question to repeat verbatim.

### Part 01 evidence and remaining retention checks

Demonstrated after teaching:

- Read lambdas as inputs followed by a body; assemble higher-order signatures.
- Correctly generalized passing a singleton list versus passing `Just x` to
  another function. Correctly inferred the changed output-list example
  `(a -> b) -> a -> [b]` without step-by-step help on that example.
- Under the agreed Int convention, correctly identified a list of `(Int,Bool)`
  pairs as the output of a changed comprehension.
- Explained why different functions given the same input may have different
  result types, after an initial explanation based only on the shared input.
- Learned comprehension generators, chained guards, multiple generators,
  output expressions versus filtering, and the meanings of `<-` versus `->`.
  Correctly evaluated changed guarded examples after instruction.
- Asked about `fst`/`snd`; explained that they accept pairs, not lists or triples.

Watch for forgetting the function argument's entire arrow type, confusing
an output element with the output list, and omitting numeric/type-class
constraints. Matching the key does not by itself establish independent reasoning
for every question; do not invent a grade or label this complete mastery.

### Part 02 evidence and areas to revisit

#### Maybe, mapping, and application

- Correctly predicted `not <$> Just False` and `length <$> Just "hello"`,
  both values and whole types.
- Initially omitted the remaining function arrow inside Maybe after partial
  application. Corrected this through the pair constructor and `(++)` examples.
- Initially treated `"hi"` as a list of strings. After explanation, correctly
  distinguished `String = [Char]` from `[String]`.
- Correctly evaluated contextual string concatenation and pair construction.
- Needed several guided examples to distinguish a missing outer Maybe value
  from an inner Maybe used as an ordinary payload. Eventually correctly gave
  the result and type for a changed outer-Nothing/nested-Maybe example.
- Generic context typing was new: inferred `(a -> b) -> t a -> t b` with
  scaffolding. The assistant then supplied the required `Functor t` constraint.
  Recheck that constraint independently later; it was not independently recalled.

#### State, partial application, and shared variables

- Learned to distinguish `State storedType returnedType` from the runner's
  `(returnedValue, finalState)` pair order. Explicitly identified that reversal
  as a source of confusion.
- Correctly traced basic get/put/sequencing/bind examples after explanation.
- With scaffolding, inferred the worksheet's reverse-state update and
  `(s -> s) -> State s s` for a function that modifies then reads state.
- Initially left stored type generic when a concrete `put` fixed it, reversed
  the two State type parameters, and used unrelated type variables where a
  modifying function and state must share one type. Corrected changed examples
  after feedback; revisit these with fresh questions rather than assume fluency.
- Cons syntax `(:)` needed a concrete explanation before typing. After worked
  concrete-state examples, correctly generalized the function-valued State
  result in mock (d). Count that as guided, not independent mock success.

### Teaching notes from the earlier sequence

- Keep the full expression visible. Explain unfamiliar notation before asking
  for a type. The user has asked what the question itself means more than once.
- Ask one small prompt and wait. Name whether the requested answer is a value,
  a payload type, or a whole expression type.
- Use concrete examples, then generalize. If confusion repeats, reduce the
  problem to one slot instead of repeatedly asking for the same full signature.
- Keep topic-sized folders: guided Practice first, then a changed independent
  Mock. During mocks, withhold feedback until the end unless the user requests
  help. Track guided questions separately.
- The user writes mock answers in a physical notebook and requests the full
  key afterward. Do not assume the blank `.tex` placeholders mean no attempt.
- User reports that appropriate numeric examples may use Int on exams. Accept
  explicitly specialized Int answers in that context. For genuinely most-general
  answers retain required constraints; a bare variable is not shorthand for Int.
  This convention is user-provided, not an independently verified instructor rule.
- AGENTS.md now records the user's observation that recent CMSC433 exams are
  slightly harder than past samples. Build toward more complex combinations
  of the same question types after foundations, without adding excessive volume.
- Revisit comprehensions as short mixed review later; the current later sheets
  do not already contain a larger set of complex comprehension questions.

### Files and sources from the earlier sequence

- Route at the time of this handoff: [the archived topic worksheets](archive/2026-11-23-topic-practice/practice).
- Next coding file at the time: [Part 03 Practice.hs](archive/2026-11-23-topic-practice/practice/03-type-to-code/Practice.hs). On inspection,
  `collectMaybe`, `walkM`, and `composeM` still contain `undefined`.
  Teach the type ledger/base case first; do not fill implementations unasked.
- Written topics 01/02/04/06 each have separate one-page Practice and Mock
  PDFs and editable LaTeX sources. Coding topics 03/05/07 use `.hs` directly.
- Shared `support/StudyState.hs` and `StudyCheck.hs` are supplied infrastructure,
  not learner implementations. Do not treat their completeness as learner progress.
- Rebuild written work from repository root with
  `powershell -ExecutionPolicy Bypass -File midterms/midterm-2-practice/build.ps1 -Part 02`.
- The old combined workbook and original practice are preserved in `archive/`.
  Current answer files and notebook work must be preserved.
- Course evidence: `SOURCES.md`, the Spring 2025 sample in `data/`, and the
  relevant local lecture sections. Read relevant sources before teaching.
  Current exam scope, timing, and rules remain unconfirmed.

No learner code or tests were executed while saving this handoff. Earlier
authoring checks are documented in `VALIDATION.md` and are not learner results.
No lightning round was conducted: this was a request to save progress.
