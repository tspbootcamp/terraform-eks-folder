#
# Variables Configuration
#

variable "cluster-name" {
  description = "EKS cluster name"  //added description
  default = ""                      //removed "" declaration
  type    = string
}
variable "key_pair_name" {
  default = "Marypearl"  //update to your keypair name
}
variable "eks_node_instance_type" {
  default = "t3.medium"
}

variable "environment" {
  description = "The environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "profile" {
  description = "AWS CLI profile"
  type        = string
}