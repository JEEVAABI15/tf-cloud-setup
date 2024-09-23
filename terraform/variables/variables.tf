resource "aws_instance" "my_ec2_instance" {
  ami           = "ami-0325d027fd604b49a" 
  instance_type = "t2.micro"  

  key_name = "keydemo"      

  tags = {
    Name = "MyCustomAMIInstance"
  }
}

variable "aws_region" {
  description = "The AWS region to deploy in"
  default     = "us-west-2" 
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-0325d027fd604b49a"
}

variable "instance_type" {
  description = "Instance type"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair name"
  default     = "keydemo"
}

