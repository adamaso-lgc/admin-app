output "dynamodb_table_arn" {
  value = aws_dynamodb_table.generic_table.arn
}

output "dynamodb_table_tags" {
  value = aws_dynamodb_table.generic_table.tags
}

output "dynamodb_table_tags_all" {
  value = aws_dynamodb_table.generic_table.tags_all
}

output "dynamodb_table_stream_arn" {
  value = aws_dynamodb_table.generic_table.stream_arn
}