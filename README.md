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

In this iteration, we created a development environment using terragrunt.

### what did we do?

Let's start with the directory structure:

```shell
├── global.hcl
├── development
│   ├── confluent-cloud
│   │   └── terragrunt.hcl
│   └── environment.hcl
└── modules
    └── tf-confluent-cloud
        ├── main.tf
        ├── outputs.tf
        ├── schema
        │   └── ecommerce_user_event.avsc
        └── variables.tf
```

We created some `terragrunt.hcl` files in the project that we use to defines 
our environments. There are 3 levels of this configuration:

- /global.hcl
- /development/development.hcl
- /development/confluent-cloud/terragrunt.hcl

The top level file describes things that are global to all of our environments. 
Some examples of that are:
- where is our state file stored? 
- what region are we in?
- what providers do we need?

The next level down describes things that are common to all of our development 
environments. At this point, that's just the name of the environment.

Finally, the lowest level describes things that are specific to our confluent 
cloud development environment. 

> NOTE: I use AWS, but you can use whatever you want. If you come up with a 
> clever way to do this in another cloud (azure of gcp), please let me know! I 
> would love to incorporate it into this work.

## up next...

In our next iteration...more environments!

We will add test and production environments. We will also add a few more 
variables for those environments for things like partition counts and the like.
