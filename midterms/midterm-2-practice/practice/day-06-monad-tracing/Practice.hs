module Day06 where

import StudyCheck (check, runChecks)
import StudyState

-- Day 6. See the practice guide for the GHCi command and lecture links.
-- Work one prompt at a time. Predict and explain before checking.

-- Use Prelude's sequence for today's predictions. It uses the same collection
-- pattern you implemented on Day 5. Worked: binding from [2,5] and adding 1
-- yields [3,6].

-- 6.1 OUTPUT AND TYPE: sequence [Just 'c', Nothing, Just 'z']
-- Explain what happens at the middle action.
-- Your type, output, and reason:

-- 6.2 OUTPUT: sequence [[1,2],[10,20,30 :: Int]]
-- Then compare sequence ([] :: [[Int]]) with sequence ([[]] :: [[Int]]).
-- Write the choices in order and explain the two empty cases.
-- Your outputs and reason:

-- 6.3 IMPLEMENT: Express gatherActions using mapM. First fill in the type of
-- the function argument of mapM after matching its list argument to [m a].
gatherViaMapM :: Monad m => [m a] -> m [a]
gatherViaMapM = undefined

-- 6.4 OUTPUT: runState (sequence [get, put 6 >> get, get]) (2 :: Int)
-- Compare that trace with runState (sequence [get, get, get]) (2 :: Int).
-- Your output pairs and the reason they differ:

-- 6.5 TYPE AND OUTPUT: sequence [Just Nothing, Just (Just 'a')]
-- Compare it with sequence [Nothing, Just (Just 'a')]. Identify the monad
-- doing the sequencing and explain which level of Maybe controls failure.
-- Your types, outputs, and reason:

checkMapM :: IO ()
checkMapM = runChecks
  [ check "gather a list of choices" (gatherViaMapM [[True,False],[False]] == [[True,False],[False,False]])
  , check "use updated state" (runState (gatherViaMapM [get, put 'a' >> get]) 'b' == ("ba",'a'))
  ]
