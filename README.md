# 1.1 sample - a few more CC environments

This is another example of a CC environment that can be used as a starting 
point to learn how to do things better (everything can be done better, right?).

In this version, we are creating multiple environments that each have:
- a single kafka cluster (with a service account and API keys)
- a single schema registry cluster (with a service account and API keys)
- a single topic
- a single schema

This is a bit more useful, but still pretty simple.

## this iteration...

In this iteration, we created a development environments using terragrunt:

### what did we do?

We created a `global.hcl` file in the root of the project that defines the 
global settings to be shared by all environments.

When you use TG, the goal is to reduce the amount of redundancy in your code, 
this global file helps us do that better.

For example, we want all of our environments to have the same AWS region, so 
we put that in the global file.

> NOTE: I use AWS, but you can use whatever you want. If you come up with a 
> clever way to do this in another cloud (azure of gcp), please let me know! I 
> would love to incorporate it into this work.

In each 

## up next...

In our next iteration...I don't know, we'll do more things and stuff.
