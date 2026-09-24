# Dafny Homework Quiz 2

This quiz is based on the concepts in Homework.dfy. For each question, choose the best answer and write it in the blank line.

## Question 1

In the method `PlusOne`, what precondition is needed so that Dafny can prove `y > 0`?

A. `x > 0`
B. `x >= 0`
C. `x < 0`
D. `y >= 0`

Answer:

## Question 2

For `Swap(a, i, j)`, what must be true about `i` and `j` before the method is called?

A. `0 <= i < a.Length && 0 <= j < a.Length`
B. `i < j`
C. `a.Length > 0`
D. `i != j`

Answer:

## Question 3

For `IntDiv(m, n)`, which postcondition correctly expresses that `d` is the quotient and `r` is the remainder with `r` non-negative?

A. `m == n * d + r && 0 <= r < n`
B. `m == d + r && 0 <= r < n`
C. `m == n * r + d && 0 <= d < n`
D. `m == n * d && r == 0`

Answer:

## Question 4

What does the method `ArraySum(a, b)` need to guarantee about the result array `c`?

A. `c.Length == a.Length` and `c[j] == a[j] + b[j]` for each valid index
B. `c.Length == b.Length` and `c[j] == a[j] - b[j]`
C. `c` is sorted in increasing order
D. `c` contains only unique values

Answer:

## Question 5

When checking whether an array is sorted in `IsSorted`, what invariant is most relevant to the loop?

A. `forall j :: 0 <= j < i ==> a[j] >= 0`
B. `forall j :: 1 <= j < i ==> a[j-1] <= a[j]`
C. `a.Length == i`
D. `a[i] == a[i-1]`

Answer:

## Question 6

In `IsPrime`, which statement best describes the condition for `m` to be prime?

A. `m > 1` and `m` is divisible by every number less than `m`
B. `m > 1` and no integer from `2` to `m-1` evenly divides `m`
C. `m` is even and greater than `2`
D. `m` is a perfect square

Answer:

## Question 7

What is the main idea behind implementing `Reverse(a)`?

A. Sort the array before copying it
B. Create a new array where each element is mirrored from the original
C. Only reverse arrays of length 1
D. Copy elements into the same array without changing order

Answer:

## Question 8

In the annotated geometric-series program, what is the intended relationship between `x`, `y`, and `z` during the loop?

A. `z` is always equal to `pow2(x)` and `y` is the running sum up to that point
B. `x` is always greater than `y`
C. `y` is always equal to `z + 1`
D. `z` is always zero

Answer:

## Question 9

In the final three-number addition program, what assertion should hold at the end?

A. `z == a + b + c`
B. `z == a * b + c`
C. `z == a - b + c`
D. `z == a + b - c`

Answer:

---
