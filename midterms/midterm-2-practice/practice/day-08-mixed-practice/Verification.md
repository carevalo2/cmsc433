# Day 8 Mixed practice verification exercise

Attempt this alongside [Practice.hs](Practice.hs) and set your answers aside before asking for feedback. Use partial correctness. This exercise pairs the sample's proposed-invariant question with two assignments after the loop. [Sample exam, Q3](../../data/Midterm%202%20Example%20-%202025.pdf)

```dafny
method Accumulate(n: int) returns (total: int)
  requires n >= 0
  ensures total == 4*n + 5
{
  total := 1;
  var remaining := n;
  while remaining > 0 {
    total := total + 2;
    remaining := remaining - 1;
  }
  total := 2*total;
  total := total + 3;
}
```

**8.6** For each proposed invariant, list initialization, preservation, and exit. Show the substitutions and give a counterexample for any invalid implication.

1. `remaining >= 0 && total + 2*remaining == 2*n + 1`
2. `remaining >= 0 && total == 1`

Your three implications and any counterexample for the first proposal …

Your three implications and any counterexample for the second proposal …
