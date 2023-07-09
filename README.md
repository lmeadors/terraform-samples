# 1.2 sample - making a few more CC environments with terragrunt

This is an example of how to create multiple CC environments that can be used 
as a starting point to build out a real usable set of environments.

In this version, we are creating multiple environments that each have:
- a single kafka cluster (with a service account and API keys)
- a single schema registry cluster (with a service account and API keys)
- a single topic
- a single schema

## this iteration...

In this iteration, we created a test and production environments using terragrunt.

### what did we do?



> NOTE: I use AWS, but you can use whatever you want. If you come up with a 
> clever way to do this in another cloud (azure of gcp), please let me know! I 
> would love to incorporate it into this work.

## up next...

In our next iteration...more environments!

We will add test and production environments. We will also add a few more 
variables for those environments for things like partition counts and the like.
