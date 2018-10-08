+++
type = "post"
date = "2018-08-15"
title = "Distributed Systems: Distributed Storage"
categories = ["Distributed Systems"]
tags = ["scaling", "storage", "databases"]
description = "Part 2 of the series on Distributed Systems. In this post we will learn how distributed databases work and their scaling model. We will also talk about different consistency models that arise as a result."
draft = true
+++

In the [previous post](../introduction) we learned why we need Distributed
Systems. In this post we will learn why we need to distribute our data and what
challenges arise because of that. 

### Single Master Storage

We all are aware of this simple data storage model. The database runs on a
single server. If you wanted to scale you run the database on a much bigger
server. At some point, the single server fails to perform as best as did due to
lack of resources.

### Read Replication

This, in many ways, was the first approach to _scaling horizontally._ We
realised that most of web application traffic was read and we thought of
splitting read and write requests to different servers (called nodes). 

The concept is simple. All writes still go to single master and then the writes
are propagated to the followers. The read requests are handled by the follower
nodes. This allows for master to handle much more write traffic and multiple
follower nodes can handle a lot of read request and it is a matter of adding new
follower node to cater for increased read requests.

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

We have already lost consistency by having replicated followers but now we split
our data across nodes which means we can no longer have the same data model we
had earlier. We can not, for example, read data of two users residing in
separate shards at a time!. Our joins are no longer useful as they can only
work with partial data residing in that particular shard. To overcome this,
the SQL joins have to work with all the shards and then some more to combine
them all.

One way to overcome this problem with joins is to __Denormalize__ the data. By
denormalising data we have improved read performance at the cost of write
performance. At this point we lost many of the features that our databases
provided. We no longer have consistency, joins are slower and we reduced write
performance by denormalizing data.

## Distributed Data Stores

From what we have seen up until now, we create some new problem every time we
have to scale beyond what our current model helps with. We now have a
sharded, replicated system that scales. What are the concerns here?
Consistency, availability and performance. 

We now have more than one server in the network. When a database write occurs,
we now need to decide when to consider it complete: as soon as it is persisted
on the master, or only after it is persisted on a replica (or even n replicas if
we want higher availability). If we decide that persisting it on the master is
enough, we risk losing data if the master fails before replicating the data. If
we decide to wait until the data is replicated, we incur latency penalty.

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

* __Consistency (C)__: All nodes share the same states, that is, they all have
  the same data. In an informal manner, a system is consistent if a write is
  successful, all the components of the system can read the new value.
* __Availability (A)__: The system remains operative to take care of every
  client request, managing it and answering it. Furthermore, it also means that
  the system is still awake even if a node fails (or crashes).
* __Partition Tolerance (P)__: The systems keeps attending client requests even
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



<!--## Partitioned Replica Set -->

<!--One common approach that provide a balanced mix of performance/scale and-->
<!--availability is to combine partitioning (sharding) and replication in to single-->
<!--system. Such a system is referred to as Partitioned replica set.-->


