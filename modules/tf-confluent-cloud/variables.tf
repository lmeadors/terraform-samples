variable "confluent_cloud_api_key" {
  type = string
}
variable "confluent_cloud_api_secret" {
  type = string
}

variable "environment" {
  type = string
}

variable "schema_registry_config" {
  type = map(string)
}

variable "kafka_cluster_config" {
  type = map(string)
}

variable "user_event_topic_config" {
  type = map(string)
}
