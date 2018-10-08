+++
type = "post"
date = "2018-08-15"
title = "Distributed Systems: Distributed Applications"
categories = ["Distributed Systems"]
tags = ["scaling"]
description = "Part 3 of series on Distributed Systems. Here we see how the computation is distributed across servers and its consequences."
draft = true
+++

Scaling and resilience are major concerns that distributed systems tries to
overcome. In [Distributed datastores] (../distributed-datastore) we saw how
databases
have become highly scalable and available systems. In this post, we focus
on the business layer and see how computing models provide high availability
and scalability.

Reasons for distributing the business layer are still the same: make use of low
cost PCs, scalability, and reliability. But distributed systems offer so much
more than just that.

Even though we are discussing distributing data layer and business
layer separately, the technique are still the same.

## All In One Monolith
When an application is built as a single deployable component, we call that a
monolithic application. It is a completely independent system that provides all
the intended functionality. A word processor running on your PC is an example of
such a system.

In common usage, user interface and data store is not considered. In this
definition, a monolithic application is one where all functionality is built into
a single deployable component. The application receives requests from client and
uses some data store for persistence.

The traditional approach to scaling is by running the application on a bigger
server; and high reliability is achieved by having a stand-by server in
active-passive configuration with fail-over setup.

It was common for such an application to be stateful in nature. When the system
failed over we could loose system state unless we persist all runtime state
which is shared by the stand-by server. This both complicates the system and
overloads the persistence layer. And fail-over introduces some downtime when the
application is failing-over to stand by server. This means the system can not be
fully available.

## Replication - Load Balanced Monoliths
To make the system highly available, we moved to active-active configuration or
more general load balanced approach. This requires application to be stateless
since consecutive requests are no longer guaranteed to to be serviced by same
server. Other option is to build some complex logic in the load balancer to
route to the related requests to same server (not recommended!).

This makes the system more available. But the caching layer is no longer
consistent. Since each server runs independently of each other, they can read
and modify data on the shared data store and local cache may become
inconsistent. We are not to talk much about cashing and its complexities here :)

Even though we achieved reliability (at the cost of local cache), we are still
running the entire application on each server. Even if majority of the requests
are for a single feature, we need to run the whole application on new server.

## Sharding - Distributed Application 
>A distributed application, in simple terms, is an application that is built as
>multiple cooperating applications.

Instead of bundling all functionality into single executable/deployable, we will
have multiple executables/deployables/instances; each performing a small part of
the overall application functionality. This allows us to scale different
functionality independently as needed and replication guarantees high
availability.

This poses a major questions - How to break up our application/functionalities
into smaller applications?

> Not all distributed applications are split into multiple dissimilar
> components. For example, in a Peer-to-Peer (P2P) application, every node is
> functionally same. Such systems are classified as Decentralized systems.


## Architectural Styles
Architectural styles provide answers to the above questions. Each option
provides a trade-offs between performance, fault tolerance, and simplicity.

>Architecture deals with the logical organization of distributed systems into
software components. Architectural style is the way the components are connected
to each other, the data exchanged between components, and how these elements are
put together into a system.

There are many different organizations of distributed systems. 

#### Client-Server Architecture
In this approach machines are divided into clients and servers. A client sends a
request to a server, who will then produce a result that is returned to the
client. The client-server architecture reflects the traditional way of
modularizing software in which a module calls the functions available in another
module. By placing different components on different machines, we obtain a
natural physical distribution of functions across a collection of machines.


A well established approach is to spliit based on functionalities
offered by the application (shard). Each shard is treated as though is a independent
application. Each such application can be as complex as required or split into
further smaller shards.

A distributed system has to appear to user as a single system; which means
the applications have to coordinate among themselves. This happens by the way of
passing messages between them.

<!--We have come a long way since we started building applications using the
client server model. We have seen many architectures with different
characteristics and approaches. They all define different models for
communicating and coordinating with different parts of the systems.-->

Unlike in the case of data stores, requirements from computation layer varies
from application to application. There are many patterns and approaches that
tries to generalise most application requirements. Each approach has its own
advantages and disadvantages. Choosing the one that suits our needs is tricky.

I wish to write about some of the best practices and patterns in the future.
When I do, I will come back and provide a link. 
