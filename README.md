1.  
*

2.  

(https://github.com/Danil054/devops-netology/blob/main/atlantis/server.yaml)
(https://github.com/Danil054/devops-netology/blob/main/atlantis/atlantis.yaml)

3.  

Что-то от aws прям с пометкой официально модуля найти не смог, зато сразу находится модуль:  

(https://github.com/terraform-aws-modules/terraform-aws-ec2-instance)  
Использовать его особо смысла не вижу для себя на данном этапе, можно обойтись и aws_instance, если бы вообще aws пускало и дало зарегистрировать карту   
Если посмотреть его main.tf и что там сейчас на первых строчках:  
```
locals {
  create = var.create && var.putin_khuylo
```
То вообще отпадает желание пользоваться данным модулем.  

Создание инстансана через модуль, думаю, выглядело бы так:  
```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "tf"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "tf"
  }
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "single-instance"

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.my_subnet.id

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

```
проверить нет возможности, так как не зарегистрироваться нормально на aws.
