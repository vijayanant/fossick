+++
type = "post"
date = "2018-05-11"
title = "TDD Mantra"
categories = ["Programming"]
tags = ["development", "testing", "TDD"]
+++

## The Essence
* Don't write a line of new code unless you first have a failing automated test. 
* Eliminate duplication. (refactor)

## What is Needed
The ability to write concrete, deterministic, automated tests is a prerequisite
for applying TDD.

## Mantra - Order in Programming
The two mantras imply an order to the tasks of programming:

* Red - write a little test that doesn’t work, perhaps doesn’t even compile at
  first
* Green - make the test work quickly, committing whatever sins necessary in the
  process 
* Refactor - eliminate all the duplication created in just getting the test to
  work

## Implications
The simple mantra generates complex individual and group behavior. Some of the
technical implications are:

* You must design organically, with running code providing feedback between
  decisions
* You must write your own tests, since you can't wait twenty times a day for
  someone else to write a test
* Your development environment must provide rapid response to small changes
* Your designs must consist of many highly cohesive, loosely coupled components,
  just to make testing easy


## Benefits
* If the defect density can be reduced enough, QA can shift from reactive to
  proactive work
* If the number of nasty surprises can be reduced enough, project managers can
  estimate accurately enough to involve real customers in daily development
* If the topics of technical conversations can be made clear enough, programmers
  can work in minute-by-minute collaboration instead of daily or weekly
  collaboration
* If the defect density can be reduced enough, we can have shippable software
  with new functionality every day, leading to new business relationships with
  customers

## What is in it for Developers?
Managing Fear - Once you get one test working, you know it is working, now and
forever. You are one step closer to having everything working than you were when
the test was broken. Now get the next one working, and the next, and the next.
By analogy, the tougher the programming problem, the less ground should be
covered by each test.

## The Rhythm
* Quickly add a test
* Run all tests and see the new one fail
* Make a little change
* Run all tests and see them all succeed
* Refactor to remove duplication

## Surprises
* How each test can cover a small increment of functionality
* How small and ugly the changes can be to make the new tests run
* How often the tests are run
* How many tiny steps make up the refactorings
