# CMSC433 Assignment 5 learning handoff

Saved November 8, 2026. This describes the current homework session, not exam preparation. Read the workspace `AGENTS.md` and reread the active source before continuing; the student may have edited it after this handoff.

## Goal and teaching preferences

The student is completing Assignment 5 in `homework-3/src/VCGen.hs`, building on the MiniDafny project from earlier assignments. They initially wanted an overview and prerequisites, then began implementing the assignment through guided practice.

**Continue as a tutor, not as an autonomous assignment implementer.** The student explicitly requested: “guide me, dont give me the full answer.” Do not edit assignment code without a request. This request authorized creating this handoff document only.

The strongest repeated preference is to explain the concrete situation and purpose before introducing the next expression. The student repeatedly became lost when the assistant introduced a new helper name, formula, or code fragment without grounding it in the current function.

Use this sequence:

1. Show a small MiniDafny program and what should hold afterward.
2. Point to the exact program location currently being reasoned about: before the whole block, before an iteration, after a loop, or between statements.
3. Explain the immediate question in plain language.
4. Connect it to one existing function and its inputs/output.
5. Show exactly where a single new line belongs in their current scaffold.
6. Ask one small question and wait.

Avoid introducing several helper definitions at once. Helper names themselves are not the student's main concern; they explicitly clarified that the confusion concerns where we are logically and why the next step is needed. Abstract phrases such as “accepting a starting state” and “proposed checkpoint” required concrete explanations. Prefer actual values and execution steps.

If they are confused, stop advancing the implementation. Reteach using a smaller example. A correct arithmetic answer does not establish that they understand how `wp`, `vcStmt`, and `vcBlock` relate.

The student requested this handoff to continue with another AI. Do not initiate an end-of-session quiz or lightning round as part of this save request.

## Sources and assignment scope

- Active instructions and examples are embedded in [src/VCGen.hs](src/VCGen.hs).
- AST definitions are in [src/Syntax.hs](src/Syntax.hs).
- Related course materials read during the session include `../lectures/hoare-logic/HoareLogic.dfy` and `../lectures/verification/Verification.dfy`.
- No separate Assignment 5 handout or rubric was found in the workspace. Do not invent requirements or deadlines. The student said it was not due yet; no due date was established.
- The starter excludes arrays and assertions from this project. Preserve its array-error cases.
- The introduction to substitution contains reversed English wording about which expression replaces which variable. The intended rule is to replace occurrences of the assigned variable with the assigned expression in the postcondition.
- For this assignment, `wp` of a loop returns its supplied invariant. Separate verification conditions justify its use; this is not automatic invariant discovery or a termination proof.

## What is implemented in the saved source

The assistant reread the entire `VCGen.hs` immediately before creating this document. The following reflects that saved file, not just code proposed in chat.

### Expression and predicate substitution

`Subst Expression` has cases for literals, ordinary variables, unary expressions, and binary expressions. Recursion keeps the same target name and replacement while visiting smaller subexpressions. A variable is replaced only when its name matches. The provided array case remains.

`Subst Predicate` handles:

- `PredOp`: recursively substitute in both predicates, preserving the operator.
- `Forall bindings expression`: preserve the whole predicate when the target appears in `map fst bindings`; otherwise substitute in its expression and preserve the bindings.

The bound-variable rule was taught through examples such as replacing program variable `x` in:

```text
x > 0 && (forall x :: x * x >= 0)
```

Only the free occurrence on the left changes. The quantifier introduces its own `x` on the right. This was a guided explanation; do not assume independent mastery of variable scope.

### Weakest preconditions

`WP Statement` is implemented for all non-array constructors:

- Assignment and declaration use `subst postCondition name expression`.
- `If` calculates both branch requirements and constructs the conjunction of the two conditional obligations.
- The current loop case is `wp (While invariant _ _) _ = invariant`.

The `If` result represents:

```text
(condition ==> thenRequirement)
&&
(!condition ==> elseRequirement)
```

`WP Block` is implemented recursively:

```haskell
instance WP Block where
  wp (Block []) postCondition = postCondition
  wp (Block (first : rest)) postCondition =
    wp first (wp (Block rest) postCondition)
```

The starter suggests folds but does not explicitly require them in the available instructions. Do not replace the student's working recursion merely to follow the hint.

### Verification conditions for one statement

The saved implementation is:

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

These claims represent:

```text
(invariant && condition) ==> wp body invariant
(invariant && !condition) ==> p
```

The first check concerns preserving the invariant after one iteration. The second concerns satisfying the required continuation after exit. The function constructs predicates; it does not prove them or execute the program.

The student initially retained both the starter loop equation returning `undefined` and their new loop equation. We removed the duplicate conceptually: the earlier catch-all `While` equation would shadow their implementation. The saved file now has only the implemented loop case and the fallback.

### Incomplete parts

The saved `vcBlock` is exactly:

```haskell
vcBlock :: Predicate -> Block -> [Predicate]
vcBlock p (Block []) = []
vcBlock p (Block (first : rest)) =
  let afterFirst = wp (Block rest) p
  in undefined
```

There is a harmless blank line inside the saved `let` layout. The nonempty case remains unfinished. An earlier uppercase `P` typo was corrected in the saved file.

`vc :: Method -> [Predicate]` is still the starter implementation with `e = ensures specs`, `r = requires specs`, and `undefined` as the result. The supplied `requires` and `ensures` helpers have not been changed.

The current `vcStmt` fallback does not traverse nested `If` blocks or loop bodies for further loop obligations. No nested-loop/branch extension was implemented or established as a requirement in this session. Consult the governing assignment materials before expanding scope or claiming comprehensive verification.

## Exact stopping point and how to resume

We are working on **the nonempty `vcBlock` case**, not on `WP Block` anymore.

The immediate goal is to use the already calculated `afterFirst` when generating verification conditions for `first`. The last assistant prompt offered this scaffold:

```haskell
vcBlock p (Block (first : rest)) =
  let afterFirst = wp (Block rest) p
      firstChecks = vcStmt ___ ___
  in undefined
```

The prompt reminded the student of the order:

```haskell
vcStmt requiredConditionAfterward statement
```

It asked which names fill the blanks when generating checks for `first`, with `afterFirst` as its required result. **The student has not attempted that prompt yet, and `firstChecks` is not in the saved source.** Do not assume this step is understood or paste a completed `vcBlock` solution.

After that step is understood, the remaining conceptual work is to collect checks from the remaining statements and combine the lists in the required order. Then teach the method-level `vc` stage from its comments and run the provided end-to-end test. Introduce each step separately, with its purpose and exact code location.

## Main unresolved conceptual issue

The student is still uncertain about the middle boundary between `first` and `rest`, and about the different outputs of `wp` and `vcStmt`.

Use this example again if needed:

```dafny
x := 3;                 // first

// Need x + 1 == 4 here. This is after first and before rest.

y := x + 1;             // rest contains this assignment

// Want y == 4 here. This is p.
```

`wp (Block rest) p` calculates the middle requirement. The first statement must establish it; the remaining statements use it to reach the final requirement.

Observed responses:

- The student correctly identified the middle formula as `x + 1 == 4`.
- When asked which statement must establish that middle condition, they incorrectly answered “the assignment after the middle.” This was corrected by walking forward through execution.
- With the changed example `x := 2; y := x + 1;` and desired `y == 4`, they correctly answered that `y` actually becomes `3`. This was their latest practice response before requesting the handoff.
- They have not yet independently explained why the first statement is responsible for the middle condition. Do not treat this gap as resolved.

The larger motivating example used a loop as `first`, followed by `y := x + 1`, with final condition `y == 4`. The loop's exit condition must establish `x + 1 == 4`, since the assignment still has to run afterward.

## Other learning observations

The student can perform small substitutions and backward calculations, including changed examples. They independently replaced both occurrences of `y` in `y * (x + y)` with `z + 1`, obtaining `(z + 1) * (x + (z + 1))`.

Areas requiring support during the session:

- Pattern matching introduces local parameter names; names such as `name`, `replacement`, and `thenRequirement` are not automatically predefined by the starter.
- `Name` is a constructor, while lowercase `name` is a parameter containing a string.
- `subst :: a -> Name -> Expression -> a` returns the type of its first argument, not always an expression.
- Constructor argument order: `PredOp leftPredicate operator rightPredicate`.
- Unary negation: `Op1 Not condition`, not `Not condition` or `Op1 (Not condition)`.
- `rest` is a list of statements; wrap it as `Block rest` for the `WP Block` instance.
- `Forall [] expression` introduces no bound variables and allows the expression to be used as a predicate.
- Guard versus invariant: the guard selects another iteration; the invariant must remain true at the loop head and at exit.
- For preservation, the body's desired result is the invariant, not the final loop postcondition. The preservation implication's consequent is the body's precondition, not simply the invariant again.
- Logical implication needed concrete examples, including why the unselected branch's implication is satisfied automatically.

Most implementations were completed with substantial hints or after seeing a small corrected case. Avoid claiming independent mastery or starting with a large new problem.

## Test status and Windows environment

The student **reported that `runTestTT test_vcStmt` passed**, replying “yep works.” No test transcript was supplied. This is a student-reported success for the supplied `Square` loop test, not an assistant-executed test or full assignment validation.

The two substitution tests were suggested earlier, but their success was not explicitly reported. No separate comprehensive `wp` checks, completed `vcBlock` checks, or method-level tests have been established. The assistant did not execute Haskell behavior tests during this session.

PowerShell initially could not find `stack`. The assistant found and successfully ran:

```powershell
& 'C:\ghcup\bin\stack.exe' --version
```

It reported Stack 3.11.1. The executable exists locally; it was absent from the terminal's PATH. The student said earlier successful work on `Eval.hs` was on their Mac, though they believed Stack had worked on this Windows PC too.

From `homework-3`, the suggested direct launch command is:

```powershell
& 'C:\ghcup\bin\stack.exe' ghci src/VCGen.hs
```

Alternatively, the following adds Stack to PATH for the current PowerShell session only:

```powershell
$env:Path = "C:\ghcup\bin;$env:Path"
stack ghci src/VCGen.hs
```

No permanent PATH modification was made by the assistant. Do not assume a new terminal inherits that temporary setting. WSL inventory showed only Docker Desktop; do not assume an Ubuntu Haskell environment is available.

In GHCi, after saving source edits:

```haskell
:reload
import Test.HUnit
runTestTT (TestList [test_substExp, test_substPred])
runTestTT test_vcStmt
```

After the remaining implementation is complete, the provided end-to-end test is `runTestTT test_vc_method`. The Cabal file has no dedicated test-suite stanza, so the established workflow is running HUnit values in GHCi. The project uses `stack.yaml` resolver `lts-22.24` and Cabal's `GHC2021` default language.

## Workspace preservation

At save time, Git showed a modification to `homework-3/src/VCGen.hs` and an unrelated untracked `lectures/03-trees/` directory. Preserve both. This session's assignment edits were made by the student in the IDE; the assistant only read the source and created this handoff document. No assignment was submitted.
