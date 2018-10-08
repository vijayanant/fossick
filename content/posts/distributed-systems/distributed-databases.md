+++
type = "post"
date = "2018-10-08"
title = "Distributed Systems and Scalable Databases"
categories = ["Distributed Systems"]
tags = ["scaling", "storage", "databases"]
description = "Introduction to distributed systems. How distributed databases work and their scaling model. We will also talk about different consistency models that arise as a result."
draft = false
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

## Scaling Database
We will see many approaches to scale data storage and the challenges that
arise because of that. 

### Single Master Storage

We all are aware of this simple data storage model. The database runs on a
single server. If you wanted to scale you run the database on a much bigger
server. At some point, the single server fails to perform as best as did due to
lack of resources.

### Read Replication

This, in many ways, was the first approach to _scaling horizontally._ We
realised that most of web application traffic was read and we thought of
splitting read and write requests to different servers (called nodes). 

The concept is simple. All writes still go to a single master and then the
writes are propagated to the followers. The read requests are handled by the
follower nodes. This allows for master to handle much more write traffic and
multiple follower nodes can handle a lot of read request and it is a matter of
adding new follower node to cater for increased read requests.

Even though this seemingly simple arrangement allows us to handle more load by
distributing read and write request to different nodes, we have broken the
consistency. __The database is no longer consistent__ (even if the database we
are using is a relational database). When we write to master node the write has
to propagate to the follower nodes before it can be read. There is a small time
window during which the write has completed but the read operation fails. There
is, however small, a delay  for follower nodes to have the latest data. This is
_Eventually Consistent_ since the write will be propagated to followers at some
point without fail.

So, we lost consistency for a while but hey!, everything else is fine now,
right? NO! This may work for a while but ultimately the master is still handling
all the write requests. At some point the master can not handle the amount of
writes it has to do. What do we do?

### Sharding

With Sharding we split our data across nodes. Each node is called a __shard__.
Each shard holds different data. We decide how the data is segregated. For
example, we can segregate our user data based on user's name. All the data of
users with name starting with letters A to F are in shard 1 and user data with
name starting with letters from G to N are in shard 2 and similarly O to Z in
shard 3.

The rules of sharding the data are very important as the database will choose
which shard to go to for reading and writing data based on the rule. Each of the
shard will have its own set of replicated followers as in read-replicated
databases.

Now, we can handle as much write as we want by making the shards smaller and
smaller and also by having replicated followers for handling read traffic.

We had already lost consistency by having replicated followers but now we split
our data across nodes which means we can no longer have the same data model we
had earlier. We can not, for example, read data of two users residing in
separate shards at a time!. Our joins are no longer useful as they can only work
with partial data residing in that particular shard. To overcome this, the SQL
joins have to work with all the shards and then some more to combine them all.

One way to overcome this problem with joins is to __Denormalize__ the data. By
denormalising data we have improved read performance at the cost of write
performance. At this point we lost many of the features that our databases
provided. We no longer have consistency, joins are slower and we reduced write
performance by denormalizing data.

## Distributed Databases

From what we have seen up until now, we create some new problem every time we
have to scale beyond what our current model helps with. We now have a
sharded, replicated system that scales. What are the concerns here?
Consistency, availability and performance. 

We now have more than one server in the network. When a database write occurs,
we now need to decide when to consider it complete: as soon as it is persisted
on the master, or only after it is persisted on a replica (or even two or more
replicas if we want higher availability). If we decide that persisting it on the
master is enough, we risk losing data if the master fails before replicating the
data. If we decide to wait until the data is replicated, we incur latency
penalty.

Thus, from a world of consistency by default, we have entered a world where
consistency is a choice. In this world, we could choose to have eventual
consistency, where the state is replicated across multiple nodes, but not every
node has a complete view of the entire state.

There is still a way to make our distributed database strongly consistent. We
decide on number of replicas that need to acknowledge the success of read or
write operation. The number of replicas we decide is also called consistency
level or Quorum. For a system to be considered strongly consistent, it has to
follow the rule  `R + W > N`. Here `R` and `W` are the consistency level of read
and write operations and `N` is the total number of replicas.


## The CAP theorem

The CAP theorem was introduced by Dr. Eric Brewer in 2000. Given a distributed
system, it is impossible to guarantee the three following properties:

* __Consistency__: All nodes share the same states, that is, they all have
  the same data. In an informal manner, a system is consistent if a write is
  successful, all the components of the system can read the new value.
* __Availability__: The system remains operative to take care of every
  client request, managing it and answering it. Furthermore, it also means that
  the system is still awake even if a node fails (or crashes).
* __Partition Tolerance__: The systems keeps attending client requests even
  though it has been divided into at least two different parts, also called
  partition, that cannot communicate between them.

>Dr. Brewer issued a clarification stating that his original "pick two out 
>of three" concept was greatly simplified in order to open up a discussion and
>help move it beyond ACID

For example, when two of the nodes cannot communicate with each other (network
reasons, lets say), there is a partition. At that point our system can choose
either to be consistent and unavailable  (fail instead of returning stale data)
or be inconsistent and available (return stale data). It cannot choose to be
both consistent and available. 

>Partition tolerance is a must for any distributed data store. 

## Eventual Consistency And BASE Properties

As it turns out many applications (or part of the application) prefer high
availability more than strong consistency. And network latency is an issue in
keeping nodes in sync for consistency bringing the system performance down.

These applications settle for a highly available, eventually consistent system.
These systems offer BASE properties (as opposed to ACID)

* __B__asically __A__vailable  -- High Availability
* __S__oft state -- State of the system might change even when nothing external
  happens due to eventual consistency
* __E__ventual Consistency -- Eventually consistent system

The most famous systems that appeared and took this option are the NoSQL
databases.



