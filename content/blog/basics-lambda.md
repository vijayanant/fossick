+++
type = "post"
date = "2017-10-02"
title = "Lambda Calculus"
+++

## Introduction
The [models of computation](https://en.wikipedia.org/wiki/Model_of_computation)
can be broadly classified into two groups - those that are based on _machine 
model_ and the λ Calculus. 

Machine models are based on the idea of a program acting on data by
modification. So a [Turing Machine](https://en.wikipedia.org/wiki/Turing_machine)
consists of a program acting on the data. There is a clear distinction between
program and data. Programs are not data and data do not contain programs ('first
order'). The machine based languages are inherently imperative.

λ-calculus is a formal system invented in the 1930s by __Alonzo Church__, in
which all computation is reduced to the basic operations of function definition
and application. There is no separation of program from data; the λ calculus
is inherently "higher order".

λ calculus is different from machine models because it is based on the 
mathematical concept of a variable (which is not at all related to the concept 
of a "variable", a misnomer for "assignables" in machine models). λ-calculus
emphasizes the use of symbolic transformation rules and does not care about the
actual machine implementation.

## Grammar
The syntax of the λ-calculus comprises just three sorts of _terms_.

* A variable `x` by itself is a term;
* The abstraction of a variable `x` from a term `t1`, written `λx.t1`, is a term;
* And the application of a term `t1` to another term `t2`, written `t1 t2`, is a term.

These ways of forming terms are summarized in the following grammar.

```
t ::=      -- Terms
  x        -- Variable
  λx. t    -- Abstraction
  t t      -- Application
```

## Abstraction and Application
Abstraction is a key feature of essentially all programming languages. Instead
of writing the same calculation over and over, we write a function that
performs the calculation generically, in terms of one or more named parameters,
and then instantiate this function as needed, providing values for the
parameters in each case.

A λ function is such an abstraction which has the form:

```
λ<variable>.<lambda term>                    ---- refer to the grammer above
```

λ-calculus embodies a kind of function definition (and application) that is the
purest possible form. In the lambda-calculus everything is a function: the
arguments accepted by functions are themselves functions and the result returned
by a function is another function.

```
(λx.∗ 3 x) 4
```

## Conventions
Here are important conventions:

* The common convention is that function application is left associative, i.e.

```
f g h = ((f g) h)
```
* Consecutive abstractions can be un-curried, i.e.

```
λx y z. t =λx.λy.λz. t
```
* The body of the abstraction extends to the right as far as possible:

```
  λx. t1 t2 = λx. (t1 t2)
```

## Boolean Definitions
```
tru = λt. λf. t;
fls = λt. λf. f;
```

``` Haskell
tru t f = t
fls t f = f
```

### tests
`test = λl. λm. λn. l m n;`

```Haskell
test pred l m = pred l m
test tru "a" "b" -- "a"
test fls "a" "b" -- "b"
```

### Reducing Test term
```
 test tru v w
 = (λl.λm.λn.l m n) tru v w         by definition
 → (λm.λn.tru m n) v w
 → (λn.tru v n) w
 → tru v w
 = (λt.λf.t) v w                    by definition
 → (λf. v) w
 → v
```

## Logical Ops
`and = λb. λc.b c fls;`

```Haskell
and1 p q = p q fls   -- if p then q   else fls
or1  p q = p tru q   -- if p then tru else q
not1 p   = p fls tru -- if p then fls else tru
```

## Pairs
```
pair = λf.λs.λb. b f s;
fst = λp. p tru;
snd = λp. p fls;
```

`Pair v w` is a function that, when applied to a boolean value _b_, applies _b_ to _v_ and _w._

```Haskell
pair f s b = b f s
fst p = p tru
snd p = p fls
```

### Reducing fst
```
  fst (pair v w)
= fst ((λf.λs.λb.b f s) v w)
→ fst ((λs.λb.b v s) w)
→ fst (λb. b v w)
= (λp.p tru) (λb.b v w)
→ (λb.b v w) tru
→ tru v w
→ v
```

## Church Numerals
* For representing numbers by lambda-terms
* A number _n_ is represented by a combinator (one, two, three, etc. below) that takes two arguments, _s_ and _z_, and applies _s_, _n_ times, to _z_.
* As with booleans and pairs, this encoding makes numbers into active entities: the number n is represented by a function that does something _n_ times — a kind of active unary numeral.

```
zero  = λs. λz. z;            -- applies s to z zero times
one   = λs. λz. s z;          -- applies s to z once
two   = λs. λz. s (s z);      -- applies s twice
three = λs. λz. s (s (s z));  -- applies s three times
etc.                          -- and so on...
```

### Successor
Remember, a Church numeral _n_ is a function that applies _s_ to _z_  (n times).

```
scc = λn. λs. λz. s (n s z); -- Successor function
```
The term _scc_ is a combinator that takes a Church numeral n and returns another Church numeral—that is, it yields a function that takes arguments _s_ and _z_ and applies _s_ repeatedly to _z_. We get the right number of applications of _s_ to _z_ by first passing _s_ and _z_ as arguments to _n_, and then explicitly applying _s_ one more time to the result.

```Haskell
scc  n s z = s (n s z)
scc' n s = s . n s
```
We can think of _successor_ function in two ways. One way, as defined above, is _applying s one more time to given number_. Another way is _to add given number _n_ to _one_._ Second approach is given below:

```
scc = λn. λs. λz. n s (s z)
```
```Haskell
scc  n s z = n s (s z)
```
Let us see if _scc one_ is actually _two_:
```
scc one
= scc (λs. λz. s z)                       -- by definition of one
= (λn. λs. λz. n s (s z)) (λs. λz. s z)   -- by definition of scc
→ (λs. λz. (λs. λz. s z) s (s z))
→ λs. λz. (λz. s z)(s z)
→ λs. λz. s (s z)
= two                                     -- by definition, s applied twice
```

### Addition
Addition of Church numerals can be performed by a term _plus_ that takes two Church numerals, _m_ and _n_, as arguments, and yields another Church numeral—i.e., a function—that accepts arguments _s_ and _z_, applies _s_ iterated _n_ times to _z_ (by passing _s_ and _z_ as arguments to _n_), and then applies _s_ iterated _m_ more times to the result:

```plus = λm. λn. λs. λz. m s (n s z);```

We can also think of addition in terms of successor (or increment) function.
```Haskell
plus m n = m incr n
```
Here, we apply _m_ times the incrementation to _n_. In other words, increment _n_, _m_ times.

Now, we can write -
```Haskell
two   = plus one one
three = plus two one
four  = add two two
```

### Multiplication
Multiplying n and m is adding together _m_ copies of _n_. Notice that, `plus m` adds _m_ to any given number. If we apply `add m` _n_ times to _zero_, we will have added _n_ copies of _m_.

```
times = λm. λn. m (plus n) zero;
```
Intuitively, having a `s.s.s. ... s` of length _m_, in order to multiply it by _n_, we should combine _n_ copies of such a chain. Or, if (m s) is a "super-successor" containing _m_ exemplars of _s_, what we need is
```Haskell
mul n m s z = n (m s) z
```
which is same as
```Haskell
mul n m = n . m
```
__Multiplication is functional composition!__

### Exponentiation
`pow n m` means _n_ raised to _m_-th power. Or, `n * n *.....* n`- multiplying _n_ by itself _m_ times.
```
pow n m
 = (mul n ( ... (mul n (mul n one))))  -- m times
 = m (mul n) one
```

We know that in the theory of sets, for any sets _A_ and _B_, the notation _B^A_ denotes the set of all functions from _A_ to _B_. Typically one applies the argument based on cardinality. Adding one element to _A_, permits to find _|B|_ more mappings, from the additional element to all of _B_. So, the number of mappings is multiplied by _|B|_, in agreement with : ___B^A+1 = B^A * B___. 
```
pow n m = m n
```
__exponentiation = inverse application__.

### isZero
To test whether a Church numeral is zero, we apply our numeral to a pair of terms _zz_ and _ss_ such that applying _ss_ to _zz_ one or more times yields _fls_, while not applying it at all yields _tru_.

Remember zero is a function that applies _s_ to _z_ zero times - `zero = λs. λz. z` or `zero  = λs. id`.

That is, we need _ss_ and _zz_ such that _zero ss zz_ is _tru_ and _fls_ for any other numeeral.

```
iszro = λm. m (λx. fls) tru;
```
### Predecessor
Predecessor function is tricky! We begin with zero, and keep counting until _n_, but storing the previous number. Then when we get _n_, the previous one is its predecessor. We use __Pairs__, defined earlier, to keep two previous numbers.

```
zz = pair zero zero
ss  = λp. pair (snd p) (plus one (snd p));
prd = λm. fst (m ss zz);
```

