# ---------- Variables
variable "database_username" {
	type 				= string
	description = "Username for database"
	default 		= "udacity"	
}
variable "database_password" {
	type				 = string
	description  = "Password for database"
	default			 = "Udacity_123"
}

# ------------- DB Subnet Group ---------------
resource "aws_db_subnet_group" "rds_subnet_group_active" {
  name       = "rds_subnet_group"
  subnet_ids = [
	  resource.aws_cloudformation_stack.primary_stack.outputs["PrivateSubnetId1"],
	  resource.aws_cloudformation_stack.primary_stack.outputs["PrivateSubnetId2"],
	]
	provider = aws.az1
  tags = {
    Name = "Udacity_RDS_Subnet_group"
  }
}
resource "aws_db_subnet_group" "rds_subnet_group_standby" {
  name       = "rds_subnet_group"
  subnet_ids = [
		resource.aws_cloudformation_stack.secondary_stack.outputs["PrivateSubnetId1"],
	  resource.aws_cloudformation_stack.secondary_stack.outputs["PrivateSubnetId2"],
	]
	provider = aws.az2
  tags = {
    Name = "Udacity_RDS_Subnet_group"
  }
}

# ---------- RDS instances --------
resource "aws_db_instance" "rds_active" {
  allocated_storage    = 10
	identifier 					 = "udacity-master"
	db_name 						 = "udacity"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = var.database_username
  password             = var.database_password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
	# Enable Multi-AZ
	multi_az 						 = true
	# Backup 
	backup_retention_period = 1
	
	provider 								= aws.az1
	db_subnet_group_name 		= resource.aws_db_subnet_group.rds_subnet_group_active.name
	vpc_security_group_ids  = [
		resource.aws_cloudformation_stack.primary_stack.outputs["DatabaseSecurityGroup"]
	]
}
resource "aws_db_instance" "rds_standby" {
	replicate_source_db  = resource.aws_db_instance.rds_active.arn
	identifier 					 = "udacity-replica"

  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
	# Enable Multi-AZ
	multi_az 						 = false

	provider 							 = aws.az2
	db_subnet_group_name   = resource.aws_db_subnet_group.rds_subnet_group_standby.name
	vpc_security_group_ids = [
		resource.aws_cloudformation_stack.secondary_stack.outputs["DatabaseSecurityGroup"]
	]
}