+++
type = "post"
title = "Understanding Monads Using Function Composition"
date =  "2016-05-20 20:20:45"
tags =  ["functional", "programming", "monads", "haskell", "composition"]
categories = ["Programming", "Haskell"]
+++

Today I am going to commit a crime - I am about to write one more blog relating to Monads!

## Why?

Even though I could use `monads` for a while now, I never got around to understanding how they are __composing functions__ and why couldn't we use the `(.)` function to compose?

I wanted to understand Monads from composition view point.

## Let's Dig In
Lets start with simple function composition 

```Haskell
f:: a -> b
g:: b -> c
```

We all know the how to compose them - 

```Haskell
h = g.f
```

`h` has the type `h:: a -> c`

Lets look at the type of `(.)` function

```Haskell
(.) :: (b -> c) -> (a -> b) -> a -> c
```
    
The `(.)` function takes  two functions (`g` and `f` for example) and returns a new function of the type `h:: a -> c`

In essence `(g.f) x ` is same as `g(f x)`

## Let Us Add Some Complexity

Let us say we have two more function 

```Haskell
f' :: a -> (b, String)
g' :: b -> (c, String)
```
    
If we try to compose them using the `(.)` function as `g' . f'` we will notice that the types don't match up. The return type of `f'` is a two-tuple `(b, String)` where as function `g'` is expecting `b`.

For it to work, we need to modify our function `g'` to accept `(b, String)`

```Haskell
g'' :: (b, String) -> (c, String)
```

Now we can compose them as `g'' . f'`

## MagicBox

__*What if*__ we could magically transform (or `lift`) our function `g'` to `g''` 

Lets say we have such a function, and for the fun of it, call it `magicBox`. Now we can compose `f'` and `g'` 

```Haskell
(magicBox g') . f'
```


Lets build a magic box ourselves. It is not that hard really.

```Haskell
magicBox:: (b -> (c, String)) -> (b, String) -> (c, String)
```
    
Our `magicBox` takes a function of type `g'` and returns a function of type `g''` 

```Haskell
magicBox func (b, xs) = func b
```
    
We ignore the String parameter. 

## Enter the Bind operator

If you have ever used  `Monad` you already know `>>=` function.
Lets take a look at the `>>=` function

```Haskell
(>>=) :: Monad m => m a -> (a -> m b) -> m b
```

You might also know the flipped version `=<<`

```Haskell
(=<<) :: Monad m => (a -> m b) -> m a -> m b
```
    

If you look closely, the `=<<` resembles our `magicBox`

```Haskell
(=<<)    :: Monad m => (a -> m b)            -> m a         -> m b
magicBox ::            (b -> (c, String))    -> (b, String) -> (c, String)
```

There you go. With Monad's bind operator all we are doing is transforming the functions so that we can compose them.

Here is one example of how you might use `=<<` to compose functions

```Haskell
wordCount = print . length . words =<< getContents
```
