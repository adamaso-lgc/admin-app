locals {
  service_name = "admin-poc"
  environment  = "local" 

  projects = {
    "4a0c1fd3-8f05-4c7e-8a15-10b8acd22ad2" = { projectId = "4a0c1fd3-8f05-4c7e-8a15-10b8acd22ad2", version = "1.0", name = "Project Alpha", status = "Succeeded", lastDeploymentDate = "2024-04-01T12:00:00Z" },
    "5b1c2ee4-9e06-5d7f-9b25-20c9bce33bc3" = { projectId = "5b1c2ee4-9e06-5d7f-9b25-20c9bce33bc3", version = "1.0", name = "Project Beta", status = "Failed", lastDeploymentDate = "2024-04-02T12:00:00Z" },
    "6c2d3ff5-ad07-6e8f-ac35-30daedf44cd4" = { projectId = "6c2d3ff5-ad07-6e8f-ac35-30daedf44cd4", version = "1.0", name = "Project Gamma", status = "Succeeded", lastDeploymentDate = "2024-04-03T12:00:00Z" }
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
    projectId           = {"S": each.value.projectId},
    version             = {"S": each.value.version},
    name                = {"S": each.value.name},
    status              = {"S": each.value.status},
    lastDeploymentDate  = {"S": each.value.lastDeploymentDate}
  })
}
