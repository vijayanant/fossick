+++
type = "post"
date = "2016-10-23"
title = "OO(h!) Principles"
keywords = [  
  "Object orientation",
  "Design Principles",
  "Software Design",
  "Principles",
  "SOLID",
  "Packaging"
]
description = "An (incomplete) list of principles of OO software development"
+++

There is a good chance that you all are aware of the SOLID principles. There are many more principles for us to consider and adhere to while developing OO software.

## SOLID
These are the __Principles of Object Oriented Class Design__ popularly known as the __SOLID Principles__.

* The **S**ingle Responsibility Principle [SRP]
* The **O**pen/Closed Principle [OCP]
* The **L**iskov Substitution Principle [LSP]
* The **I**nterface Segregation Principle [ISP]
* The **D**ependency Inversion Principle [DIP]


The next two set of principles, are related to _packaging_. Package here refers to a _deployable component_, or simply something you would '_release_' for others to use - like a jar file. These are the __Principles of Package Architecture__.

##  Package Cohesion Principles

* The Release Reuse Equivalency Principle [REP]
* The Common Closure Principle [CCP]
* The Common Reuse Principle [CRP]

## Package Coupling Principles

* The Acyclic Dependencies Principle [ADP]
* The Stable Dependencies Principle [SDP]
* The Stable Abstractions Principle [SAP]

## Bertrand Meyer's Principles

Note that some of the principles listed above are also originally described by
Mayer.

* The Linguistic Modular Units principle
* The Self-Documentation principle
* The Uniform Access principle
* The Open-Closed principle
* The Single Choice principle

## GRASP
__G__eneral __R__esponsibility __A__ssignment __S__oftware __P__rinciples

Guidelines for assigning responsibility to classes and objects in object-oriented design. Helps us in deciding which responsibility should be assigned to which object/class. Identify the objects and responsibilities from the problem domain, and also identify how objects interact with each other.

GRASP are more than base principles. These techniques have not been invented to create new ways of working, but to better document and standardize old, tried-and-tested programming principles in object-oriented design.

* Creator
* Information Expert
* Low Coupling
* High Cohesion
* Controller
* Indirection
* Polymorphism
* Protected Variations
* Pure Fabrication
