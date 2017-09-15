+++
type = "post"
title = "A Detour Called Monads"
date = "2016-08-15"
draft = false
tags = ["FP", "monadsa", "programming"]
+++

When learning Haskell, all of us are faced with this monad monster. I too have spent many days and night fighting it -  hoping that it will grant me all the wisdom if I survive long enough. I have come to believe that the community as whole has created this monstor. And many of us have taken this detour to master the art of monstor slaying instead of going on ahead - just to realise later that the detour was unnesessory. Pocket knife is all that was needed.

Stop Scaring the newcomers. We don't call it List Monad everytime we use it. We are OK to call it just List. But everytime we need state why do we call it State Monad? When I need to do i/o I will use IO. The fact that it is a monad is not relevant at that point.

Monads don't do IO, monads don't manage State, Monads don't handle Exception. Monads don't do anything. The types IO, State etc. do. Understand the types.
