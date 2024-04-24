locals {
  service_name = "admin-poc"
  environment  = "local" 
}

module "dynamodb_table_poc" {
  source        = "../../modules/dynamodb_generic"

  service_name  = local.service_name
  table         = "projects"
  environment   = local.environment

  attribute_hash_key = {
      name = "projectId",
      type = "S",
  }
  attribute_range_key = {
    name = "version"
    type = "S"
  }

  stream_enabled = false
}
