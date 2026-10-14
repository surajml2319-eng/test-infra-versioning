# Create S3 bucket
resource "aws_s3_bucket" "demo_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "DemoS3Bucket"
    Environment = "Dev"
  }
}

# Create EC2 instance
resource "aws_instance" "demo_ec2" {
  ami = "ami-0b6d9d3d33ba97d99"
  instance_type = var.ec2_instance_type

key_name      = var.key_name

  tags = {
    Name        = "DemoEC2Instance"
    Environment = "Dev"
resource "aws_ec2_instance_state" "instance_state" {
  instance_id = aws_instance.my_instance.id
  state       = "running"
}
}
}
