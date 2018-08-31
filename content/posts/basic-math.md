+++
type = "post"
date = "2017-11-04"
title = "Notes on Sets, Relations, and Functions"
tags = [ 
      "Maths",
      "Sets",
      "Relations",
      "Functions",
      "Ordered Sets"
]
categories = [ "Maths" ]
description = "Basic maths - Sets, Relations, and Functions"
+++
### Standard notation for sets
 * curly braces for listing the elements of a set explicitly (`{. . .}`) 
 * showing how to construct one set from another by “comprehension” (`{x ∈ S | . . .}`)
 * `∅` for the empty set, and `S \ T` for the set difference of `S` and `T` (the set of elements of `S` that are not also elements of `T` )
 * The _size_ of a set `S` is written `|S|`
 * The _powerset_ of `S`, i.e., the set of all the subsets of S, is written `P(S)`

   
### Countable Set 
The set `{0, 1, 2, 3, 4, 5, . . .}` of natural numbers is denoted by the symbol `N`. A set is said to be _countable_ if its elements can be placed in one-to-one correspondence with the natural numbers.

### n-place relation  
An n-place relation on a collection of sets S1, S2, . . . , Sn is a set `R ⊆ S1 × S2 ×...× Sn` of tuples of elements from `S1` through `Sn`. We say that the elements `s1 ∈ S1` through `sn ∈ Sn` are related by `R` if `(s1,...,sn)` is an element of `R`.

### one-place relation  
A one-place relation on a set `S` is called a predicate on `S.` We say that `P` is true of an element `s ∈ S` if `s ∈ P`. To emphasize this intuition, we often write `P(s)` instead of `s ∈ P`, regarding `P` as a function mapping elements of `S` to truth values.  

### two-place relation  
A two-place relation `R` on sets `S` and `T` is called a binary relation. We often write `s R t` instead of `(s,t) ∈ R`. When `S` and `T` are the same set `U`, we say that `R` is a binary relation on `U`.  

### MixFix syntax
For readability, three or more place relations are often written using a "mixfix" concrete syntax, where the elements in the relation are separated by a sequence of symbols that jointly constitute the name of the relation. For example, we write `Γ ⊢ s:T` to mean the triple `(Γ, s, T)`

### Domain & Co-domain
The domain of a relation `R` on sets `S` and `T`, written `dom(R),` is the set of elements `s ∈ S` such that `(s,t) ∈ R` for some `t`. The codomain or range of `R`, written `range(R)`, is the set of elements `t ∈ T` such that `(s,t) ∈ R` for some `s`.
  
### Relation
A relation `R` on sets `S` and `T` is called a partial function from `S` to `T` if, whenever `(s,t1) ∈ R` and `(s,t2) ∈ R`, we have `t1 = t2`. If, in addition, `dom(R) = S`, then `R` is called a total function (or just function) from `S` to `T`.  
### Partial Function
A partial function `R` from `S` to `T` is said to be defined on an argument `s ∈ S` if `s ∈ dom(R)`, and undefined otherwise. We write `f(x) ↑`, or `f (x) =↑`, to mean "f is undefined on x," and `f (x)↓` to mean "f is defined on x."

### Predicate
Suppose `R` is a binary relation on a set `S` and `P` is a predicate on `S`. We say that `P` is preserved by `R` if whenever we have `s R s'` and `P(s)`, we also have `P(s')`.  

## Ordered Sets
### Reflexive Relation
A binary relation R on a set S is reflexive if R relates every element of S to itself—that is, s R s (or (s,s) ∈ R) for all s ∈ S. 

### Symmetric Relation
A binary relation R is symmetric if s R t implies t R s, for all s and t in S. 

### Transitive Relation
A binary relation R is transitive if s R t and t R u together imply s R u. R is antisymmetric if s R t and t R s together imply that s = t.  

### Preorder
A reflexive and transitive relation R on a set S is called a preorder on S.

### Partial Order
A preorder (on a set S) that is also antisymmetric is called a partial order on S. 

### Total Order
A partial order ≤ is called a total order if it also has the property that, for each s and t in S, either s ≤ t or t ≤ s.  

### Join and Meet
Suppose that ≤ is a partial order on a set S and s and t are elements of S. An element j ∈ S is said to be a join (or __least upper bound__) of s and t if

1. s ≤ j and t ≤ j, and
2. for any element k ∈ S with s ≤ k and t ≤ k, we have j ≤ k.

Similarly, an element m ∈ S is said to be a meet (or __greatest lower bound__) of s and t if

1. m ≤ s and m ≤ t, and
2. for any element n ∈ S with n ≤ s and n ≤ t, we have n ≤ m.

### Equivalence 
A reflexive, transitive, and symmetric relation on a set S is called an equivalence on S.  

### Reflexive Closure
Suppose R is a binary relation on a set S. The reflexive closure of R is the smallest reflexive relation R′ that contains R. (“Smallest” in the sense that if R′′ is some other reflexive relation that contains all the pairs in R, then we have R′ ⊆ R′′.) 

### Transitive Closure 
Similarly, the transitive closure of R is the smallest transitive relation R′ that contains R. The transitive closure of R is often written R+. The reflexive and transitive closure of R is the smallest reflexive and transitive relation that contains R. It is often written R∗. 
