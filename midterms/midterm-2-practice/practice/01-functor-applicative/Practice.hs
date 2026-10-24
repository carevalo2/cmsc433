module Practice where

-- Work through one exercise at a time. Replace undefined when instructed.
-- The file loads before you finish, but evaluating a hole raises an error.

-- SECTION 1: Track the whole type
-- <$> is fmap. It changes the produced value and preserves the context.

-- | An example of transforming a successful result.
exampleEven :: Maybe Bool
exampleEven = even <$> Just (8 :: Int)

-- Exercise 1: Before evaluating, predict each value AND its whole type.
-- Record your predictions in these comments, then check in GHCi.
-- Use :t followed by the expression to check its type.
--
-- a. show <$> Just (12 :: Int)
--    Value: Just "12"
--    Type: Maybe String
-- b. even <$> (Nothing :: Maybe Int)
--    Value: Nothing
--    Type: Maybe Bool
-- c. length <$> Just "haskell"
--    Value: Just 7
--    Type: Maybe Int

-- Exercise 2: Use <$> to implement this without pattern matching.
-- | Converts an available integer to text.
describeNumber :: Maybe Int -> Maybe String
describeNumber mi = show <$> mi

-- SECTION 2: Functions inside Maybe
-- <*> takes a function in the context and an argument in the context.

-- | A partially applied function inside Maybe; use :t to inspect it.
exampleWaiting :: Maybe (Int -> Int)
exampleWaiting = (-) <$> Just 10

-- | Supplies the second argument to the function produced above.
exampleApplied :: Maybe Int
exampleApplied = exampleWaiting <*> Just 3

-- Exercise 3: Predict each result before evaluating it.
-- a. (-) <$> Just (3 :: Int) <*> Just 10
--    Prediction:
-- b. (*) <$> Just (6 :: Int) <*> Nothing
--    Prediction:
-- c. (Nothing :: Maybe (Int -> Int)) <*> Just 4
--    Prediction:
-- d. Why can GHCi inspect exampleWaiting's type but not print its value?
--    Explanation:

-- Exercise 4: Combine two possible numbers using <$> and <*>.
-- Do not use pattern matching or do notation.
-- | Multiplies two available numbers.
multiplyMaybe :: Maybe Int -> Maybe Int -> Maybe Int
multiplyMaybe = undefined

-- SECTION 3: Constructors are functions too

-- | A student's name paired with a score.
data Score = Score String Int
  deriving (Eq, Show)

-- Exercise 5: Inspect :t Score before starting.
-- Use <$> and <*> without pattern matching or do notation.
-- | Builds a score when both pieces of information are available.
makeScore :: Maybe String -> Maybe Int -> Maybe Score
makeScore = undefined

-- SECTION 4: Connect this to HW3's parsers (written reasoning only)
-- Suppose these declarations are available:
--
-- numberP :: Parser Int
-- show    :: Int -> String
-- IntVal  :: Int -> Value
--
-- Exercise 6: Give the WHOLE expression's type. Keep the Parser context.
-- a. show <$> numberP
--    Type:
-- b. IntVal <$> numberP
--    Type:
-- c. (+) <$> numberP <*> numberP
--    Type:
-- d. After the first numberP, what input does the second numberP receive?
--    Explanation:

-- SECTION 5: Checks for your implementations
-- Run these after completing the corresponding exercise.

-- | Checks both successful and absent inputs for describeNumber.
checkDescribeNumber :: Bool
checkDescribeNumber = and
  [ describeNumber (Just 12) == Just "12"
  , describeNumber Nothing == Nothing
  ]

-- | Checks multiplication, including missing values on either side.
checkMultiplyMaybe :: Bool
checkMultiplyMaybe = and
  [ multiplyMaybe (Just 6) (Just 4) == Just 24
  , multiplyMaybe Nothing (Just 4) == Nothing
  , multiplyMaybe (Just 6) Nothing == Nothing
  , multiplyMaybe Nothing Nothing == Nothing
  ]

-- | Checks construction and propagation of missing information.
checkMakeScore :: Bool
checkMakeScore = and
  [ makeScore (Just "Sam") (Just 90) == Just (Score "Sam" 90)
  , makeScore Nothing (Just 90) == Nothing
  , makeScore (Just "Sam") Nothing == Nothing
  , makeScore Nothing Nothing == Nothing
  ]
