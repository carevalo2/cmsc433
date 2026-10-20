// Unfinished practice scaffold. Requirements are included with each question below.
// TODO statements and missing proof annotations are intentional.

// Q1. Dafny array implementations (10 of 20 points)
// Implement RightSubtract and LeftSubtract using loops, not recursive methods.
// Match foldr (-) 10 and foldl (-) 10 respectively, including empty arrays.
// The traces and invariant explanations (10 points) belong in Written.md.

// Q1: Match foldr (-) 10 over the elements of a.
method RightSubtract(a: array<int>) returns (out: int)
{
  // TODO: implement a loop; explain its invariant in Written.md.
}

// Q1: Match foldl (-) 10 over the elements of a.
method LeftSubtract(a: array<int>) returns (out: int)
{
  // TODO: implement a loop; explain its invariant in Written.md.
}

/*
Q4. Decorated Hoare proof (20 points)

Complete the decorated program below. The method computes four times a positive
integer using repeated addition. Keep the program unchanged. Select a loop
invariant and fill every assertion, working backward through assignments.

Use the assignment rule's literal substitution form; do not simplify an
assertion across an assignment. Use consequence only at the marked `->>`
steps. Include the guard in the loop-entry assertion and its negation at
exit. Explain initialization, preservation, and the exit implication.
Write the explanations in Written.md.
*/

// Q4: Fill the assertions in this decorated program.
// Do not modify the assignments or the guard.
// Assertions are written in comments so you can preserve exact substitutions.
/*
  { m > 0 } ->>
(1) { TODO }
  y := 0;
(2) { TODO }
  var step := 4;
(3) { TODO }
  var remaining := m;
(4) { TODO }
  while remaining > 0 {
(5)   { TODO } ->>
(6)   { TODO }
    remaining := remaining - 1;
(7)   { TODO }
    y := y + step;
(8)   { TODO }
  }
(9) { TODO } ->>
  { y == 4 * m }
*/

// Optional follow-up: encode your completed paper proof as invariants
// and assertions in this executable version without changing the algorithm.
method FourTimes(m: int) returns (y: int)
  requires m > 0
  ensures y == 4 * m
{
  y := 0;
  var step := 4;
  var remaining := m;
  while remaining > 0
    // TODO: add invariant clauses.
  {
    remaining := remaining - 1;
    y := y + step;
  }
}

/*
S2. Verification conditions (15 points)

Use SeriesPlusTwo and Series below. For each proposed
invariant, write these three partial-correctness verification conditions:

1. Initialization after `total := 0; i := n`.
2. Preservation under `i > 0`, accounting for both assignments in order.
3. Exit: invariant and negated guard imply the postcondition after the
   final `total := total + 2`.

Proposed invariants:

A. i >= 0 && total + Series(i) == Series(n)
B. i >= 0 && total == Series(n - i)
C. total == Series(i)

Write the conditions even for invalid candidates. Identify which obligations
fail and give a small counterexample to a failing obligation. Do not silently
replace a candidate with a stronger invariant. Use the capitalized `Series`
consistently. Separately suggest a termination measure (not part of the
three partial-correctness conditions).

Answers:
A initialization: TODO
A preservation: TODO
A exit: TODO
A failed obligations/counterexample: TODO
B initialization: TODO
B preservation: TODO
B exit: TODO
B failed obligations/counterexample: TODO
C initialization: TODO
C preservation: TODO
C exit: TODO
C failed obligations/counterexample: TODO
Termination measure: TODO
*/

// S2: Provided specification function.
function Series(n: int): int
  decreases n
{
  if n <= 0 then 0 else n + Series(n - 1)
}

// S2: Analyze the three candidate invariants above.
// Do not change the program to make a candidate succeed.
method SeriesPlusTwo(n: int) returns (total: int)
  requires n > 0
  ensures total == Series(n) + 2
{
  total := 0;
  var i := n;
  while i > 0
  {
    total := total + i;
    i := i - 1;
  }
  total := total + 2;
}
