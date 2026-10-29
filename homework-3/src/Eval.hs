{- | An Interpreter for MiniDafny |
   ================================

In this problem, you will use the state monad to build an *interpreter* and for
our simple imperative language.

-}

module Eval where

{- |
This assignment uses the State Monad module from the standard library.

Because the MiniDafny language includes variables, we'll also use the finite
 maps from Haskell's containers library (Data.Map) to represent the store.

-}

import Control.Monad (when,guard,forM_)
import Data.Map (Map, (!?))
import qualified Data.Map as Map
import Control.Monad.State
import Test.HUnit (Test(..), (~?=), (~:), runTestTT, Counts)
import qualified Data.List as List
import Data.Maybe (fromMaybe)
import Text.Read(readMaybe)
import Syntax

{- | The MiniDafny Store |
   -----------------------

One component of the interpreter is a *store* that represents our computer's
memory or heap during the evaluation of MiniDafny prorams. We represent this store
as an associative map from variable `Name`s to `Values`:

-}

type Store = Map Name Value

{- | When the evaluator starts, the initial store will be empty,
and will be updated with any variables passed in as arguments
before evaluating a method.
-}

initialStore :: Store
initialStore = Map.empty

{- |
During computation, the store could be extended to include new mappings for
global variables. For example, if we called a method with a 
parameter "x" with the integer 3, a parameter "a" corresponding to the array
with elements from one to four, and then allocated a new local variable
"y" with the value `True`, then the store will look like this:

-}

extendedStore :: Store
extendedStore = Map.fromList [("x", IntVal 3),
                              ("a", ArrayVal [1,2,3,4]),
                              ("y", BoolVal True)]

-- | Any store can be pretty-printed and displayed concisely using 
-- | your pretty printers.


-- | We will be using the StateT transformer from the standard library
-- | to encode the type of our evaluator: it needs State to access the
-- | Store and wraps results in a Maybe to gracefully handle errors.

type Eval = StateT Store Maybe

{- |  
We can use the name of a variable to find out its value 
or update it in an assignment.

First, let's write a function that looks up values from the store. If
a variable doesn't exist, this function can error. Remember:
in regular Dafny variables must be initialized, but since we haven't implemented
those checks in MiniDafny, you can't assume here that they have already happened.
-}

index :: Name -> Eval Value
index name = do
   store <- get
   lift (store !? name)


test_index :: Test
test_index = "index tests" ~: TestList [ 
   -- The global variable "x" is unitialized (i.e. not present in the initial store)
   evalStateT (index "x") initialStore  ~?= Nothing,
   -- But there is a value for "x" available in the extended store
   evalStateT (index "x") extendedStore ~?= Just (IntVal 3)
   ]

{- | 
We can also update values in the store. If the variable name doesn't already
exist in the store, it should be added. Otherwise, it should modify
the store according to the new association.
-}

update :: Name -> Value -> Eval ()
update name value = do 
   store <- get
   put (Map.insert name value store)
   

test_update :: Test
test_update = "update tests" ~: TestList [
   -- If we assign to x, then we can find its new value
   evalStateT (update "x" (IntVal 4) >> index "x") initialStore ~?= Just (IntVal 4),
   -- If we assign to x, then we can find its new value
   evalStateT (update "x" (IntVal 5) >> index "x") extendedStore ~?= Just (IntVal 5),
   -- If we assign to y, then we can't find a value for x
   evalStateT (update "y" (IntVal 5) >> index "x") initialStore ~?= Nothing
   ]

{- |
We will also need a way to update the values of arrays in the store:
This function takes the name of a variable (that should correspond to
an ArrayVal in the store), and two values i and v (that should both be integers),
and updates the i-th location of the array with the new value v.
-}
     
updateNth :: Name -> Value -> Value -> Eval ()
updateNth name idx value = do 
   arrayValue <- index name 
   case (arrayValue, idx, value) of 
      (ArrayVal xs, IntVal i, IntVal n) -> 
         if i < 0 || i >= length xs then 
            lift Nothing
         else 
            update name (ArrayVal (take i xs ++ [n] ++ drop (i + 1) xs))
      _ -> lift Nothing


test_updateNth :: Test
test_updateNth = "updateNth tests" ~: TestList [
   -- If we update the first (0-based) element of "a", then we can find its new value
   evalStateT (updateNth "a" (IntVal 0) (IntVal 42) >> index "a") extendedStore ~?= Just (ArrayVal [42,2,3,4]),
   -- If we try to update a non-array, then we fail
   evalStateT (updateNth "x" (IntVal 0) (IntVal 42)) extendedStore ~?= Nothing,
   -- If we try to update an index out-of-bounds, then we fail
   evalStateT (updateNth "a" (IntVal 5) (IntVal 42)) extendedStore ~?= Nothing
   ]


{- | Expression Evaluator |
   ------------------------

Your next job is to finish `evalE`, an evaluator for expressions.
This function should take as input an expression and return a
store-transformer that yields a `Value`. (See the type of `evalE` below.)

Now implement the rest of `evalE`, referring to the Dafny
to understand what the unary and binary operators should do. You may wish to define
helper functions as part of your implementation. (As a style check, you
should not use `evalStateT`, `execStateT`, or `runStateT` anywhere in
your definition of `evalE` or its helper functions.)

Your expression evaluator should also be *total*.  For any input it should
produce some value. However, we don't have exceptions (or typechecking!), so
if you don't know how to interpret an expression (such as `2 + true` or an
uninitialized variable) your code should return `Nothing`.

-} 


-- | Expression evaluator
evalE :: Expression -> Eval Value
evalE (Val v)       = return v
evalE (Op2 e1 o e2) = do
  v1 <- evalE e1
  v2 <- evalE e2
  lift $ evalOp2 o v1 v2
evalE (Var (Name name)) = index name
evalE (Var (Proj name position)) = do
   arrayValue <- index name
   idx <- evalE position
   case (arrayValue, idx) of
      (ArrayVal xs, IntVal i) ->
         if i < 0 || i >= length xs then 
            lift Nothing
         else
            return (IntVal (xs !! i))
      _ -> lift Nothing
evalE (Op1 op expression) = do
   value <- evalE expression
   case (op, value) of 
      (Neg, IntVal n) -> return (IntVal (-n))
      (Not, BoolVal b) -> return (BoolVal (not b))
      (Len, ArrayVal xs) -> return (IntVal (length xs))
      _ -> lift Nothing

evalOp2 :: Bop -> Value -> Value -> Maybe Value
evalOp2 Plus   (IntVal i1) (IntVal i2) = Just $ IntVal (i1 + i2)
evalOp2 Minus  (IntVal i1) (IntVal i2) = Just $ IntVal (i1 - i2)
evalOp2 Times  (IntVal i1) (IntVal i2) = Just $ IntVal (i1 * i2)
evalOp2 Divide (IntVal _ ) (IntVal 0)  = Nothing
evalOp2 Divide (IntVal i1) (IntVal i2) = Just $ IntVal (i1 `div` i2)
evalOp2 Modulo (IntVal _) (IntVal 0) = Nothing
evalOp2 Modulo (IntVal i1) (IntVal i2) = Just $ IntVal (i1 `mod` i2)
evalOp2 Eq (IntVal i1) (IntVal i2) = Just $ BoolVal (i1 == i2)
evalOp2 Neq (IntVal i1) (IntVal i2) = Just $ BoolVal (i1 /= i2)
evalOp2 Gt (IntVal i1) (IntVal i2) = Just $ BoolVal (i1 > i2)
evalOp2 Lt (IntVal i1) (IntVal i2) = Just $ BoolVal (i1 < i2)
evalOp2 Ge (IntVal i1) (IntVal i2) = Just $ BoolVal (i1 >= i2)
evalOp2 Le (IntVal i1) (IntVal i2) = Just $ BoolVal (i1 <= i2)
evalOp2 Conj (BoolVal b1) (BoolVal b2) = Just $ BoolVal (b1 && b2)
evalOp2 Disj (BoolVal b1) (BoolVal b2) = Just $ BoolVal (b1 || b2)
evalOp2 Implies (BoolVal b1) (BoolVal b2) = Just $ BoolVal (not b1 || b2)
evalOp2 Iff (BoolVal b1) (BoolVal b2) = Just $ BoolVal (b1 == b2)
evalOp2 _ _ _ = Nothing

{- |
To test `evalE`, we can write a function that evaluates expressions with a
specified store using the `evalStateT` operation from the `State` monad
library.
-}

evaluate :: Expression -> Store -> Maybe Value
evaluate e = evalStateT (evalE e)

test_evalE :: Test
test_evalE = "expression tests" ~: TestList [
   evaluate (Var (Proj "a" (Val (IntVal 2)))) extendedStore
      ~?= Just (IntVal 3),
   evaluate (Var (Proj "a" (Val (IntVal 4)))) extendedStore
      ~?= Nothing,
   -- Negation
   evaluate (Op1 Neg (Val (IntVal 5))) initialStore
      ~?= Just (IntVal (-5)),
   -- Boolean NOT
   evaluate (Op1 Not (Val (BoolVal True))) initialStore
      ~?= Just (BoolVal False),
   -- Array length
   evaluate (Op1 Len (Var (Name "a"))) extendedStore
      ~?= Just (IntVal 4),
   -- Invalid operand: cannot negate a Boolean
   evaluate (Op1 Neg (Val (BoolVal True))) initialStore
      ~?= Nothing,
   -- Modulo
   evaluate (Op2 (Val (IntVal 7)) Modulo (Val (IntVal 3))) initialStore
      ~?= Just (IntVal 1),
   -- Division by zero
   evaluate (Op2 (Val (IntVal 7)) Divide (Val (IntVal 0))) initialStore
      ~?= Nothing,
   -- Modulo by zero
   evaluate (Op2 (Val (IntVal 7)) Modulo (Val (IntVal 0))) initialStore
      ~?= Nothing,
   -- AND: two false operands must produce false
   evaluate (Op2 (Val (BoolVal False)) Conj (Val (BoolVal False))) initialStore
      ~?= Just (BoolVal False),
   -- Invalid operand types
   evaluate (Op2 (Val (IntVal 2)) Plus (Val (BoolVal True))) initialStore
      ~?= Nothing
   ]

test_evalS :: Test
test_evalS = "statement tests" ~: TestList [
   evalStateT
      (eval (Block [
         Decl ("x", TInt) (Val (IntVal 3)),
         Assign (Name "x")
            (Op2 (Var (Name "x")) Plus (Val (IntVal 2)))
      ]) >> index "x")
      initialStore
      ~?= Just (IntVal 5)
   ]

test_if :: Test
test_if = "if tests" ~: TestList [
   execStateT
      (evalS (If (Val (BoolVal True)) setOne setTwo))
      initialStore
      ~?= Just (Map.fromList [("x", IntVal 1)]),
   execStateT
      (evalS (If (Val (BoolVal False)) setOne setTwo))
      initialStore
      ~?= Just (Map.fromList [("x", IntVal 2)]),
   execStateT
      (evalS (If (Val (IntVal 3)) setOne setTwo))
      initialStore
      ~?= Nothing
   ]
   where
      setOne = Block [Assign (Name "x") (Val (IntVal 1))]
      setTwo = Block [Assign (Name "x") (Val (IntVal 2))]

test_while :: Test
test_while = "while tests" ~: TestList [
   execStateT (evalS loop) (Map.fromList [("x", IntVal 0)])
      ~?= Just (Map.fromList [("x", IntVal 3)]),

   -- Already false: the body should never execute
   execStateT (evalS loop) (Map.fromList [("x", IntVal 5)])
      ~?= Just (Map.fromList [("x", IntVal 5)])
   ]
   where
      loop = While
         (Forall [] (Val (BoolVal True)))
         (Op2 (Var (Name "x")) Lt (Val (IntVal 3)))
         (Block [
            Assign (Name "x")
               (Op2 (Var (Name "x")) Plus (Val (IntVal 1)))
         ])

test_arrayAssign :: Test
test_arrayAssign = "array assignment tests" ~: TestList [
   evalStateT
      (evalS (Assign (Proj "a" (Val (IntVal 1)))
                    (Val (IntVal 9))) >> index "a")
      extendedStore
      ~?= Just (ArrayVal [1,9,3,4])
   ]

test_runMethod :: Test
test_runMethod = "method tests" ~: TestList [
   exec method [IntVal 3]
      ~?= Just (Map.fromList [("x", IntVal 4)]),

   -- Wrong argument count
   exec method []
      ~?= Nothing
   ]
   where
      method = Method "increment" [("x", TInt)] [] []
         (Block [
            Assign (Name "x")
               (Op2 (Var (Name "x")) Plus (Val (IntVal 1)))
         ])

{- |

Now would be a good time to add more unit test cases for your expression evaluator.
You should also make sure that your expression evaluation *always* returns a result,
even for "buggy" code. Your evaluator should never use "error" or trigger
any sort of runtime exception in Haskell.

(Complete) Statement Evaluator 
------------------------------

In this problem, you will need to implement an evaluator for
statements.  `evalS` should evaluate the given statement completely,
if possible. Note that this evaluator could go into an infinite loop
if the MiniDafny program does not terminate.  In other words, you
should *not* test this evaluator on the program `while true do ; end`.

-}

eval :: Block -> Eval ()
eval (Block ss) = mapM_ evalS ss

-- | Statement evaluator
evalS :: Statement -> Eval ()
evalS (Decl (name, typ) expression) = do
   value <- evalE expression
   update name value
evalS (Assign (Name name) expression) = do 
   value <- evalE expression
   update name value
evalS (Assign (Proj name position) expression) = do 
   idx <- evalE position
   value <- evalE expression
   updateNth name idx value
evalS (If condition thenBlock elseBlock) = do 
   condResult <- evalE condition
   case condResult of 
      (BoolVal True) -> eval thenBlock 
      (BoolVal False) -> eval elseBlock 
      _ -> lift Nothing
evalS (While invariant condition body) = do 
   condResult <- evalE condition 
   case condResult of 
      (BoolVal True) -> do 
         eval body
         evalS (While invariant condition body)
      (BoolVal False) -> return () 
      _ -> lift Nothing 
{- |

Don't forget that your evaluator should never call Haskell's "error" or
trigger a runtime exception.

The final step is to implement the evaluator for methods. For that, we simply need to
update an empty store with values for each of its parameters.

Replace the undefined in the following code to appropriately `insert`
all of the values in the `Eval` store.

-}

runMethod :: Method -> [Value] -> Eval ()
runMethod (Method f ins outs _ ss) vs = do
  guard (length ins == length vs)
  forM_ (zip ins vs) $ \((x,_),v) -> modify $ (Map.insert x v)
  eval ss

{- | 
  
To test your evaluator, you can use the following function

-}

exec :: Method -> [Value] -> Maybe Store
exec m vs = execStateT (runMethod m vs) initialStore

{- |

However, if you run into bugs, you'll probably want to write some unit tests at this point.


> -------------------------- Test cases for exec -----------------------------

You can test your evaluator using the sample programs defined in the `Syntax`
module or by using your parser on the programs in the `dafny` folder and then
executing the resulting methods.

-}
