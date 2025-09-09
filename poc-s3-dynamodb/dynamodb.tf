resource "aws_dynamodb_table" "poc_table" {
  name         = "poc-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

