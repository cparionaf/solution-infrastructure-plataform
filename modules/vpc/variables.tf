variable "enable_nat_gateway" {
  type = bool
  default = true
}

variable "single_nat_gateway" {
  type = bool
  default = true
}

variable "private_subnets_cidr_block" {
  type = list(string)
  default =  ["10.0.16.0/20", "10.0.32.0/20"]
}

variable "public_subnets_cidr_block" {
  type = list(string)  
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}
variable "project_name" {
  type = string
  default = "solutions-architecture-moc"
}

variable "environment" {
  type = string
  default = "dev"
}
