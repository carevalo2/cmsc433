module StatePractice where

import StudyState (State, runState, get, put, modify)
import StudyCheck (check, runChecks)

-- 5.2. Return the swapped pair and leave the stored pair unchanged:
-- runState swapStore (x,y) == ((y,x),(x,y)).
swapStore :: State (a,b) (b,a)
swapStore = undefined

-- Return f currentState argument; do not change the state.
projectStore :: (a -> b -> c) -> b -> State a c
projectStore = undefined

-- 5.3. Return the current integer label, then increment the counter once.
fresh :: State Int Int
fresh = undefined

-- Collect n successive fresh labels; n <= 0 leaves state unchanged.
-- Use recursion and fresh. No replicateM/mapM/sequence helpers.
takeLabels :: Int -> State Int [Int]
takeLabels = undefined

-- Empty list -> Nothing and unchanged state.
-- Nonempty list -> Just its head and remove exactly that head from state.
pop :: State [a] (Maybe a)
pop = undefined

data Tree a = Leaf a | Branch (Tree a) (Tree a) deriving (Eq,Show)

-- Attach fresh labels to leaves, visiting left to right. Increment once per leaf.
labelTree :: Tree a -> State Int (Tree (a,Int))
labelTree = undefined

-- 5.5. If old is current state, return old and store (old . not).
snapshotFunction :: State (Bool -> Bool) (Bool -> Bool)
snapshotFunction = undefined

checks :: IO ()
checks = runChecks
  [ check "swapStore: return vs store" (runState swapStore ('q',False) == ((False,'q'),('q',False)))
  , check "projectStore: apply both arguments" (runState (projectStore (,) 'z') True == ((True,'z'),True))
  , check "fresh: old label, new state" (runState fresh 12 == (12,13))
  , check "takeLabels: three" (runState (takeLabels 3) 7 == ([7,8,9],10))
  , check "takeLabels: zero" (runState (takeLabels 0) 7 == ([],7))
  , check "pop: nonempty" (runState pop "abc" == (Just 'a',"bc"))
  , check "pop: empty" (runState pop ([] :: [Bool]) == (Nothing,[]))
  , check "labelTree: ordered leaves" (runState (labelTree (Branch (Leaf 'x') (Branch (Leaf 'y') (Leaf 'z')))) 2 == (Branch (Leaf ('x',2)) (Branch (Leaf ('y',3)) (Leaf ('z',4))),5))
  , check "snapshotFunction: distinguish outputs" (let (old,new) = runState snapshotFunction id in (old False,old True,new False,new True) == (False,True,True,False))
  ]
