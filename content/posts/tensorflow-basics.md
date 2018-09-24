+++
type = "post"
date = "2017-10-02"
title = "TensorFlow Basics"
tags = [ 
  "tensorflow",
  "machine learning",
  "deep learning"
]
categories = ["Programming"]
description = "TensorFlow is Google's open source library for numerical computation. All computations are represented as Data Flow Graphs. The Nodes in the graph represent operations and Edges represent the data-communication between nodes."
+++

TensorFlow is Google's open source library for numerical computation. All computations are represented as __Data Flow Graphs__. The Nodes in the graph represent operations and Edges represent the data-communication between nodes.   

## Basics
Every computation is a graph. That is, we first create a graph that represent our computation. Then we run/evaluate that graph. The evaluation always happen within a __Session__  

```python
import tensorflow as tf
x = tf.random_uniform([10])
print(x)
```

What do you think the above code prints?

`Tensor("random_uniform:0", shape=(10,), dtype=float32)`

`x` is a Tensor. Remember that everytihing in tensorflow is graph made of nodes and edges. The call to `tf.random_uniform()` returns a `Tensor`. 

### Tensor 
A tensor is what is passed between nodes (edge). It represents the (input and) output of an Operation (node). A tensor does not hold the values of the operation's output, but instead provides a means of computing those values in a Session.

In the above example, `tf.random_uniform()` is an Operation and it returns a Tensor. 

Take another look at the output of previous example - 

`Tensor("random_uniform:0", shape=(10,), dtype=float32)`

it tells us that x is a Tensor, the opration name is random_uniform (:0 says its the output), the shape of the tensor (a list of 10 elements) and data type of the elements in the list(float32).

You can get information about the tensor using many of the functions and attribute values available. 

```python
shape = x.get_shape().as_list()
ty = x.dtype
name = x.name
op_name = x.op.name
print([name, op_name, ty, shape])
```

`
['random_uniform:0', 'random_uniform', tf.float32, [10]]
`

So, how do we get the actual result? 

### Sessions and Graphs
Remember we mentioned earlier that every computation is represented as a graph? By default, every operation is added to a default graph. And a Session is where the operations in the graph are run. 

```python
g = tf.get_default_graph()
session = tf.Session(graph=g)

result = session.run(x)

print(result)
session.close()
```

The result -
```
[0.23983908 0.30026257 0.21374762 0.18318117 0.8556453  0.25169706
 0.8703637  0.69733584 0.9137391  0.20477629]
 ```

### Operations
Operations are the nodes in the graph that consume and/or produce Tensors. 

```python
[op.name for op in g.get_operations()]
```

```python
['random_uniform/shape',
 'random_uniform/min',
 'random_uniform/max',
 'random_uniform/RandomUniform',
 'random_uniform/sub',
 'random_uniform/mul',
 'random_uniform']
```

### Variables
Variables are stateful nodes which output their current value. State is retained across multiple executions of a graph. A variable holds a  value, which can be a Tensor of any type and shape. The type and shape of the variable are fixed at initialization time. The value can be changed using one of the assign methods.

```python
import tensorflow as tf

mat = [ [1,2,3], [4,5,6], [7,8,9] ]
trans = tf.transpose(mat)

x = tf.Variable(mat)
y = tf.matmul(mat, trans)

x.assign(tf.add(y,1))
```

### Placeholders 
Placeholders are nodes whose value is fed in at execution time. 

```python
import tensorflow as tf

x = tf.placeholder(tf.float32, shape=(1024, 1024))
y = tf.matmul(x, x)

with tf.Session() as sess:
  rand_array = np.random.rand(1024, 1024)
  print(sess.run(y, feed_dict={x: rand_array}))  # Will succeed.
```


 
## Putting It All Together
We have so far learned what tensorFlow is about and got basic intuition towards Tensors, Graphs, Operations and Sessions. We have also learned about how to use Variables and Placeholders. Now, we will put all that togetther.

* First, build a graph using variables and placeholders.
* Then, deploy the graph onto a session, which is the execution environment

```python
import numpy as np 
import tensorflow as tf

b = tf.Variable(tf.zeros((100,)))
W = tf.Variable(tf.random_uniform((784, 100),-1, 1))

x = tf.placeholder(tf.float32, (100, 784))

# h = ReLu(Wx + b)
h = tf.nn.relu(tf.matmul(x, W) + b)

sess = tf.Session()
sess.run(tf.initialize_all_variables())
sess.run(h, {x: np.random.random_sample((100, 784))})
 
```

If you are not already familiar with NN and activation functions, don't worry about the ReLU (`tf.nn.relu()`). Just know that TensorFlow provides a very rich set of tools to work with machine learning. 
