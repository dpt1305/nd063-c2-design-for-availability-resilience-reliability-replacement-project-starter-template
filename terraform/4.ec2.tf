# ----- Key pairs
resource "aws_key_pair" "udacity_key_active" {
  key_name   = "udacity-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC4nD52xDBp38o0m5m7BQDmZWilZwBOYE9SrrSIgbFRt17f3TMbvO6ak4rVjHs0M1Vwttlh5s1jYCdH38r16fh+PiXvVTfkZ3FL03EbiJOJyTJJIe9tMFOpm6rB+TOiIypWnzIrJMNIjnTyjw6WD6/03fKqSI9UthCNjf8qNEGAqAEEZ4j+H4ypiVqVLk+RYd76LJHtM0ucVCgGXaRHy1UVZ3HEKmOhf2D4Pi3QG4ensbiqFFHEvppPhxfSNvn+K3a/0jFU8W9ZnbAFOyxEEhDWsDPSwYgeXJDeQtzsQYa0qhGna/RTwOHdElZSZXUiyAO2Jvzk3ldqNPUI2zxOFlcZUGrjaSJTuimdJlvbFSC0V2otmdmNid9KbJULTFBl6tN9l3iJq3y0Ne9nVVqkWRAQHkrO0/ho6tahyLz/VZnyXKU8IVMNdj+9RkxzUD1KHeMc9x/o7Yr35069rw3vfLbX3nqVxZO73AZj5vTofoMlJFLgiJt3SQ/HvFPSz9D/TbMh9oA+fJdo7e160JmSi4hrV+ftoYTyjuwvU+UejcF1TiziChupDrcaR92xa2nm0QP0am6KJS2jG293LEeYm0skF/V9N5vWbuiXaJGGX0EAEI2KW8qtgxJx8dTmi/54mDvXEZf8X9zzS+GlbQlKSg2Bn8acP7cJsT6BemNhO/gB2Q== tungplatin@gmail.com"
	provider = aws.az1
}
resource "aws_key_pair" "udacity_key_standby" {
  key_name   = "udacity-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC4nD52xDBp38o0m5m7BQDmZWilZwBOYE9SrrSIgbFRt17f3TMbvO6ak4rVjHs0M1Vwttlh5s1jYCdH38r16fh+PiXvVTfkZ3FL03EbiJOJyTJJIe9tMFOpm6rB+TOiIypWnzIrJMNIjnTyjw6WD6/03fKqSI9UthCNjf8qNEGAqAEEZ4j+H4ypiVqVLk+RYd76LJHtM0ucVCgGXaRHy1UVZ3HEKmOhf2D4Pi3QG4ensbiqFFHEvppPhxfSNvn+K3a/0jFU8W9ZnbAFOyxEEhDWsDPSwYgeXJDeQtzsQYa0qhGna/RTwOHdElZSZXUiyAO2Jvzk3ldqNPUI2zxOFlcZUGrjaSJTuimdJlvbFSC0V2otmdmNid9KbJULTFBl6tN9l3iJq3y0Ne9nVVqkWRAQHkrO0/ho6tahyLz/VZnyXKU8IVMNdj+9RkxzUD1KHeMc9x/o7Yr35069rw3vfLbX3nqVxZO73AZj5vTofoMlJFLgiJt3SQ/HvFPSz9D/TbMh9oA+fJdo7e160JmSi4hrV+ftoYTyjuwvU+UejcF1TiziChupDrcaR92xa2nm0QP0am6KJS2jG293LEeYm0skF/V9N5vWbuiXaJGGX0EAEI2KW8qtgxJx8dTmi/54mDvXEZf8X9zzS+GlbQlKSg2Bn8acP7cJsT6BemNhO/gB2Q== tungplatin@gmail.com"
	provider = aws.az2
}

# -------- EC2 instance 
resource "aws_instance" "udacity_ec2_active" {
	# Amazon Linux 2023 AMI
  ami           	= "ami-0182f373e66f89c85"   
  instance_type 	= "t2.micro"
	subnet_id     	= resource.aws_cloudformation_stack.primary_stack.outputs["PublicSubnetId1"] 
	security_groups = [
		resource.aws_cloudformation_stack.primary_stack.outputs["ApplicationSecurityGroup"] 
	]
	key_name 				= resource.aws_key_pair.udacity_key_active.key_name

  tags = {
    Name = "udacity_ec2_active"
  }
	provider = aws.az1
}
resource "aws_instance" "udacity_ec2_standby" {
	# Amazon Linux 2023 AMI
  ami           	= "ami-0182f373e66f89c85"   
  instance_type 	= "t2.micro"
	subnet_id     	= resource.aws_cloudformation_stack.secondary_stack.outputs["PublicSubnetId1"] 
	security_groups = [
		resource.aws_cloudformation_stack.secondary_stack.outputs["ApplicationSecurityGroup"] 
	]
	key_name 				= resource.aws_key_pair.udacity_key_standby.key_name
 
  tags = {
    Name = "udacity_ec2_standby"
  }
	provider = aws.az2
} 