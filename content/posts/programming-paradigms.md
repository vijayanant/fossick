+++
type = "post"
title = "Thinking in Imperative, Object Oriented and Functional way"
date = "2017-09-15T14:42:26+05:30"
keywords = ["programming", "Imperative", "OOP", "Object Oriented", "Functional" ]
draft = false
description = "programming paradigms stem from different concepts about how the world works. They represent different opinions about how to best model the world while we are writing programs."
+++

Complexity is the root cause of majority of software problems. Unreliable softwares are known to be notoriously complex. A complex system is hard to understand and reason about. The harder a system is to understand the more likely we are to introduce more complexity.  Complex code base is not only harder to test but testing is that much less effective.

## Programming Paradigms

Different programming styles tries to deal with the complexity in their own way. The following sections discusses some common paradigms in general purpose programming.

The examples given are representative of the paradigm and are simple. They are not representitives of solutions to handling complexity. Complexities that arise due to  state update and control flow are usually visible in fairly large code base.

## The Imperative Style

In [imperative programming](https://en.wikipedia.org/wiki/Imperative_programming), the programs consists of an explicit sequence of instructions/commands that update shared state. Control flow is explicit: commands detail how the computation takes place, step by step. Each step affects the global state of the system.

Since each step can essentially updates the (global, shared) state, any part of the program can update the state. It is up to the programmer to keep track of how and where the state is being updated and tailor the control flow such that the only desired updates happen and in a perticular order. As the number possible program state increases so does the number of places the state is updated. It becomes harder to keep the program in consistent state. It will soon become a complex cogwheel system with too many moving parts.

```C
result = []
i = 0
start:
  numEmployees = length(employees)
  if i >= numEmployees goto finished
  e = employees[i]
  rating = e.rating
  if rating <= 7 goto nextOne
  upperCaseName = toUpper(e.name)
  addToList(result, upperCaseName)
nextOne:
  i = i + 1
  goto start
finished:
  return sort(result)
```

Use of procedures and structured programming (sometimes considered a separate paradigm) is a way to contain complexity.

```C
result = [];
for (i = 0; i < length(employees); i++) {
  e = employees[i];
  if(e.rating > 7) {
    addToList(result,toUpper(e.name));
  }
}
return sort(result);
```

## The Object Oriented Style

[Object Oriented Programming](https://en.wikipedia.org/wiki/Object-oriented_programming) is based on passing messages between objects. Objects respond to messages by performing appropriate operations. These operations are generally called methods.

By encapsulating data and operations that can be performed on that data, into a single entity (object), we have (in  a way) segregated moving parts of the system in to smaller groups. There are still moving parts, a lot of them, but they are grouped in a way which allows programmer to handle each group (class of objects)  in isolation.

In pure OO style, the control structures like the conditionals and loops become messages themselves.

```Smalltalk
result := List new.
employees each: [:e |
  e rating greaterThan: 7 ifTrue: [result add (e name upper)]]
result sort.
^result
```

Notice that, even though we can now deal with state updates in isolation, objects need to collaborate among themselves to be useful. That happens by the way of message passing. As the number of objects (classes of objects) increases the communication between them also increases and needs to be dealt with carefully.

## The Functional Style

[Functional Programming](https://en.wikipedia.org/wiki/Functional_programming) is based on the mathematical concept of a function. In mathematics there is no notion of updating a variable/state. Functional programming, thus, removes the whole 'update the shared state' business. Functions are the building blocks in FP. Functions take arguments and compute a result based on the inputs provided. Control flow is expressed by combining functions ([function composition](https://en.wikipedia.org/wiki/Function_composition)).

```Haskell
sort ( map (toUpperCase . name) ( filter (\e -> rating e > 7) employees))
```

## Conclusion
In essence, programming paradigms stem from different concepts about how the world works. They represent different opinions about how to best model the world while we are writing programs.

The imperative models are based on how computers works. We think in terms of variables that hold values and procedures that manipulate the values held in those variable.

The object-oriented paradigm models everything as an object. These objects can then interact with each other and thereby update their internal state when something in the system changes. This corresponds to how we often conceptualize the world.

The functional programming paradigm takes a different approach. The behavior of the system is modelled using pure functions and these are strictly separated from the actual data within the system, which is modelled with immutable values. This is based on the mathematical perspective that a value itself cannot change and all changes in the system are actually the application of a function.
