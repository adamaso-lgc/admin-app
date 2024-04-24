locals {
    table_name = replace("${var.service_name}_${var.table}", "-", "_")
}

resource "aws_dynamodb_table" "generic_table" {
  name              = local.table_name
  hash_key          = var.attribute_hash_key.name
  range_key         = var.attribute_range_key.name
  billing_mode      = "PAY_PER_REQUEST"
  stream_enabled    = var.stream_enabled
  stream_view_type  = "NEW_IMAGE"

  attribute {
    name = var.attribute_hash_key.name
    type = var.attribute_hash_key.type
  }

  attribute {
    name = var.attribute_range_key.name
    type = var.attribute_range_key.type
  }

  tags = {
    Name        = var.service_name
    Environment = var.environment
  }
}