
variable "ec2_instance_type" {
  description = "Only t2.micro and t3.micro instance types are allowed."
  type        = string
  default     = "t2.micro"

  validation {
    condition     = contains(["t2.micro", "t3.micro"], var.ec2_instance_type)
    error_message = "Invalid instance type. Only t2.micro and t3.micro are allowed."
  }
}

variable "ec2_volume_config" {
  type = object({
    size = number
    type = string
  })
  description = "The configuration for the EBS volume."
  default = {
    size = 8
    type = "gp3"
  }
}