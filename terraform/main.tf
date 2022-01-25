provider "aws" {
  region = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

###########
# Instances
###########

resource "aws_instance" "MongoDB" {
  ami                    = "${var.instance_ami_mongo}"
  instance_type          = "${var.instance_type_mongo}"
  subnet_id              = "${lookup(var.subnet_ids, var.region)}"
  vpc_security_group_ids = ["${aws_security_group.mongo.id}"]

  count = "${var.total_instances}"

  tags {
    Name = "${var.instance_prefix_mongo}${count.index + 1}"
  }

  associate_public_ip_address = true
}



resource "aws_instance" "OpenEdX" {
	ami 			= "${var.instance_ami_openedx}"
	instance_type 	= "${var.instance_type_openedx}"
	tags {
	  Name = "${var.instance_type_openedx}"
    }
	associate_public_ip_address = true
}


resource "aws_elasticache_cluster" "memcached" {
  cluster_id           = "${var.cluster_id_memcached}"
  engine               = "${var.engine_memcached}"
  node_type            = "${var.node_type_memcached}"
  num_cache_nodes      = 1
  parameter_group_name = "${var.parameter_group_name_memcached}"
  port                 = 11211
}



resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "${var.cluster_id_redis}"
  engine               = "${var.engine_redis}"
  node_type            = "${var.node_type_redis}"
  num_cache_nodes      = 1
  parameter_group_name = "${var.parameter_group_name_redis}"
  engine_version       = "${var.engine_version_redis}"
  port                 = 6379
}


resource "aws_db_instance" "rds" {
  allocated_storage    = 100
  engine               = "${var.engine_rds}"
  engine_version       = "${var.engine_version_rds}"
  instance_class       = "${var.instance_class_rds}"
  name                 = "${var.name_rds}"
  username             = "${var.username_rds}"
  password             = "${var.password_rds}"
  parameter_group_name = "${var.parameter_group_rds}"
  skip_final_snapshot  = true
  replicate_source_db = "aws_db_instance.rds.id"
}


################
# Security Group
################

resource "aws_security_group" "MongoDB" {
  name   = "${var.sg_name}"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.sg_name}"
  }
}

###############
# Elastic IP
###############

resource "aws_eip" "MongoDB" {
  count    = "${var.total_instances}"
  instance = "${element(aws_instance.MongoDB.*.id, count.index)}"
  vpc      = true
}

resource "aws_eip" "OpenEdX" {
  count    = 1
  instance = "${aws_instance.OpenEdX.id}"
  vpc      = true
}
