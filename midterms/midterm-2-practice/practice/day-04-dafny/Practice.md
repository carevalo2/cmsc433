# Day 4 Dafny verification conditions

Follow the review at **27:47–38:06** and the course lecture's assignment, sequence, and loop rules. Today's exercises ask for **partial correctness**. Use the supplied invariant to generate initialization, preservation, and exit conditions. [Dafny verification lecture](../../../../lectures/midterm-2/DafnyVerificationConditions.pdf) · [Sample exam, Q3](../../data/Midterm%202%20Example%20-%202025.pdf)

## Worked example

For `x := x - 2;` to establish `x >= 4`, the condition before the assignment is `x - 2 >= 4`. With two assignments, start at the last one and apply the same substitution again as you move back. For a loop, start at the condition you need in each place.

| Obligation | Assumptions | Condition to establish |
| --- | --- | --- |
| Initialization | Method precondition | Invariant after the prefix |
| Preservation | Invariant and true guard | Invariant after one body execution |
| Exit | Invariant and false guard | Method postcondition after the suffix |

## Guided exercises

**4.1 Weakest precondition.** Work backward through `x := y + 2; y := x - 1;` with target `x > y && y >= 0`. Give the formula before the second assignment, then before the first. Keep the intermediate formula visible.

Your substitution before the second assignment …

Your substitution before the first assignment …

**4.2 Initialization, preservation, and exit.** Use `I = i >= 0 && t + 3*i == 3*n` in the program below. Derive one implication at a time. Include the precondition before the first implication and the suffix in the last one.

```dafny
method CountByThree(n: int) returns (t: int)
  requires n >= 0
  ensures t == 3*n + 2
{
  t := 0;
  var i := n;
  while i > 0 {
    t := t + 3;
    i := i - 1;
  }
  t := t + 2;
}
```

Your initialization implication …

Your preservation implication …

Your exit implication …

**4.3 Compare proposed invariants.** For the same program, derive the three obligations for each proposed invariant below. Then identify any obligation that fails and give concrete values that satisfy its left-hand side and violate its right-hand side.

- `i >= 0 && t == 0`
- `t + 3*i == 3*n`

Your implications and counterexamples …

**4.4 Transfer.** Replace the suffix with `t := 2*t; t := t + 1;` and the postcondition with `t == 6*n + 1`. With the original invariant from 4.2, derive the new exit implication, showing both substitutions. Explain why the other two obligations stay the same.

Your derivation …

## Study notes and final review

November 26, 2026. These notes refer to the [Extra Practice worksheet](ExtraPractice.pdf), which uses `CountUpByFour` for Q4.2–4.4.

- **What went well.** You wrote both backward substitutions in Q4.1 and simplified them to `y >= 5` after checking the inequalities. For Q4.2 you correctly substituted the setup assignments into the invariant and worked out what the invariant requires after one loop iteration. You found valid counterexamples for both failed obligations in Q4.3 Candidate A, checking that each example made the assumptions true and the target false.
- **What took practice.** In Q4.1, the direction of `3 < y` briefly got flipped. In Q4.2, you initially used just the guard as the preservation assumption and also tried requiring the guard after the body. Exit took the most guidance. You initially applied the suffix substitution to the invariant, then correctly applied it to `ensures`. The concrete `t = 12` to `t = 10` example helped distinguish the value at loop exit from the value at method return.
- **What to review.** Name the program point on each side of the implication. For preservation, assume the invariant and true guard, then work backward from the invariant through the body. For exit, assume the invariant and false guard, then work backward from `ensures` through the suffix. For a failed implication, explicitly verify that the counterexample satisfies every assumption and falsifies the target.

After covering all scheduled material and finishing Day 9 recall, try Extra Practice Q4.3 Candidate B and Q4.4 without notes. Those attempts are still open. Write all three obligations for Candidate B, then use Q4.4 to practice an exit check with two suffix assignments. Explain which value each occurrence of the updated variable refers to before simplifying.
