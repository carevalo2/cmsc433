/*
CMSC 433: Dafny coding practice (20 points)
Modeled on Question 1 of the Spring 2024 midterm.
Suggested practice time: 30 minutes; this is not an official exam limit.

Recall the Haskell folds:

foldr :: (a -> b -> b) -> b -> [a] -> b
foldr f seed [] = seed
foldr f seed (x : xs) = f x (foldr f seed xs)

foldl :: (b -> a -> b) -> b -> [a] -> b
foldl f seed [] = seed
foldl f seed (x : xs) = foldl f (f seed x) xs

Consider this combining operation and these two functions:

step :: Int -> Int -> Int
step x y = x - 2 * y

rightWeighted :: [Int] -> Int
rightWeighted = foldr step 3

leftWeighted :: [Int] -> Int
leftWeighted = foldl step 3

Implement corresponding Dafny methods over arrays of integers. Both methods
must handle empty arrays and negative elements and leave the arrays unchanged.
As in the original exam, method signatures are provided; fill in their bodies.
Use loops for these array implementations. Add annotations needed to verify
array bounds and loop termination. No functional postcondition is provided,
matching the original question's format.

Question (a): RightWeighted (10 points)
Return the result of rightWeighted on the array's elements in array order.

Question (b): LeftWeighted (10 points)
Return the result of leftWeighted on the array's elements in array order.

Do not assume the two folds give the same result.
*/

method RightWeighted(a: array<int>) returns (out: int)
{
  // TODO: implement.
}

method LeftWeighted(a: array<int>) returns (out: int)
{
  // TODO: implement.
}

/*
Supplied examples and boundary cases:

Input array       RightWeighted       LeftWeighted
[]                3                   3
[4]               -2                  -5
[4,1,2]           -14                 -11
[-1,2]            7                   1
[0,0]             12                  3

The test driver uses expect statements, which check results at runtime.
Passing these examples does not prove functional correctness for every array.

After implementing both methods:
  dafny verify Dafny-Coding-Practice-2026-10-08.dfy
  dafny run Dafny-Coding-Practice-2026-10-08.dfy
*/

method Main()
{
  var empty := new int[0];
  var right := RightWeighted(empty);
  var left := LeftWeighted(empty);
  expect right == 3 && left == 3, "empty array";

  var singleton := new int[] [4];
  right := RightWeighted(singleton);
  left := LeftWeighted(singleton);
  expect right == -2 && left == -5, "singleton array";
  expect singleton[0] == 4, "singleton array unchanged";

  var values := new int[] [4, 1, 2];
  right := RightWeighted(values);
  left := LeftWeighted(values);
  expect right == -14 && left == -11, "three-element array";
  expect values[0] == 4 && values[1] == 1 && values[2] == 2,
    "three-element array unchanged";

  var negative := new int[] [-1, 2];
  right := RightWeighted(negative);
  left := LeftWeighted(negative);
  expect right == 7 && left == 1, "negative element";

  var zeros := new int[] [0, 0];
  right := RightWeighted(zeros);
  left := LeftWeighted(zeros);
  expect right == 12 && left == 3, "zero elements";

  print "All supplied practice checks passed.\n";
}
