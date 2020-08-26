output "role_arn" {
  value       = aws_iam_role.this.arn
  description = "The Amazon Resource Name (ARN) specifying the role"
}

output "role_name" {
  value       = aws_iam_role.this.name
  description = "The name of the role"
}

output "policy_name" {
  value       = aws_iam_policy.this.name
  description = "The name of the policy"
}


