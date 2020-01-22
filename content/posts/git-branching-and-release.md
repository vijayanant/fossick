+++
title       = "Simple Git Branching and Release"
date        = 2020-01-22T13:56:30+05:30
type        = "post"
categories  = ["programming", "tools"]
tags        = ["git",  "git-flow", "versioning", "releasing"]
description = "A simple git branching model for working in a team"
draft       = true
+++

# Git Branching and Releasing (Draft)
## AIM
To make below listed activites simple (from SCM point of view)

* Adding new features:
* Fixing bugs
* Preparing for release
* Deploying to production
* Applying hotfixes
* Versioning

## What We Want
* We want the development to happen in short, shippable increments, and not
  tied to a bigger release
* Flexibility in deciding when and what to release
* Avoid dirty/untested code being used by others
* Protect release from incomplete features
* Applying Hotfixes should not dilute/disturb features under development
* Easy production rollback

## What We Do
### Branches

#### Master
Master branch will have code that is running on Production.

#### Development
It includes code that has been code reviewed and tested. Allows us to release
from this branch anytime we want. Any new feature we want to add to our product
will be done on top of this (branches our from here). CI tests (regression
tests) happens on this branch.

#### Features/feature_name
A feature branch is created for all new development. A feature branch
represents a single shippable feature or bug fix. By keeping the feature small,
we control when and how we ship. When the feature is complete we simply merge
the code to development branch; QA also happens on this branch. CI tests
(regression tests) also can be done here.

#### Releases/SemVer
The release branch is to facilitate the process of releasing code into
production easier. Release branch is created just before releasing.  This
allows the team to address any minor tweaks and bug fixes during the release
while not locking your team out of working on new stuff.

This is also where we decide the version of the new release. We will follow
SEMVER. When we are happy with the release code, we will merge the code to both
master and development.

#### HotFixes/hotfix_name
This branch is for bugs that require immediate fix  when we cannot wait unitll
next release. This branch is created from the master branch. We fix the bug,
test, and merge the code back into master and development branches. The master
branch is tagged with the updated version.


## From Developer Perspective
Here’s how it works:

* A feature branch is created from the develop branch.
* The engineers write the code and the unit tests for it.
* A pull request is created to move the code from the feature to the develop
  branch.
* A code review is performed and any necessary edits made.
* The code from the feature branch is tested in the QA environment.
* Any bugs are then fixed, still within the feature branch.
* The pull request is closed and the feature branch is merged to develop.
* A release branch is created from the develop branch. We version the release
  appropriately by the contents of the release (major/minor/bugfix release).
* The product owner reviews the new feature in the release branch in a separate
  environment (Preprod/UAT/etc.)
* Any (minor) changes/fixes specific to that release is done on this branch
  before merging to master (and dev if changes are done in release).

