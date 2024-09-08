# variable "bucket_name" {
#   type = string
# 	default = "udacity-bucket-tungjj-20240908-0705"
# }

# # ---------- S3 bucket ----------
# resource "aws_s3_bucket" "udacity_bucket" {
#   bucket = var.bucket_name
# 	provider = aws.az1

#   tags = {
#     Name        = "Udacity-bucket"
#     Environment = "Dev"
#   }
# }
# resource "aws_s3_bucket_versioning" "versioning_example" {
#   bucket = aws_s3_bucket.udacity_bucket.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }
# resource "aws_s3_bucket_policy" "my_static_website_policy" {
#   bucket = aws_s3_bucket.udacity_bucket.id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = "*"
#         Action = "s3:GetObject"
#         Resource = "${aws_s3_bucket.udacity_bucket.arn}/project/s3/*"
#       }
#     ]
#   })
# }