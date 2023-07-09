# 1.0 sample - simple CC environment

This is a simple example of a CC environment that can be used as a starting 
point to learn how to do things better.

We are creating an environment that has:
- a single kafka cluster (with a service account and API keys)
- a single schema registry cluster (with a service account and API keys)
- a single topic
- a single schema

This is good for getting started, but not much else.

We are going to start simple, then build from there. 

This project is a simple example of a CC environment that can be used as a 
starting point to learn how to do things better.

In the next iteration of this, we will create multiple environments:
- development
- test
- production

We will use terragrunt to manage the environments, and create modules for each area.
