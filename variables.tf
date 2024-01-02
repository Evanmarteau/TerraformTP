# Variable pour spécifier la région AWS où les ressources seront déployées.
variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "eu-west-3"  # Remplacez par la région de votre choix
}

# Variable pour spécifier le type d'instance EC2 à lancer.
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"  # Remplacez par le type d'instance de votre choix
}

# Variable pour spécifier le bloc CIDR pour le VPC.
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

# Variable pour spécifier la clé d'accès AWS
variable "access_key"{
  description = "Access key for AWS"
  type        = string
}

# Variable pour spécifier la clé secrte AWS
variable "secret_key"{
  description = "Secret key for AWS"
  type        = string
}
