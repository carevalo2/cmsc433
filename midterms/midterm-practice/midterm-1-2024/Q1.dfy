
method g1(a: array<int>) returns (out:int) {
    out := 5;
    var n := a.Length - 1;

    // foldr (-) 5 [1, 2, 3]
    // (1 - (2 - (3 - 5)))
    // (1 - (2 - (-2))
    // (1 - (4))
    // (-3)
    while n >= 0 
        invariant -1 <= n < a.Length
    {
        out := a[n] - out;
        n := n - 1;
    }
}

method g2(a: array<int>) returns (out : int) { 
    out := 5;
    var n := 0;

    // foldl (-) 5 [1, 2, 3]
    // (((5 - 1) - 2) - 3)
    // ((4 - 2) - 3)
    // -1
    while n < a.Length 
        invariant 0 <= n <= a.Length
    {
        out := out - a[n];
        n := n + 1;
    }
}