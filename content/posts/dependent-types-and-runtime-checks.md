+++
title       = "Dependent Types To Eliminate Runtime Checks"
date        = 2018-10-26
type        = "post"
categories  = ["Types", "Programming"]
tags        = ["Haskell", "Dependent Types"]
description = ""
draft       = false
+++
### Give Me The Money!

Let us start with an example. We will define a simple type for representing
money and a function to add money.

```Haskell
data Money = Money Rational
```

Now we can add them together as 

```Haskell
add :: Money -> Money -> Money
add (Money m1) (Money m2)  = Money (m1 + m2)

money1 = Money (50 % 100)
money2 = Money (25 % 100)

total = add money1 money2
```

### Everything OK There?

There is something we have missed here. The currency. Money is represented in
some currency (like Indian Rupee or US Dollar) and we cannot add money in
different currencies. 

Lets include currency information in our `Money` type. A simple approach is to
keep string representing the currency ("INR", "USD", etc.) along with the amount.

```Haskell
data Money = Money String Rational

add:: Money -> Money -> Money
```

###  Houston, We've Got a Problem
Here is the concern. We now have to check if the two money arguments to add are
of same currency. Well, we can do that by comparing the two strings representing
the currency. Or by pattern matching for all possible currency! What do we do if
they don't match? Now we are having to deal with error scenarios. A simple
addition now has to deal with error cases. If we decide to indicate an error
using `Maybe Money` or `Either Error Money` as return type, the calling function
also has to deal with such a value appropriately (may be by returning an error).

### Independence? Freedom? What?
Using dependent types we can avoid the runtime check by making it possible for
the compiler to do that check for us. 

> Dependent Types are advanced concepts. But we don't have to know all the
> theory and concepts behind it as many good people have made it so simple
> for us to use it. But I recommend you all to read and know more to use them
> in more interesting ways.

```Haskell
{-# LANGUAGE KindSignatures, DataKinds #-}

import GHC.TypeLits (Symbol)
import Data.Ratio ((%))

data Money (currency :: Symbol) = Money Rational

fiftyPaise :: Money "INR"
fiftyPaise = Money (50 % 100)

twoDollars :: Money "USD"
twoDollars = Money 2

add :: Money c -> Money c -> Money c
add (Money m1) (Money m2) = Money (m1 + m2)
```

```Haskell
λ> :t add fiftyPaise fiftyPaise
add fiftyPaise fiftyPaise :: Money "INR"

λ> :t add fiftyPaise twoDollars

<interactive>:1:16: error:
    • Couldn't match type ‘"USD"’ with ‘"INR"’
      Expected type: Money "INR"
        Actual type: Money "USD"
    • In the second argument of ‘add’, namely ‘twoDollars’
      In the expression: add fiftyPaise twoDollars
```

We use language extensions in GHC for using dependent types. I will try to
explain their usage in simple terms.

### Be Kind To Others

Notice the type of `fiftyPaise` -

```Haskell 
fiftyPaise :: Money "INR"
```

`Money` is a type constructor and only accepts other types as parameters (`Maybe
Int`, `[Int]` etc.). But, `"INR"` seems like a String value! How is this
possible? 

Firstly, `"INR"` in `Money "INR"` is not a value but a type with kind `Symbol`.
You can see that in the data definition of Money. `currency` type parameter is
of kind `Symbol`. 

```Haskell
data Money (currency :: Symbol) = Money Rational
```

`Symbol` is a convenient Kind provided by GHC in the `GHC.TypeLits` module which
is the kind for type-level strings. It lets us use string literals like "INR" as
a type.

>You know that we can manually specify a variable's type. Similarly, we can also
>manually specify a type variable's kind using the __KindSignatures__ extension.


## Congratulations! You have Been Promoted

So, Ok, KindSignatures extension lets me specify that `currency` has kind
`Symbol`, but how does `"INR"` and `"USD"` become types of of kind `Symbol`?  

```Haskell
fiftyPaise :: Money "INR"
fiftyPaise = Money (50 % 100)

twoDollars :: Money "USD"
twoDollars = Money 2
```

This is all thanks to another GHC extension we have used - __DataKinds__. When
this extension is enabled, the type constructors are promoted to Kinds and value
constructors are promoted to type constructors.

In our case, the kind `Symbol` is already provided by GHC. All we need is for
GHC to promote and recognize "`INR`" as type.

```Haskell
λ> :k Money "INR"

<interactive>:1:7: error:
    Illegal type: ‘"INR"’ Perhaps you intended to use DataKinds

λ> :set -XDataKinds
λ> :k Money "INR"
Money "INR" :: *


λ> :k Money Int

<interactive>:1:7: error:
    • Expected kind ‘Symbol’, but ‘Int’ has kind ‘*’
    • In the first argument of ‘Money’, namely ‘Int’
      In the type ‘Money Int’
```

> The promoted types, `"INR"` and `"USD"` in the above example, have no
> inhabitants.

>Also, promoted types are prefixed with a quote (`'"INR"` and `'"USD"`) but they
>can almost always be ignored as the context of their usage makes it clear which
>one we meant - the type "INR" or the string value "INR".

## The Beginning
There is much more to depended types than what we have seen here. This is to
show readers that dependent types can be useful in day-to-day programming as
well.
