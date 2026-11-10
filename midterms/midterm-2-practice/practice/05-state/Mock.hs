module StateTopicMock where
import StudyState (State, get, put, modify, runState)

-- TOPIC MOCK: independent work; feedback after finishing the whole file.
-- Sample Q1/Q2/Q4 styles. Untimed, no points; current exam rules unconfirmed.
-- Use the abstract State interface, not S or runState inside implementations.

-- 1. Return the swapped pair without changing stored state.
swapView :: State (a,b) (b,a)
swapView = undefined

-- 2. Return f currentState argument, without changing stored state.
projectStore :: (a -> b -> c) -> b -> State a c
projectStore = undefined

-- 3. Evaluate each expression. Report returned value FIRST, final state SECOND.
-- (a) runState (put False >> get) True
-- Answer:
-- (b) runState ((,) <$> get) 'q'
-- Answer (you may leave a function as a partially applied constructor):
-- (c) runState (pack [get, modify (. not) >> get]) id
-- Treat the state as a Boolean function. Leave functions unevaluated if needed.
-- Answer:

-- Supplied for 3(c), like the sample's function-valued monadic collector.
pack :: Monad m => [m (a -> b)] -> m [a -> b]
pack [] = return []
pack (u:us) = do
  f <- u
  fs <- pack us
  return (f:fs)

-- Assistance used (fill after completing the mock):
