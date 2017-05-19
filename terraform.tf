

provider "aws" {}

resource "aws_vpc" "redis-chef-hab" {
    cidr_block              =   "172.33.0.0/16"
    enable_dns_hostnames    =   true
    enable_dns_support      =   true
}

resource "aws_subnet" "redis-chef-hab" {
    vpc_id                  =   "${aws_vpc.redis-chef-hab.id}"
    cidr_block              =   "172.33.0.0/16"
    availability_zone       =   "us-west-2a"
}

resource "aws_security_group" "hab" {
    description             =   "Required communication for a habitat supervisor"
    vpc_id                  =   "${aws_vpc.redis-chef-hab.id}"

    ingress {
        from_port           =   9631
        to_port             =   9631
        protocol            =   "tcp"
        cidr_blocks         =   ["172.33.0.0/16"]
    }

    ingress {
        from_port           =   9638
        to_port             =   9638
        protocol            =   "tcp"
        cidr_blocks         =   ["172.33.0.0/16"]
    }

    ingress {
        from_port           =   9638
        to_port             =   9638
        protocol            =   "udp"
        cidr_blocks         =   ["172.33.0.0/16"]
    }

    ingress {
        from_port           =   22
        to_port             =   22
        protocol            =   "tcp"
        cidr_blocks         =   ["0.0.0.0/0"]
    }

    egress {
        from_port           =   0
        to_port             =   0
        protocol            =   "-1"
        cidr_blocks         =   ["0.0.0.0/0"]
    }
}

resource "aws_instance" "redis-node-1" {
    ami                     =   "ami-70b67d10"
    subnet_id               =   "${aws_subnet.redis-chef-hab.id}"
    availability_zone       =   "us-west-2a"
    private_ip              =   "172.33.54.10"
    instance_type           =   "t2.micro"
    vpc_security_group_ids  =   ["${aws_security_group.hab.id}"]
}

resource "aws_instance" "redis-node-2" {
    ami                     =   "ami-70b67d10"
    subnet_id               =   "${aws_subnet.redis-chef-hab.id}"
    availability_zone       =   "us-west-2a"
    private_ip              =   "172.33.54.11"
    instance_type           =   "t2.micro"
    vpc_security_group_ids  =   ["${aws_security_group.hab.id}"]
}

resource "aws_instance" "redis-node-3" {
    ami                     =   "ami-70b67d10"
    subnet_id               =   "${aws_subnet.redis-chef-hab.id}"
    availability_zone       =   "us-west-2a"
    private_ip              =   "172.33.54.12"
    instance_type           =   "t2.micro"
    vpc_security_group_ids  =   ["${aws_security_group.hab.id}"]
}