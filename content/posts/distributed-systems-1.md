+++
type = "post"
date = "2018-08-14"
title = "Distributed System - Part 1"
category = ["Distributed Systems"]
tags = ["scaling", "storage", "computation", "messaging"]
description = "Part 1 of the 3 part series on Distributed Systems"
draft = true
+++

The simplest of applications we can write and maintain are the ones that run
with a single thread on a single processor. We know why we don't do that, because
there is only so much we can achieve with such a system. 

The main concerns with this set up are 

* __Scale__  We want more resources (CPU, GPU, memory, or storage) than what is
  available on single server. Buying bigger server, even if available, is not
  efficient in terms of cost and server utilisation. Different functionalities
  might require different combination of resources and resource characteristics.
* __Resilience__ Any software and hardware can fail/crash. Running an
  application on single machine is single point of failure. We prefer to have
  our application be available for users and work as expected even under cases
  of hardware and/or software failures. 

A Distributed System tries to overcome these concerns. 

## Distributed System
A distributed system, in its most simplest definition, is a group of computers
working together and appears as a single computer to its user.  For example,
amazon.com appears to us as a single computer even though many computers are
working together behind the scene.

> A collection of independent computers that appear to its users as one computer
>
> -- _Andrew Tannembaum_

### Characteristics of Distributed Systems
* The computers operate concurrently 
* The computers fail independently

Since all the computers function concurrently, we can scale easily by adding
more computers (or remove computers when not required). Even if one or more of
those computers fail, it will not affect the entire system and all the features
of our system will be available all the time.

Even though Distributed System overcome the concerns of scaling and resiliency
the complexity of such a system greatly increases. Even the simplest of
application when distributed across computers becomes complex. Simple things like
storing data, computing data, and  passing data across components becomes hard.

In this 3 part series I will talk about three architectural concerns of any
system, namely, storage, computing and messaging in a distributed system.



  


