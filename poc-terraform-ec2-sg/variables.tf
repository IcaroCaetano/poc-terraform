variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}
variable "key_pair_name" {
  description = "EC2 Key Pair name for SSH access"
  type        = string
}
