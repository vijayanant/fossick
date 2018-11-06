+++
title       = "Expressiveness of Haskell"
subtitle    = "Tree traversal in Haskell, Python, and Java"
date        = 2018-11-04
type        = "post"
categories  = ["Programming"]
tags        = ["Haskell", "Python", "Java", "Binary Tree"]
description = """Demonstrate the expressiveness of Haskell using a  simple
Binary Tree and in-order traversal in Haskell, Python and Java""" 
+++

My goto answer when someone asks why I like [Haskell] (https://www.haskell.org)
so much these days is usually _"I like the expressiveness and run time
guarantees of Haskell"._ For those who are little more interested, I would
usually show the popular quick sort or merge sort implementations. I wanted a
slightly more complicated, yet commonly known, example to demonstrate what I
claimed. This is an attempt at that. And turning it into a blog post makes it
available for me all the time (and for other too!!).

I do not claim mastery over either of these languages. If you have any
suggestions on making any of the these implementations more expressive, let me
know and I will update the sample accordingly. Other languages are welcome too!

All three versions does the same thing. Define a simple `Tree` type. Instead of
constructing the tree one-element-at-a-time, we provide a convenient function
`fromList` which takes a list and adds it elements to tree. We also provide a
way to turn the `Tree` back to a list by providing `inorder` function to
traverse the tree in-order.

The tree construction happens like this: we split the list in to three parts -
middle element, left-sublist and right-sublist. Then, we recursively construct
left and right sub-tree with the two split parts of the list. The middle element
is used at the current node. Why we do it this way? If you pass a sorted list,
this will construct a binary search tree. In-order traversal on that tree should
return the original sorted list back!

## Haskell
{{< gist vijayanant d557b72bea0eda2b3490ba8e059fb486 "Tree.hs" >}}

## Python
{{< gist vijayanant d557b72bea0eda2b3490ba8e059fb486 "Tree.py" >}}

## Java
{{< gist vijayanant d557b72bea0eda2b3490ba8e059fb486 "Tree.java" >}}
