# Dafny Homework Quiz

This quiz covers the key ideas from the Dafny assignment on preconditions, postconditions, loop invariants, arrays, and reasoning about correctness.

## Question 1

Which of the following is the best purpose of a `requires` clause in a Dafny method?

A. It states what the method guarantees after it finishes.
B. It states what must be true before the method is called.
C. It specifies how many local variables the method uses.
D. It declares the return type of the method.

Answer: B

## Question 2

In a method that swaps elements `a[i]` and `a[j]`, what precondition is required to avoid an array-bounds error?

A. `0 <= i <= a.Length && 0 <= j <= a.Length`
B. `0 <= i < a.Length && 0 <= j < a.Length`
C. `i < j` and `a.Length > 0`
D. `i != j`

Answer: B

## Question 3

Which statement best describes an `ensures` clause?

A. It restricts what inputs are allowed.
B. It describes properties that must hold after the method runs.
C. It defines a loop invariant.
D. It declares a new array.

Answer: B

## Question 4

If `IntDiv(m, n)` is specified as:

`ensures m == n * d + r && 0 <= r < n`

what is the intended meaning of `d` and `r`?

A. `d` is the product and `r` is the quotient.
B. `d` is the quotient and `r` is the remainder.
C. `d` is the divisor and `r` is the dividend.
D. `d` is the sum and `r` is the difference.

Answer: B

## Question 5

Why are loop invariants useful in Dafny verification?

A. They help the compiler optimize the code.
B. They give a condition that remains true across each iteration and help prove correctness.
C. They replace all `requires` clauses.
D. They automatically generate test cases.

Answer: B

## Question 6

For `ArraySum(a, b)`, what should the postcondition ensure about the result array `c`?

A. `c.Length == a.Length` and each element is the sum of the corresponding elements from `a` and `b`.
B. `c.Length == b.Length` and `c` contains only unique values.
C. `c` is identical to `a`.
D. `c` is sorted in ascending order.

Answer: A

## Question 7

When checking whether an array is sorted, which property is the most relevant invariant in a loop that inspects adjacent elements?

A. Every element is greater than zero.
B. For all earlier indices `j`, `a[j-1] <= a[j]`.
C. The array contains no duplicates.
D. The array length is constant.

Answer: B

## Question 8

A number is prime if it is:

A. Greater than 1 and divisible by every number less than itself.
B. Greater than 1 and not divisible by any integer from 2 to `m-1`.
C. Even and greater than 2.
D. A perfect square.

Answer: B

## Question 9

What is the key idea behind implementing `Reverse(a)` in Dafny?

A. Copy elements in place without using a new array.
B. Build a new array so that `aRev[i] = a[a.Length - i - 1]`.
C. Sort the elements before reversing them.
D. Only reverse arrays of length 1.

Answer: B

## Question 10

Which statement best explains why `fresh(aRev)` is used in the postcondition for a returned array?

A. It ensures the returned array was created newly during the method execution.
B. It indicates the array is already initialized.
C. It ensures the array is sorted.
D. It guarantees the array length is zero.

Answer: A

---

# Answer Key

1. B
2. B
3. B
4. B
5. B
6. A
7. B
8. B
9. B
10. A
