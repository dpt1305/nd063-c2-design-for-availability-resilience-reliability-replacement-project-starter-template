variable "primary_vpc_parameter" {
	type = object({
		VpcName 					= string,
		VpcCIDR 					= string,
		PublicSubnet1CIDR = string,
		PublicSubnet2CIDR = string,
		PrivateSubnet1CIDR = string,
		PrivateSubnet2CIDR = string,
	})
	
	default = {
		VpcName 					= "Primary",
		VpcCIDR 					= "10.1.0.0/16",
		PublicSubnet1CIDR = "10.1.10.0/24",
		PublicSubnet2CIDR = "10.1.11.0/24",
		PrivateSubnet1CIDR = "10.1.20.0/24",
		PrivateSubnet2CIDR = "10.1.21.0/24",
	} 
}
variable "secondary_vpc_parameter" {
	type = object({
		VpcName 					= string,
		VpcCIDR 					= string,
		PublicSubnet1CIDR = string,
		PublicSubnet2CIDR = string,
		PrivateSubnet1CIDR = string,
		PrivateSubnet2CIDR = string,
	})
	
	default = {
		VpcName 					= "Secondary",
		VpcCIDR 					= "10.2.0.0/16",
		PublicSubnet1CIDR = "10.2.10.0/24",
		PublicSubnet2CIDR = "10.2.11.0/24",
		PrivateSubnet1CIDR = "10.2.20.0/24",
		PrivateSubnet2CIDR = "10.2.21.0/24",
	} 
}

# ------------ Stack -------------
resource "aws_cloudformation_stack" "primary_stack" {
  name = "cd1908-project-stack"
  parameters = var.primary_vpc_parameter
  template_body = file("../cloudformation/vpc.yaml")
	provider = aws.az1
}
# resource "aws_cloudformation_stack" "secondary_stack" {
#   name = "cd1908-project-stack-secondary"
# 	parameters = var.secondary_vpc_parameter
#   template_body = file("../cloudformation/vpc.yaml")
# 	provider = aws.az2
# }




