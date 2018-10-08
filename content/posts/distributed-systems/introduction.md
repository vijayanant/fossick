+++
type = "post"
date = "2018-08-14"
title = "Distributed Systems: Introduction"
categories = ["Distributed Systems"]
tags = ["scaling", "reliability", "computation", "messaging"]
description = "Part 1 of the series on Distributed Systems. In this post we will learn what distributed systems are and how they enable us in writing scalable and highly available applications."
draft = true
+++

The simplest of applications we can write and maintain are the ones that run
within a single thread on a single processor. We know why we don't do that,
because there is only so much we can achieve with such a system.

The main concerns with this set up are:

* *__Scale__* : We need more resources (CPU, memory, or storage) than what is
  available on single server. Buying bigger server, even if available, is not
  efficient in terms of cost and server utilisation. Different functionalities
  might require different combination of resources and resource characteristics.
* *__Resilience__* : Any software and hardware can fail/crash. Running an
  application on single machine is single point of failure. We prefer to have
  our application be available for users and work as expected even under cases
  of hardware and/or software failures.

A Distributed System provides an alternative approach to scaling and makes our
system resilient to hardware and software failures.


### Distributed System
> A distributed system is a collection of independent computers that appears to
> its users as a single coherent system.
>
> -- *Andrew S. Tanenbaum*

For example, amazon.com appears to us as a single computer even though many
computers are working together behind the scene.

This simple definition focuses on two important factors:

* the system consists of components (computers) that are autonomous.
* to its users, humans or programs, the system appears as though they are
  dealing with single system/computer.

For independent component to work as a coherent system, the components must
__collaborate__ among themselves. Effective collaboration among components lies
at the heart of distributed system.

### Characteristics of Distributed Systems
* The computers operate concurrently
* The computers fail independently

Since all the computers function concurrently, and independently, we can scale
easily by adding more computers (or remove computers when not required). Even if
one or more of those computers fail, it will not affect the entire system and
all the features of our system will be available all the time.

Even though Distributed System overcome the concerns of scaling and resiliency,
complexity of such a system greatly increases. Even the simplest of application,
when distributed across computers, becomes complex. Simple things like storing
data, computing, and passing data across components becomes hard.

This series of posts on distributed systems will explain how these concerns are
addressed by such a system. At the end of the series we would expect the reader
to  understand what are the complexities involved in building a reliable
distributed system and how to address them.

In the next part we will see approaches to scale database. [Distributed
Storage](../distributed-storage).


