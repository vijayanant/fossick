+++
type = "post"
date = "2017-09-19"
title = "Types and Programming Languages"
tags = ["programming", "types"]
draft = true
+++

In the previous article I wrote about different styles of programming and how
each style influences how we model our application. In this article I will write
about dynamic and statically typed languages. 


<!--#### Type-->
<!--At an abstract level, a type is a constraint which defines the set of valid -->
<!--values which conform to it. In programming languages, types are typically used-->
<!--to both classify values, and to determine the valid operations for a given type.-->

#### Type Systems
_Type system_ is a collections of rules for checking the _consistency_ of
programs. The fundamental purpose of a type system is to prevent the occurrence
of _execution errors_ during the running of a program. 

Programming languages can be grouped in to two distinct categories - 

  * __Untyped__ - no checks are done to validate the consistency of the
  program. Examples: Assembly languages
  * __Typed__ - languages various checks are either during the compile time and/or at
  run-time for consistency

Typed languages are further classified into 

  * _Statically_ typed languages
  * _Dynamically_ typed languages

There are other terms that are associated with type systems - strongly typed,
weakly typed, safe, sound and duck typing
