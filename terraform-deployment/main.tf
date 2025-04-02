provider "aws" {
  region = "eu-north-1"  # Set the region to EU-North-1 for your project
}

# Security Group that allows SSH, HTTP, and HTTPS access
resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http"
  description = "Allow SSH, HTTP, and HTTPS"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from any IP (be more restrictive in production)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP access from any IP
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTPS access from any IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow outbound traffic
  }
}

# EC2 instance
resource "aws_instance" "app_server" {
  ami           = "ami-04542995864e26699"  # Change to the AMI you want to use (Ubuntu 22.04)
  instance_type = "t3.medium"  # Adjust instance type based on your requirements

  security_groups = [aws_security_group.allow_ssh_http.name]

  key_name = "jenkins-key-das"  # Ensure this matches your SSH key name

  tags = {
    Name = "DockerAppServer"  # You can customize this tag to suit your project
  }
}

# SSH Key Pair
resource "aws_key_pair" "deployer" {
  key_name   = "jenkins-key-das"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDcsWBjfmi87OD2bTG64qoQWUhoIOSAm4LXU0rmSZQVWdEl7YShzWjyzQokW4L5OY6trjOYvGAx2c7XnC/VqFTaAaFordzncCO4vGvEm43OWy6HpFgdDGp8cVBL8fBZxFA44P176NlPkO50SwSVEoGvUcu/E7g/ueF80uZaRdyIwlm9cdcNDyuwZII19XJp7PBFfi3Vpr/YHCA2YcoGgvTLxKKTOS1OcsBgmdISV4w13n584Tsv+Db0ErfdrmCcjW7JxNOlE3fey3/Xsw7yhOl8gF4T4R25Vm/EL5bopYJ8LzsDr7CUnloIUlv60yexw6K9Qp6bz5gxCcOV+f5Rn9bZ"
}
