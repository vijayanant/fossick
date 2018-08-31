+++
type = "post"
draft = true
title = "Using Docker For Local Development"
date = "2018-08-21"
+++

I have a directory `~/workspace/` on all my laptops where I keep all my code. I
also tried to keep language specific subdirectories unsuccessfully! I still
believe with a little extra care language specific subdirectories is very much
possible. It helps a lot when I want to find that little thing I tried in a
specific framework or library. I guess a lot of you do something similar. 

This is all fine. Having and working with multiple languages is fairly common.
The problem arises when you want to work with something you did fairly long time
ago. The project uses older version of the language, the dependencies seem
ancient and sometime (well, fairly often) the build itself fails for missing or
unsupported or incompatible versions. 

Tools like virtual-env for Python helps in keeping multiple versions of a
language and we can switch between many versions easily. Unfortunately, you will
have to deal with different version managers for each of the language you work
with. And they don't even help you manage different package version dependencies
from various projects. 

I have found Docker to be best suited for solving all these problems that too
with less fuss.

Well, this is not a Docker tutorial; so, you will have to learn about basic
docker usage somewhere else. There are a plenty of good resources available. In
this article I assume you know what docker is and know at least basic usage. 

# Docker To The Rescue


