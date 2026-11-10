module StateTopicPractice where
import StudyState (State, get, put, modify, runState)
import StudyCheck (check, runChecks)

-- GUIDED PRACTICE: work through one numbered prompt at a time with the chat.
-- Sources: sample Q1/Q2/Q4, pp.1/2/4; State.hs, Accessing and Modifying State.
-- State s a: s is stored state; a is returned value.
-- runState :: State s a -> s -> (a,s), RESULT FIRST.
-- Worked example:
--   demo = do old <- get; put (old+4); return (old*2)
--   runState demo (3::Int) == (6,7)
-- The returned value and stored value are different outputs.

-- 1. Predict before running. Record a row for each action:
-- runState (get >>= \x -> put (x*2) >> get) (5::Int)
-- Your returned-value / state table:
-- Your final pair and whole type:

-- 2. Return the old integer counter and increment it once.
-- Use get/put/modify and do/bind/return; don't construct S or call runState.
-- Types of the bound value and final expression:
fresh :: State Int Int
fresh = undefined

-- 3. Nonempty list state: return Just its head and remove that head.
-- Empty list state: return Nothing and leave the state unchanged.
-- Use the abstract State interface as above.
-- Stored type: ... ; returned type: ...
pop :: State [a] (Maybe a)
pop = undefined

-- 4. Changed reasoning question, after implementations:
-- Infer \f x -> f <$> (put x >> get). Explain both output components
-- after running it from a matching initial state s0.
-- Your type and symbolic output pair:

checks :: IO ()
checks = runChecks
  [ check "fresh: result versus state" (runState fresh 9 == (9,10))
  , check "fresh: sequencing" (runState (fresh >> fresh) 9 == (10,11))
  , check "pop: nonempty" (runState pop "abc" == (Just 'a',"bc"))
  , check "pop: empty" (runState pop ([] :: [Bool]) == (Nothing,[]))
  ]
