# Region

variable "region" {
  description = "The AWS region"
  default     = "eu-west-1"
}

# Instances

variable "total_instances" {
  default = 3
}

#####MongoDB#####

# Ubuntu 16.04 LTS

variable "instance_ami_mongo" {
  description = "Amazon linux AMI"
  default     = "ami-0fbc9760092981a7a"
}

variable "instance_prefix_mongo" {
  description = "Name to instance"
  default     = "MongoDB"
}

variable "instance_type_mongo" {
  description = "Instance AWS type"
  default     = "t2.medium"
}


#####OpenEdX#####

# Ubuntu 16.04 LTS

variable "instance_ami_openedx" {
  description = "Amazon linux AMI"
  default     = "ami-09f339c70ddec58ff"
}

variable "instance_prefix_openedx" {
  description = "Name to instance"
  default     = "OpenEdX"
}

variable "instance_type_openedx" {
  description = "Instance AWS type"
  default     = "t2.large"
}

#####Memcached#####

variable "cluster_id_memcached" {
  description = "Name of the cluster"
  default     = "openedxmemcached"
}

variable "engine_memcached" {
  description = "Engine ElastiCache"
  default     = "memcached"
}

variable "node_type_memcached" {
  description = "Node Type Memcached"
  default     = "cache.t2.micro"
}

variable "parameter_group_name_memcached" {
  description = "Parameter group Memcached"
  default     = "default.memcached1.4"
}

#####Redis#####

variable "cluster_id_redis" {
  description = "Name of the cluster"
  default     = "openedx1"
}

variable "engine_redis" {
  description = "Engine ElastiCache"
  default     = "redis"
}

variable "node_type_redis" {
  description = "Node Type Redis"
  default     = "cache.t2.small"
}

variable "parameter_group_name_redis" {
  description = "Parameter group Redis"
  default     = "default.redis3.2"
}

variable "engine_version_redis" {
  description = "Engine Version Redis"
  default     = "6.0.5"
}

#####RDS#####

variable "engine_rds" {
  description = "Engine RDS"
  default     = "mysql"
}

variable "engine_version_rds" {
  description = "Engine Version RDS"
  default     = "5.7.33"
}


variable "instance_class_rds" {
  description = "Instance class"
  default     = "db.m3.large"
}

variable "name_rds" {
  description = "Name RDS"
  default     = "database-1"
}

variable "username_rds" {
  description = "Username RDS"
  default     = "GNhS5COIDFFZRO95"
}

variable "password_rds" {
  description = "Password RDS"
  default     = "yPiyV8CyF3P8geKZ"
}

variable "parameter_group_rds" {
  description = "Parameter group"
  default     = "default.redis3.2"
}


# Key Pair Name

variable "access_key" {
  description = "Value to key pair created in AWS"
  default     = "Introducir access_key"
}

variable "secret_key" {
  description = "Key to connect into instance"
  default     = "Introduccir secret_key"
}

# Vpc

variable "vpc_id" {
  description = "OpenEdX VPC"
  default     = "vpc-1f6dc966"
}

# Subnet
variable "subnet_ids" {
  type = "map"

  default = {
    "eu-west-1a" = "subnet-357c9d7e"
    "eu-west-1b" = "subnet-6bd78431"
    "eu-west-1c" = "subnet-6a72630c"
  }
}

# Security Group

variable "cidr_blocks" {
  default     = "0.0.0.0/0"
  description = "CIDR for sg"
}

variable "sg_name" {
  default     = "OpenEdX security group"
  description = "Security Group to OpenEdX"
}