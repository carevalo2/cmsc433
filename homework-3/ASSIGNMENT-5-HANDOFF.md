# CMSC433 Assignment 5 learning handoff

Updated November 9, 2026, replacing the November 8 stopping point. This is homework progress, not exam preparation. HW4 and HW5 build on HW3 and live in `homework-3`; do not assume this directory contains only HW3. Read the workspace `AGENTS.md` and reread the active source before continuing because the student may have edited it.

## Current status and last work

**The student completed `vcBlock` and method-level `vc` through guided implementation. Both are saved in [src/VCGen.hs](src/VCGen.hs). No `undefined` placeholders remain in that file.** The four supplied HUnit tests were executed by the assistant and passed.

**The last work was a submission-readiness review, not another implementation step.** The student asked whether HW5 was ready to turn in. Additional probes confirmed that `vcStmt` misses verification conditions for loops inside `If` branches and inside other loop bodies. These cases have not been fixed. Do not declare the assignment fully ready merely because the four supplied tests pass.

The student then requested this handoff update, highlighting their struggles and the last work. No assignment code was changed by the assistant, and nothing was submitted. Resume at the nested-loop/branch coverage issue, rather than restarting `vcBlock` or `vc`.

## Goal and teaching preferences

The student is completing Assignment 5's MiniDafny verification-condition generator. Their established request is **“guide me, dont give me the full answer.”** Continue as a tutor, not an autonomous assignment implementer. This save request authorizes documentation changes, not assignment-code changes.

The strongest repeated need is **knowing the concrete situation and program location before discussing the next expression**. During this session the student repeatedly asked “where we're at,” “what situation are we in rn?”, and what a particular binding's job was. Correct arithmetic answers did not mean the relationship between functions was understood or retained.

Use this sequence:

1. Show a small MiniDafny example and the desired result.
2. Locate the exact point: method entry, before a statement, between statements, before an iteration, or loop exit.
3. Explain the immediate task in plain language.
4. Identify the existing function, its inputs, and the kind of value it returns.
5. Show the location of one new binding in the student's scaffold.
6. Ask one small question and wait. When the student says “next,” advance rather than repeating the same check indefinitely.

Avoid introducing several helper names at once. Explain the purpose before naming a new value. “Establish the condition” was clearer when restated as “make the condition true.” If confusion returns, stop adding code and use a forward execution trace with actual values. Do not rely only on repeated arithmetic exercises to assess conceptual understanding.

Most implementation steps used substantial scaffolding or a corrected small case. Do not describe this as independent mastery. The student requested a save, so do not initiate an end-of-session quiz or lightning round as part of this update.

## What the student struggled with

### Program locations and the middle boundary

The main difficulty was why a condition calculated **before `rest`** is called `afterFirst`, and why `first` must make it true. The useful example was:

```text
x := 2;                 // first

// Need x + 2 == 4 here: AFTER first and BEFORE rest.

y := x + 2;             // rest

// Want y == 4 here: p.
```

A helpful forward trace assumed `x` initially equaled `100`. The student correctly identified that after `x := 2`, the second assignment uses `x = 2`, not `100`. They then correctly identified that the requirement belongs when the second statement is about to run, rather than necessarily before the whole program starts.

This supports understanding of the location, but they did not independently give a sustained explanation of the whole pipeline. Reground that boundary if needed instead of assuming the earlier numerical answers resolved it.

### What `wp` actually does

The student correctly calculated conditions such as `x + 2 == 4`, but later asked “what does wp do again.” Do not assume recall is stable.

They eventually supplied this description with a sentence scaffold: `wp` gives **“the required condition beforehand.”** They also correctly recognized that calculating the requirement does not prove it holds for unknown starting values.

They independently gave the counterexample `x = 3` to explain why an assumption `x >= 2` does not guarantee `y == 4` after `y := x + 2`.

Use the input/output distinction:

```text
code + desired condition afterward
                 ↓ wp
       required condition beforehand
```

For this assignment a loop's `wp` is its supplied invariant; separate conditions justify using that invariant. It is not automatic invariant discovery or a termination proof.

### `vcStmt`, `firstChecks`, and recursion

The student repeatedly asked what `vcStmt afterFirst first` returns and what `firstChecks` does. Explain that `vcStmt` constructs a **list of predicates to prove**, while `firstChecks` is a local variable storing that list. It is not the statement itself, a runtime value, a proof, or a Boolean success result.

For the example loop below, the student correctly identified that `afterFirst` is used in the **exit check**, rather than the invariant-preservation check:

```text
while x < 2
  invariant x <= 2
{
  x := x + 1;
}
y := x + 2;
// Want y == 4.
```

The two loop claims are:

```text
(x <= 2 && x < 2) ==> x + 1 <= 2
(x <= 2 && !(x < 2)) ==> x + 2 == 4
```

They correctly concluded that at exit the bounds force `x == 2`. Their explanations of preservation were more heavily guided; do not infer independent mastery of that obligation.

They initially supplied only `vcStmt afterFirst` and did not know which statement to pass. Explain that the pattern `Block (first : rest)` already binds `first` to the entire first statement, including its full loop body when it is a loop. No reconstruction is needed.

They correctly identified:

- In two assignments, `first` is the first assignment.
- `firstChecks` covers only the first loop in a block containing two loops.
- If an assignment is followed by a loop, that loop's checks belong in `restChecks`.
- The ending goal passed when collecting checks for `rest` is `p`.
- The empty block yields `[]` because there is nothing to check and it is the base case.
- The combination is `firstChecks ++ restChecks`.

They needed an explanation of why to call `vcBlock` again: it collects checks for the smaller remaining block, whose first statement becomes `first` in that recursive call. In the current implementation an ordinary assignment contributes no extra loop checks; `firstChecks` for that assignment is `[]`, not the assignment itself.

### Method-level `vc`, entry checks, and lists

The student initially counted only two checks for a method with one loop, forgetting the additional method-entry check. After correction, they correctly said that a method with no loops still has its entry check.

The method-level situation needed to be restated concretely:

- `r = requires specs`: what may be assumed at method entry.
- `e = ensures specs`: what must hold at method end.
- `bodyRequirement = wp (Block ss) e`: what the body needs at entry to achieve `e`.
- `entryCheck = PredOp r Implies bodyRequirement`: the claim connecting the allowed inputs to that requirement.
- `loopChecks = vcBlock e (Block ss)`: the loop-related claims for the whole body, with `e` as its ending goal.

They correctly supplied `e` for `wp`, wrote the entry implication, and chose `e` for `vcBlock` after further grounding.

Their attempted final expression was:

```haskell
in bodyRequirement ++ entryCheck ++ loopChecks
```

The correction was that `bodyRequirement` and `entryCheck` are individual predicates, whereas `loopChecks` is a list. `bodyRequirement` is already used inside the entry implication and is not a separate check to return. The correct return expression is:

```haskell
in [entryCheck] ++ loopChecks
```

Their latest conceptual answer was that the method's requirement needs to imply `bodyRequirement`; clarify specifically that this is `r`, the method's `requires`. This was accepted as correct, but the full solution still followed guided steps.

## Saved implementation

The current `vcStmt` is unchanged from the previous handoff:

```haskell
vcStmt :: Predicate -> Statement -> [Predicate]
vcStmt p (While invariant condition body) =
  let bodyRequirement = wp body invariant
      iterationStart = PredOp invariant Conj (Forall [] condition)
      preservation = PredOp iterationStart Implies bodyRequirement
      exitFacts = PredOp invariant Conj (Forall [] (Op1 Not condition))
      exitCheck = PredOp exitFacts Implies p
  in [preservation, exitCheck]
vcStmt _ _ = []
```

The newly completed functions are saved as:

```haskell
vcBlock :: Predicate -> Block -> [Predicate]
vcBlock p (Block []) = []
vcBlock p (Block (first : rest)) =
  let afterFirst = wp (Block rest) p
      firstChecks = vcStmt afterFirst first
      restChecks = vcBlock p (Block rest)
  in firstChecks ++ restChecks

vc :: Method -> [Predicate]
vc (Method _ _ _ specs (Block ss)) =
  let e = ensures specs
      r = requires specs
      bodyRequirement = wp (Block ss) e
      entryCheck = PredOp r Implies bodyRequirement
      loopChecks = vcBlock e (Block ss)
  in [entryCheck] ++ loopChecks
```

The supplied `requires` and `ensures` helpers remain unchanged.

Previously completed work remains:

- Expression substitution for literals, ordinary variables, unary operators, and binary operators; array-error cases are preserved.
- Predicate substitution through `PredOp`; for `Forall`, substitution is skipped when the target name is bound, otherwise it recurses into the expression.
- `WP Statement` for assignment, declaration, `If`, and `While`.
- `WP Block` with the working recursion `wp first (wp (Block rest) postCondition)` and the empty-block base case. Do not replace it with a fold merely because the starter suggests folds.

Earlier learning observations worth retaining: bound-variable scope, constructor versus parameter names (`Name` versus `name`), the polymorphic result of `subst`, constructor argument order (`PredOp left operator right`), unary negation (`Op1 Not condition`), wrapping statement lists as `Block`, and using `Forall [] expression` as a predicate all required support. The student previously performed substitution in both occurrences of `y` in `y * (x + y)` correctly, but variable-scope mastery was not independently established.

## Exact stopping point: submission review found missing traversal

The completed `vcBlock` walks the statements directly in its input block, and `vc` combines the entry check with the resulting list. The remaining issue is **`vcStmt` does not descend into compound statements to collect further loop obligations**:

- An `If` reaches `vcStmt _ _ = []`, so loops in either branch are skipped.
- The `While` case returns only that loop's own two checks; it never collects checks for loops nested in its body.

The assistant confirmed the behavior with additional GHCi probes using supplied `wSquareWhile`:

```haskell
length (vcBlock (Forall [] wWhilePost)
  (Block [If (Val (BoolVal True)) (Block [wSquareWhile]) (Block [])]))
-- Observed: 0; the branch's loop would contribute 2 checks.

length (vcStmt (Forall [] wWhilePost)
  (While (Forall [] wInv) (Val (BoolVal True)) (Block [wSquareWhile])))
-- Observed: 2; collecting both loops' checks would give 4.
```

These probes count constructed obligations; they do not prove the example programs correct. They were run interactively and were not added as permanent tests.

The source instructions say “each while loop in a program introduces two additional verification conditions.” On that available wording, the assistant recommended addressing this gap before submission. No separate handout/rubric was found, so official grading scope and submission format remain unverified. Do not invent hidden-test expectations or claim that an external instructor requirement was checked.

**Suggested next tutoring step:** ground a tiny `If` containing a loop, explain why its branch is itself a block to inspect, then guide one `vcStmt` case at a time. An `If` case must appear before the wildcard fallback. Subsequently address loop bodies using the invariant as the condition wanted after an iteration. Do not paste a full extension or silently edit code. Add focused regression coverage when making the change, preserve supplied-test ordering, and rerun the existing tests.

Earlier teaching described `vcBlock` as collecting all loop checks without sufficiently qualifying the missing compound-statement traversal. Correct that description explicitly if it causes confusion: the intended goal is whole-block coverage, but the saved implementation currently misses the cases above.

## Verification and environment

This continuation ran on the student's Mac in `/Users/chris/cmsc433-1`. `stack`, `ghci`, `ghc`, and `cabal` are available under `/Users/chris/.ghcup/bin/`. Do not assume the earlier Windows PATH issue applies to this Mac session.

From `homework-3`, the assistant actually executed:

```sh
stack ghci src/VCGen.hs --ghci-options '-e "runTestTT (TestList [test_substExp, test_substPred, test_vcStmt, test_vc_method])"'
```

Result: **Cases: 4, Tried: 4, Errors: 0, Failures: 0.** This includes the end-to-end `Square` method test. The older handoff's student-reported-only test status is superseded by this executed result. Passing these tests does not establish comprehensive coverage, as the additional traversal probes demonstrated.

Stack emitted a Cabal indentation warning at line 31 and a warning that the file target belongs to both the library and executable; it selected the library. These did not prevent the run. No Cabal configuration was changed. A separate full executable build was not performed.

The project uses resolver `lts-22.24`, `GHC2021`, and HUnit values run through GHCi; there is no dedicated Cabal test-suite stanza. For interactive work:

```sh
stack ghci src/VCGen.hs
```

Then, after saving edits:

```haskell
:reload
import Test.HUnit
runTestTT (TestList [test_substExp, test_substPred, test_vcStmt, test_vc_method])
```

Historical Windows note: on the prior PC, Stack 3.11.1 existed at `C:\ghcup\bin\stack.exe` but was not on PowerShell's PATH. Launching it by its full path worked. Only a temporary PATH adjustment was suggested; no permanent PATH change was made. Retain this for a return to that PC, not as the current environment description.

## Course sources and preservation

- Active assignment instructions and examples: [src/VCGen.hs](src/VCGen.hs).
- AST definitions: [src/Syntax.hs](src/Syntax.hs).
- Earlier session course references: [HoareLogic.dfy](../lectures/hoare-logic/HoareLogic.dfy) and [Verification.dfy](../lectures/verification/Verification.dfy). These were recorded as read in the previous handoff, not newly reread during this continuation.
- No separate Assignment 5 handout, rubric, deadline, allowed-resource policy, or submission-format instructions were verified in this continuation. Follow documented course rules if supplied.
- Arrays and assertions are excluded by the starter. Preserve the existing array-error cases.
- The substitution introduction has reversed English wording about what replaces what; use the intended assignment rule: replace the assigned variable with the assigned expression in the postcondition.

The working tree was clean immediately before this documentation update. The completed student source was already saved. This update changes only this handoff; preserve any later user changes. No commit, push, or assignment submission was performed by the assistant. The assignment remains pending the traversal issue and verification of any external submission requirements.
