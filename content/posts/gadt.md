+++
title       = "GADTs To Eliminate Runtime Checks"
date        = 2016-10-15
type        = "post"
categories  = ["Programming", "Types"]
tags        = ["Haskell", "GADTs"]
description = "Generalized algebraic data types (GADTs) generalizes ordinary algebraic data types by permitting value constructors to return specific types. GADTs are used for ensuring program correctness and in generic programming. This article is specific to Haskell programming language. In Haskell GADTs are implemented as a language extension. The article describes these use cases with small programs."
draft       = false
+++

Generalized Algebraic Data Types (GADTs) generalizes ordinary algebraic data
types by permitting value constructors to return specific types. GADTs are used
for ensuring program correctness and in generic programming. This article is
specific to Haskell programming language. In Haskell GADTs are implemented as
a language extension. The article describes these use cases with small programs.

# Introduction

Type system help programmers ensure that the software they write behave
correctly. They detect errors and also serve as documentation. A good type
system allow abstracting domain specific concepts. Haskell’s much appreciated
_Algebraic Data Type (ADT)_ though powerful, is still lacking in few aspects.
GADTs fill that gap. 

This article explains GADTs with simple examples.

## Algebraic Data Types (ADTs)
ADTs are composite types, i.e., types formed by combining other types. Depending
on how the types are combined, we can have either a _sum_ type or a _product_ type.

```Haskell
data Point = Pt Int Int
data Expr a = Number Integer | Boolean Bool
```

In the example above `Point` and `Expr` are called _type constructors_ and `Pt`,
`Number`, and `Boolean` are called _value constructors_. If a type has more than
one value constructor, they are called alternatives: one can use any of these
alternatives to create a value of that type.

```Haskell
ghci> let a = Number 10
ghci> let b = Boolean True

ghci> :t a
a :: Expr

ghci> :t b
b :: Expr
```

Notice that the type of both `a` and `b` is `Expr.` This is because of the type of the
value constructors.

```Haskell
ghci> :t Number
Number :: Integer -> Expr

ghci> :t Boolean
Boolean :: Bool -> Expr
```

To showcase how this complicates code, let us extend our type a bit and also add
a expression evaluator.

```Haskell
data Expr = Number Int
          | Succ Expr
          | IsZero Expr
          | If Expr Expr Expr

data Value = IntVal Int | BoolVal Bool

eval :: Expr -> Value
eval (Number i) = IntVal i
eval (Succ e) = case eval e of
        IntVal i -> IntVal (i+1)
eval (IsZero e) = case eval e of
        IntVal i -> BoolVal (i==0)
eval (If b e1 e2) = case eval b of
        BoolVal True  -> eval e1
        BoolVal False -> eval e2
```

If you notice carefully, this allows for some invalid expressions to type check
successfully.

```Haskell
expr1 = Succ (Number 1)          -- valid and type checks
expr2 = Succ (IsZero (Number 1)) -- invalid but type checks
```

Also, notice how our `eval` function is _partially_ implemented. We do not know
what to evaluate a expression `Succ (IsZero (Number 1))` to. We could allow the
function to indicate error by using a `Maybe` or `Either` type, but that
complicates the `eval` function further as we recursively call `eval`. Try it
out for fun.

## Generalised ADTs
The idea behind GADTs is to allow arbitrary return types for value constructors.
They _generalize_ ordinary data types. GADTs are provided in GHC as a language
extension. We can enable this feature using the `LANGUAGE` pragma. It provides a
new syntax for defining data types. We specify type for each value constructor.
We can now redefine our `Expr` type like below:

```Haskell
{-# LANGUAGE GADTs #-}

data Expr a where
  Number :: Int -> Expr Int
  Succ   :: Expr Int -> Expr Int
  IsZero :: Expr Int -> Expr Bool
  If     :: ExprBool->Expra->Expra->Expra
```

Notice that return type for value constructor can differ. This allows our
program to be more strict. The value constructor `Succ`, for example, expects a
`Expr Int.` The compiler can now reject code if you provide `Expr Bool` or anything
else.

```Haskell
ghci> :t Succ (Number 10)
Succ (Number 10) :: Expr Int

ghci> :t Succ (IsZero (Number 0))
<interactive>:1:7: error:
     Couldn’t match type Bool with Int
      Expected type: Expr Int
        Actual type: Expr Bool
     In the first argument of Succ, namely (IsZero (Number 0))
      In the expression: Succ (IsZero (Number 0))
```

Now, with the refined `Expr` type, the evaluation of expression become simple. The
expression evaluator need not worry about cases where the type do not match
(ill-typed expression we saw earlier). The new evaluator is easy to write and
read.

```Haskell
eval :: Expr a -> a
eval (Number i) = i
eval (Succ e) = 1 + eval e
eval (IsZero e) = 0 == eval e
eval (If b e1 e2) = if eval b then eval e1 else eval e2
```

This version of `eval` is complete unlike the previously implemented one. If we
are evaluating an expression, the expression is guaranteed to be valid and no
failure cases are possible. Compile time guarantee is always better than a
runtime check.
