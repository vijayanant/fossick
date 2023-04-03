+++
title = ""
draft = true
+++

Existential types, also known as existential quantification, is a feature of modern programming languages that allows for the creation of abstract data types that hide their internal implementation details. This concept provides a way for developers to specify the requirements for a particular data type, without exposing its underlying representation, leading to increased code modularity, abstraction, and overall maintainability. In this article, we'll explore the fundamentals of existential types, their applications, and the benefits they offer to programmers.
At the core of existential types lies the idea of abstraction. In computer science, abstraction refers to the process of creating a simplified view of complex systems, with the goal of hiding unnecessary details from the user. Abstraction can be achieved in many ways, including inheritance, interfaces, and polymorphism. However, one of the most powerful abstractions in computer science is achieved through the use of existential types.

An existential type is defined using the keyword existential followed by the type parameter. For example, the following code in a language with existential types:

```haskell
existential T where T: Ordered
    value: T
    less_than: (T, T) -> bool
```

In this code, the existential type T is defined as any type that implements the Ordered interface. The existential type is then used to define a value of type T and a function `less_than` that takes two values of type T and returns a boolean indicating whether the first value is less than the second. The implementation of the less_than function is abstract and can be any implementation that meets the requirements of the Ordered interface.
One of the key benefits of using existential types is that they provide a way for programmers to write code that is more modular, abstract, and maintainable. For example, the following code in a language without existential types:

```python
class OrderedInt:
    value: int
    less_than: (int, int) -> bool

class OrderedString:
    value: str
    less_than: (str, str) -> bool
```

In this code, two separate classes are defined for OrderedInt and OrderedString. Each class implements the Ordered interface for its respective type. However, this code is not as modular as it could be, as it requires the developer to create separate classes for each type that implements the Ordered interface.
In contrast, the following code in a language with existential types is much more modular:

```haskell
existential T where T: Ordered
    value: T
    less_than: (T, T) -> bool

OrderedInt = T where T: int
OrderedString = T where T: str
```

In this code, the existential type T is defined once, and separate types OrderedInt and OrderedString are defined as instances of T with their respective constraints. This approach provides a more abstract and modular implementation, as the implementation of the less_than function is hidden from the user and can be changed without affecting other parts of the code.

Another benefit of using existential types is that they provide a way for programmers to write code that is more type-safe. For example, consider the following code in a language without existential types:

```python
def compare(a, b):
    if isinstance(a, int) and isinstance(b, int):
        return a < b
    elif isinstance(a, str) and is
```    
