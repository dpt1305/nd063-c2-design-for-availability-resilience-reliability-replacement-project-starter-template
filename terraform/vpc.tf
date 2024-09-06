variable "vpc_name" {
  type = object({
    primary_vpc = string,
    secondary_vpc = string
  })
	default = {
			primary_vpc = "primary_vpc"
			secondary_vpc = "secondary_vpc"
	}
}
variable "primary_vpc_parameter" {
	type = object({
		VpcName = string,
	})
	default = {
		VpcName = "PrimaryVpc"
	} 
}
	# type = list(
	# 	object({
	# 		ParameterKey = string,
	# 		ParameterValue = string,
	# 	})
	# ) 
	# default = [{
	# 	ParameterKey = "VpcName",
	# 	ParameterValue = "PrimaryVpc"
	# }]

resource "aws_cloudformation_stack" "primary_vpc" {
  name = "primary-vpc-stack"
	parameters = var.primary_vpc_parameter
  template_body = file("../cloudformation/vpc.yaml")
	provider = aws.az1
}

# resource "aws_cloudformation_stack" "secondary_vpc" {
#   name = var.vpc_name.secondary_vpc
#   template_body = file("../cloudformation/vpc.yaml")
# }


