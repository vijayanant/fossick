+++
type = "post"
date = "2018-02-25"
title = "Basic Lambda Calculus"
tags = [
  "fp",
  "Lambda",
  "Lambda Calculus",
]
categories = [ 
  "Programming",
  "Maths"
]
description = "Introduction to Lambda-Calculus"
+++

Lambda calculus, introduced by Alonzo Church in the 1930s, is a formal system that serves as a foundation for studying computation. Unlike machine models, such as the Turing Machine, lambda calculus operates on the principles of function definition and application as the fundamental operations of computation.

One of the key distinctions between lambda calculus and machine models is the absence of a clear separation between programs and data in lambda calculus. Instead, lambda calculus treats computation as a process of symbolic transformation using variables and functions. This unique characteristic makes lambda calculus a "higher-order" system, allowing for powerful abstraction and manipulation of functions.

Unlike machine models, which are inherently imperative, lambda calculus is rooted in mathematical concepts and emphasises symbolic transformation rules. It is not concerned with specific machine implementations, but rather focuses on the fundamental principles of computation.

By delving into lambda calculus, one gains insights into functional programming paradigms, formal reasoning, and the theoretical underpinnings of computation itself. It provides a framework for studying computation from a more abstract and theoretical standpoint, exploring the power of function abstraction and application in solving computational problems.

Overall, lambda calculus is an influential and foundational concept in computer science that has paved the way for functional programming languages and deepened our understanding of computation beyond traditional machine-based models.

## Notation, Rules, And Building Blocks 
Lambda calculus can be considered both a formal system and a notation. It doesn't have a traditional grammar or syntax like programming languages do, but it has a set of rules that define its structure and how expressions are constructed. The basic elements of lambda calculus include variables, lambda abstractions, and function applications.

- __Variables__: Variables are used to represent inputs and outputs of functions. They can be any symbol or name chosen by the programmer. For example, `x`, `y`, `z` are common variable names.

- __Lambda Abstractions__: Lambda abstractions define functions in lambda calculus. They consist of the `λ` symbol (lambda), followed by a variable, a dot (`.`), and an expression. The expression represents the body of the function. For example, `λx.x` represents a function that takes an input `x` and returns `x` itself.

- __Function Applications__: Function applications are used to apply a function to an argument. It involves writing the function followed by the argument. For example, `(λx.x) y` applies the function `λx.x` to the argument `y`.


## Nesting and Currying 
Lambda calculus expressions can be further combined and nested to create more complex functions. Multiple arguments can be represented using nested lambda abstractions or by currying, a technique where a function with multiple arguments is transformed into a sequence of functions, each taking one argument.

Suppose we have a function that takes two arguments, `add`, and we want to represent it as a sequence of functions, each taking one argument. We can do this using nested lambda abstractions. 

```
add = λx.λy.(x + y)
```

This represents a function that takes one argument `x` and returns another function that takes the second argument `y` and performs the addition. We can then apply add to an argument as follows: `(add 2) 3`, which yields the result `5`. Here, `add 2` returns a function that takes `3` as an argument and performs the addition.

Let's consider another function that takes three arguments, `multiply`, and we want to transform it into a sequence of functions, each taking one argument. 

```
multiply = λx.λy.λz.(x * y * z)
```

Here, the function multiply takes three arguments `x`, `y`, and `z`, and multiplies them together. By applying currying, we can create a sequence of functions, each taking one argument: `mult = (multiply 2)`, which gives us a function that takes one argument `x` and returns another function: `mult = λx.(λy.(λz.(x * y * z)))`. We can then apply the remaining arguments like `(mult 3) 4`, which yields the result `24`. Here, `mult 3` returns a function that takes `4` as an argument and performs the multiplication.

The syntax of lambda calculus is deliberately minimalistic, focusing on the essentials of function definition and application. It provides a foundation for reasoning about functions and computation in a purely symbolic and mathematical manner.

It's important to note that while lambda calculus has a simple syntax, its power lies in its ability to express complex computations through function composition, recursion, and other constructs built on top of its core principles.

## Evaluation Rules

In lambda calculus, variables can be categorised as either bound variables or free variables. Understanding the distinction between these two types of variables is crucial in understanding the scoping and substitution rules in lambda calculus. 

__Bound variables__ are variables that are locally defined within the scope of a lambda abstraction. They are bound by the lambda abstraction and can only be accessed or referenced within that specific scope. Bound variables are typically represented as the arguments of lambda abstractions.

For example, consider the lambda abstraction: `λx.(x y)`. Here, the variable `x` is a bound variable because it is bound by the lambda abstraction `λx.`. It can only be used within the scope of this abstraction.

__Free variables__ are variables that occur within an expression but are not bound by any surrounding lambda abstractions. They are not locally defined and can be referenced from outside the scope in which they appear. Free variables can be thought of as variables that are _"free"_ to take on different values or be substituted with other expressions.

For example, consider the expression: `(λx.(x y)) z`. In this expression, the variable `y` is a free variable because it is not bound by any surrounding lambda abstraction. It is used within the body of the lambda abstraction `λx.(x y)`, but it is not defined or bound by it. The variable `z`, on the other hand, is a bound variable as it is the argument of the outermost lambda abstraction `(λx.(x y))`.


### Beta Reduction:
The beta reduction rule allows us to apply a lambda abstraction to an argument, resulting in the substitution of the argument in the function body. The general form of beta reduction is:

```
(λx.E) M ⟶ E[x := M]
```

Here, `(λx.E)` represents a lambda abstraction, `M` represents an argument, and `E[x := M]` represents the expression `E` with all occurrences of variable `x` replaced by `M`. The arrow (`⟶`) indicates the reduction or simplification step.

Example:
Let's consider an example to illustrate beta reduction. Suppose we have the following lambda abstraction:

```
(λx.x) 5
```

To evaluate this expression, we apply the argument `5` to the function body by substituting `x` with `5`:

```
(λx.x) 5 ⟶ x[x := 5]`
```

The resulting expression is simply `5` since the variable `x` is replaced by `5`.

### Eta Conversion:
Another important evaluation rule in lambda calculus is eta conversion. It allows us to convert between equivalent lambda abstractions. The general form of eta conversion is:

```
λx.(E x) ⟶ E (if x does not occur free in E)
```

This rule states that if we have a lambda abstraction that applies its argument to another expression, and the variable `x` does not occur _free_ in that expression, we can simplify it by removing the application and using the expression directly.

Example:
Consider the following lambda abstraction:

```
λx.((λy.y) x)
```

Since `x` does not occur _free_ in `(λy.y)`, we can simplify it using eta conversion:

```
λx.((λy.y) x) ⟶ λx.(λy.y)
```

The resulting expression is `λx.(λy.y)`, where the unnecessary application has been removed.

These are the basic evaluation rules in lambda calculus. Beta reduction allows us to apply arguments to lambda abstractions, and eta conversion allows us to simplify lambda abstractions when certain conditions are met. These rules govern how lambda expressions are evaluated and simplified in lambda calculus.

## Church Encoding 
[Church encoding](https://en.wikipedia.org/wiki/Church_encoding) is a technique used in lambda calculus to represent various data types and operations as lambda expressions. It allows us to define and manipulate values within the confines of lambda calculus. 

### Church Numerals
Church numerals are a way of encoding natural numbers in lambda calculus. Each Church numeral represents a specific natural number using nested lambda abstractions. The Church numeral for zero (0) is defined as `λf.λx.x`, and the Church numeral for any positive number `n` is defined as `λf.λx.(f^n x)`, where `f^n` represents repeated function application n times.

For example:

- Church numeral for zero (0): `λf.λx.x`
- Church numeral for one (1): `λf.λx.(f x)`
- Church numeral for two (2): `λf.λx.(f (f x))`
- Church numeral for three (3): `λf.λx.(f (f (f x)))`


Using Church numerals, we can define arithmetic operations such as addition, multiplication, and predecessor functions purely in terms of lambda expressions.

### Church Booleans

Church booleans are another example of Church encoding. They represent the concept of `true` and `false` within lambda calculus. Church boolean `true` is defined as `λx.λy.x`, and Church boolean `false` is defined as `λx.λy.y`.

Using Church booleans, we can define logical operations like AND, OR, and NOT as lambda expressions.

### Church Pairs
Church pairs are used to encode ordered pairs within lambda calculus. A Church pair is defined as a lambda expression that takes two arguments and applies them to a function. For example, a Church pair can be defined as `λx.λy.λf.(f x y)`.

By using Church pairs, we can define operations such as projection to retrieve the elements of a pair and even create more complex data structures.

Church encoding allows us to represent various data types, operations, and even control flow constructs purely using lambda expressions. It demonstrates the expressive power of lambda calculus and its ability to encode fundamental concepts within a functional programming paradigm.

## Fixed-point combinators 

Fixed-point combinators are important constructs in lambda calculus that allow the definition of recursive functions. They provide a way to express self-referential computations within the framework of lambda calculus, where direct recursion is not allowed. 

In lambda calculus, direct self-reference or recursion is not possible due to the absence of named functions. Every function is defined in terms of anonymous lambda abstractions, making it challenging to define functions that refer to themselves. Fixed-point combinators offer a workaround for this limitation by providing a mechanism to express recursive computations.

### Y Combinator
The most well-known fixed-point combinator is the Y combinator. It is named after the mathematician Haskell Curry, and it allows the definition of recursive functions in lambda calculus.

The Y combinator is defined as follows:

```
Y = λf.(λx.f (x x)) (λx.f (x x))
```

Here, `f` represents the function we want to define recursively. By applying the Y combinator to `f`, we can create a self-referential computation.

To understand how the Y combinator works, let's consider an example where we want to define a factorial function using the Y combinator:

```
factorial = Y (λf.λn.if (n == 0) then 1 else n * f (n - 1))
```

Here, the lambda abstraction `(λf.λn.if (n == 0) then 1 else n * f (n - 1))` represents the factorial function definition, where `f` is the recursive call. By applying the Y combinator to this function definition, we create the recursive computation.

Apart from the Y combinator, there are other fixed-point combinators that can be used in lambda calculus, such as the Z combinator and the U combinator. Each of these combinators has different properties and can be used to express recursion in different ways.


