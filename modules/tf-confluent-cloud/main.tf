terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.48.0"
    }
  }
}

provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key
  cloud_api_secret = var.confluent_cloud_api_secret
}

data "confluent_schema_registry_region" "this" {
  cloud   = "AWS"
  region  = var.schema_registry_config.region
  package = var.schema_registry_config.package
}

resource "confluent_environment" "this" {
  display_name = var.environment
}

resource "confluent_kafka_cluster" "this" {

  availability = var.kafka_cluster_config.availability
  cloud        = "AWS"
  display_name = "main"
  region       = var.kafka_cluster_config.region

  basic {
    # if it is free, it is for me...
  }

  environment {
    id = confluent_environment.this.id
  }

}

resource "confluent_schema_registry_cluster" "this" {
  package = var.schema_registry_config.package
  environment {
    id = confluent_environment.this.id
  }
  region {
    id = data.confluent_schema_registry_region.this.id
  }
}

resource "confluent_service_account" "this" {
  display_name = "${var.environment}-service-account"
}

resource "confluent_role_binding" "kafka_broker" {
  principal   = "User:${confluent_service_account.this.id}"
  role_name   = "CloudClusterAdmin"
  crn_pattern = confluent_kafka_cluster.this.rbac_crn
  depends_on = [
    confluent_service_account.this,
  ]
}

resource "confluent_role_binding" "schema_registry" {
  principal   = "User:${confluent_service_account.this.id}"
  role_name   = "ResourceOwner"
  crn_pattern = "${confluent_schema_registry_cluster.this.resource_name}/subject=*"
  depends_on = [
    confluent_service_account.this,
    confluent_schema_registry_cluster.this,
  ]
}

resource "confluent_api_key" "kafka_broker" {
  display_name = "${var.environment}-api-key-broker"
  description  = "${var.environment} api key for kafka broker"
  owner {
    api_version = confluent_service_account.this.api_version
    id          = confluent_service_account.this.id
    kind        = confluent_service_account.this.kind
  }
  managed_resource {
    environment {
      id = confluent_environment.this.id
    }
    api_version = confluent_kafka_cluster.this.api_version
    id          = confluent_kafka_cluster.this.id
    kind        = confluent_kafka_cluster.this.kind
  }
  depends_on = [
    confluent_service_account.this,
  ]
}

resource "confluent_api_key" "schema_registry" {
  display_name = "${var.environment}-api-key-sr"
  description  = "${var.environment} service account for schema registry"
  owner {
    id          = confluent_service_account.this.id
    api_version = confluent_service_account.this.api_version
    kind        = confluent_service_account.this.kind
  }
  managed_resource {
    id          = confluent_schema_registry_cluster.this.id
    api_version = confluent_schema_registry_cluster.this.api_version
    kind        = confluent_schema_registry_cluster.this.kind

    environment {
      id = confluent_environment.this.id
    }
  }

}

locals {
  topic_name   = "user_event"
  subject_name = "${local.topic_name}-value"
}

resource "confluent_kafka_topic" "user_event" {

  kafka_cluster {
    id = confluent_kafka_cluster.this.id
  }
  rest_endpoint = confluent_kafka_cluster.this.rest_endpoint
  credentials {
    key    = confluent_api_key.kafka_broker.id
    secret = confluent_api_key.kafka_broker.secret
  }

  topic_name       = local.topic_name
  partitions_count = 1

  depends_on = [
    confluent_service_account.this,
  ]

}

resource "confluent_schema" "user_event" {

  schema_registry_cluster {
    id = confluent_schema_registry_cluster.this.id
  }
  rest_endpoint = confluent_schema_registry_cluster.this.rest_endpoint
  credentials {
    key    = confluent_api_key.schema_registry.id
    secret = confluent_api_key.schema_registry.secret
  }

  format       = "AVRO"
  schema       = file("./schema/ecommerce_user_event.avsc")
  subject_name = local.subject_name

  depends_on = [
    confluent_kafka_topic.user_event,
    confluent_service_account.this,
    confluent_role_binding.kafka_broker,
    confluent_role_binding.schema_registry,
  ]

}
