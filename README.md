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

Surprisingly little! This is what has made me a believer in terragrunt.

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

Next, I create a `test/confluent-cloud` directory and copied the 
`development/confluent-cloud/terragrunt.hcl` file into it. No changes were 
needed to it yet.

Now, lets say that I want to create a production environment. I would copy the 
same files and make the same changes, but what if I want to change the 
partition count of my topic to 10 instead of 1 ... but only in production?

My module doesn't allow that yet, but it is easy to add. I just need to add a 
variable in my module and then set it in the appropriate files:

- modules/tf-confluent-cloud/variables.tf
    - define the variable here
- modules/tf-confluent-cloud/main.tf
    - use the value here
- global.hcl
    - set the default value here
- production/confluent-cloud/terragrunt.hcl
    - set the production specific value here

Now, when I run `terragrunt apply` in the production directory, it will use the value 10; in all other
environments, it will use the default value of 1.

> NOTE: I use AWS, but you can use whatever you want. If you come up with a 
> clever way to do this in another cloud (azure of gcp), please let me know! I 
> would love to incorporate it into this work.

## up next...

In our next iteration...more environments!

We will add test and production environments. We will also add a few more 
variables for those environments for things like partition counts and the like.
