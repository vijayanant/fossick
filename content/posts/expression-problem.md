+++
title       = "The Expression Problem"
date        = 2018-11-13
type        = "post"
categories  = ["Programming"]
tags        = ["fp", "Haskell", "Java", "oop"]
description = """ The expression problem is a well known problem in programming
language theory dealing with the expressiveness of a programming language.
Whether a language can solve the Expression Problem is a salient indicator of
its capacity for expression. """ 
+++

In the [previous post] ({{<ref "/posts/expressiveness.md">}}) I had put forward
(rather hastily, I must add) my thoughts on what does expressiveness mean for
programming languages. I had this feeling of forgetting something important but
couldn't pinpoint what it was. Today, while sipping a hot cup of coffee, I
remembered __the expression problem__. 

The Expression Problem is a well known problem in programming language theory
dealing with the expressiveness of a programming language. Here is [Philip
Wadler's original statement]
(http://homepages.inf.ed.ac.uk/wadler/papers/expression/expression.txt) of the
problem.

>The Expression Problem is a new name for an old problem. The goal is to define
>a datatype by cases, where one can add new cases to the datatype and new
>functions over the datatype, without recompiling existing code, and while
>retaining static type safety (e.g., no casts).
>
>--  _Philip Wadler_

He goes on to say "_Whether a language can solve the Expression Problem is a salient
indicator of its capacity for expression._"

In this post, we will see two examples, one in Java and one in Haskell to
understand the problem. 

## OO Programming
In Object Oriented Programming, it is easy to add new datatypes by defining new
(sub)classes. Since classes encapsulate the operations on the data type, no existing
code needs to be modified. However, adding new functions (operations) over the
datatype is hard. All the datatypes have to be modified and recompiled.

Below is a java version explaining the problem. If you want to add new operation
on the expressions (say, to type-check), you will have to add the new operation
to each object type (Literal and Add) forcing a recompilation of these classes.

{{< gist vijayanant  231b2470b98a92d38d54c7b982ab6503 "ExpressonProblem.java">}}

[Visitor design pattern] (https://en.wikipedia.org/wiki/Visitor_pattern) in OO
programming is a known solution to cases where new operations are added over
existing type (hierarchy). However, by using this pattern we will restrict our
ability to add new types. Adding new (element) class (to the hierarchy) forces
changes to all the visitor classes and needs recompilation.

<!--The extended Visitor pattern does offer a solution but at the cost of little-->
<!--type safety as this approach makes use of dynamic type casts.-->


## Functional Programming
In functional programming, we think of functions that operate on values of
certain types. It is easy to add new functions that operate on a datatype. To
add new case to the datatype, we will have to modify all the functions to cater
for the new case.

Typeclasses in Haskell offer a solution. But a naive use of type classes will
not work either! In the below code, the expression 

```Haskell
if True then Lit 10 else Add (Lit 5) (Lit 5)
```
does not typecheck even thought both `Lit` and `Add` are instances of `Exp`
typeclass.


{{< gist vijayanant  231b2470b98a92d38d54c7b982ab6503 "ExpressionProblem.hs">}}

In the _functional pearl_ [Data types a la carte]
(http://www.cs.ru.nl/~W.Swierstra/Publications/DataTypesALaCarte.pdf),  _Wouter
Swierstra_ proposes a solution to the expression problem. Philip Wadler himself
calls this the [best solution in Haskell]
(http://wadler.blogspot.com/2008/02/data-types-la-carte.html). 

