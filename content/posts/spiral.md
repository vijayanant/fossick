+++
type = "post"
date = "2018-02-12"
title = "Outward Counterclockwise Spiral Matrix Traversal - Haskell"
tags = [ 
  "fp",
  "haskell",
  "matrix traversal",
  "coding",
  "puzzle"
]
categories = ["Programming", "Haskell"]
description = "An efficient, lazy implementation of spiral traversal on a matrix in Haskell." 
+++

## Problem

Write a function that accepts four arguments. The first two arguments are the
size of the grid (rows X columns), filled with ascending integers from left to
right, top to bottom, starting from 1. The next two arguments are the starting
positions, the row `r` and column `c`.

Return an array of integers obtained by spiraling outward anti-clockwise from
the `r` and `c`, starting upward.

[More details
here](http://us2.campaign-archive1.com/?u=cadc6c448cd083a0aeed7f864&id=a6856ac71e&e=7cfe3ee063)


My attempt in Haskell.

{{< gist vijayanant d1508706dc727b8b27d38495377c28dc "spiral.hs" >}}
