resource "aws_vpc" "default" {
    cidr_block              = var.vpc_cidr
    enable_dns_hostnames    = var.enable_dns_hostnames
    tags ={
        Name = var.vpc_name
        env  = var.environment
    }
}

resource "aws_internet_gateway" "default" {
    vpc_id   = aws_vpc.default.id
    tags     = {
        Name = "${var.IGW_name}"
    }
}

resource "aws_subnet" "public-subnet" {
    vpc_id            = aws_vpc.default.id
    cidr_block        = var.public_subnet_cidr
    availability_zone = var.availability_zone
    tags = {
        Name = "${var.public_subnet_name}"
    } 
}

resource "aws_route_table" "RT-public" {
    vpc_id = aws_vpc.default.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.default.id
    }

    tags = {
        Name = "${var.Main_Routing_Table}"
    }
 
}

resource "aws_route_table_association" "RT-public" {
    subnet_id      = aws_subnet.public-subnet.id
    route_table_id = aws_route_table.RT-public.id 
}

resource "aws_security_group" "allow_all" {
   name        = "allow_all"
   description = "Allow all inbound traffic"
   vpc_id      =  aws_vpc.default.id      

    ingress  {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress  {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}