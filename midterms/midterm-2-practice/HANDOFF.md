# CMSC433 Midterm 2 study handoff

Saved November 10, 2026. Evidence comes from this chat and the current files.
The user asked to omit the specific pending question; it is not recorded here.

## Current position

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

## Part 01: evidence and remaining retention checks

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

## Part 02: evidence and areas to revisit

### Maybe, mapping, and application

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

### State, partial application, and shared variables

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

## How to teach next

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

## Files and sources

- Active route: this directory's `README.md` and `practice/01-*` through `07-*`.
- Next coding file: `practice/03-type-to-code/Practice.hs`; on inspection,
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
