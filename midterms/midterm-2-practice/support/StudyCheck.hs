module StudyCheck (check, runChecks) where

import Control.Exception (SomeException, displayException, evaluate, try)

check :: String -> Bool -> (String,Bool)
check = (,)

-- Unfinished functions are reported individually rather than stopping a lesson.
-- These finite examples are feedback, not proofs or official grading tests.
runChecks :: [(String,Bool)] -> IO ()
runChecks = mapM_ $ \(name,condition) -> do
  outcome <- try (evaluate condition) :: IO (Either SomeException Bool)
  case outcome of
    Right True -> putStrLn ("PASS: " ++ name)
    Right False -> putStrLn ("CHECK AGAIN: " ++ name)
    Left err -> putStrLn ("UNFINISHED/ERROR: " ++ name ++ " -- " ++ takeWhile (/= '\n') (displayException err))
