
variable "ec2_instance_size" {
  description = "Only t2.micro and t3.micro instance types are allowed."
  type        = string
  default     = "t2.micro"

  validation {
    condition     = contains(["t2.micro", "t3.micro"], var.ec2_instance_size)
    error_message = "Invalid instance type. Only t2.micro and t3.micro are allowed."
  }
}

variable "ec2_volume_size" {
  type        = number
  description = "The size of the EBS volume in GB."
}

variable "ec2_volume_type" {
  type        = string
  description = "The type of EBS volume. Valid values are 'gp2', 'gp3'"
}