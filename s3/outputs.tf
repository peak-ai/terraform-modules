output "id" {
  value       = aws_s3_bucket.default.id
  description = "The name of the bucket"
}

output "arn" {
  value       = aws_s3_bucket.default.arn
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname"
}
