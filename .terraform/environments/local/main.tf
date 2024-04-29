locals {
  service_name = "admin-poc"
  environment  = "local" 

  projects = {
    "001" = { projectId = "001", version = "1.0", name = "Project Alpha", status = "Active" },
    "002" = { projectId = "002", version = "1.0", name = "Project Beta", status = "Inactive" },
    "003" = { projectId = "003", version = "1.0", name = "Project Gamma", status = "Active" }
  }
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

resource "aws_dynamodb_table_item" "default_item" {
  for_each   = local.projects
  table_name = module.dynamodb_table_poc.dynamodb_table_name
  hash_key   = module.dynamodb_table_poc.dynamodb_table_hash_key
  range_key  = module.dynamodb_table_poc.dynamodb_table_range_key

  item = jsonencode({
    projectId = {"S": each.value.projectId},
    version   = {"S": each.value.version},
    name      = {"S": each.value.name},
    status    = {"S": each.value.status}
  })
}
