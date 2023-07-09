output "cloud-config" {
  value = <<-EOT
  kafka_cluster {
    id = "${confluent_kafka_cluster.this.id}"
  }
  rest_endpoint = "${confluent_kafka_cluster.this.rest_endpoint}"
  credentials {
    key    = "${confluent_api_key.kafka_broker.id}"
    secret = "${confluent_api_key.kafka_broker.secret}"
  }
  ===========
  schema_registry_cluster {
    id = "${confluent_schema_registry_cluster.this.id}"
  }
  rest_endpoint = "${confluent_schema_registry_cluster.this.rest_endpoint}"
  credentials {
    key    = "${confluent_api_key.schema_registry.id}"
    secret = "${confluent_api_key.schema_registry.secret}"
  }
  EOT
  sensitive = true
}

