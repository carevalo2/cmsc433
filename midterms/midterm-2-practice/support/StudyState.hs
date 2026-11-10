module StudyState
  ( State(..), get, put, modify, evalState, execState ) where

-- Supplied infrastructure, matching the sample's (result, state) convention.
-- This is an executable teaching implementation, not a learner exercise.
newtype State s a = S { runState :: s -> (a,s) }

instance Functor (State s) where
  fmap f (S action) = S $ \s ->
    let (x,s') = action s in (f x,s')

instance Applicative (State s) where
  pure x = S $ \s -> (x,s)
  S fun <*> S arg = S $ \s ->
    let (f,s') = fun s
        (x,s'') = arg s'
    in (f x,s'')

instance Monad (State s) where
  S action >>= next = S $ \s ->
    let (x,s') = action s in runState (next x) s'

get :: State s s
get = S $ \s -> (s,s)

put :: s -> State s ()
put s = S $ \_ -> ((),s)

modify :: (s -> s) -> State s ()
modify f = S $ \s -> ((),f s)

evalState :: State s a -> s -> a
evalState action = fst . runState action

execState :: State s a -> s -> s
execState action = snd . runState action
