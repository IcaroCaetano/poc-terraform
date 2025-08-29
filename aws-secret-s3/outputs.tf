output "bucket_name" {
  value = aws_s3_bucket.poc_bucket.id
}

output "secret_arn" {
  value = aws_secretsmanager_secret.poc_secret.arn
}