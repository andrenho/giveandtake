provider "aws" {
    access_key      = "${var.access_key}"
    secret_key      = "${var.secret_key}"
    region          = "${var.region}"
}

# 
# security groups
#

# TODO - remove this
resource "aws_security_group" "allow_ssh" {
    name            = "allow_ssh"
    description     = "Allow SSH inbound"
    
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "allow_8080" {
    name            = "allow_8080"
    description     = "Allow 8080 inbound"
    
    ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "allow_outbound" {
    name            = "allow_all_outbound"
    description     = "Allow all traffic outbound"
    
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

#
# add key
# 
resource "aws_key_pair" "jenkins_key" {
    key_name        = "jenkins_key"
    public_key      = "${file("jenkins_aws.pub")}"   
}

# 
# find AMI image
# 

data "aws_ami" "amazon_linux" {
    most_recent    = true
    
    filter {
        name        = "name"
        values      = ["amzn-ami-hvm-????.??.?.????????-x86_64-gp2"]
    }

    filter {
        name        = "state"
        values      = ["available"]
    }

    owners          = ["amazon"]
}

# 
# EC2 jenkins instance
#

resource "aws_instance" "jenkins" {
    ami             = "${data.aws_ami.amazon_linux.id}"
    instance_type   = "t2.micro"
    key_name        = "${aws_key_pair.jenkins_key.key_name}"

    tags {
        Name        = "jenkins"
    }

    security_groups = [
        "${aws_security_group.allow_ssh.name}",
        "${aws_security_group.allow_8080.name}",
        "${aws_security_group.allow_outbound.name}",
    ]

    provisioner "file" {
        source      = "setup_jenkins_aws.sh"
        destination = "/tmp/setup_jenkins_aws.sh"
    }

    #provisioner "remote-exec" {
    #    inline = [
    #        "chmod +x /tmp/setup_jenkins_aws.sh",
    #        "sudo /tmp/setup_jenkins_aws.sh",
    #    ]
    #}

    connection {
        type    = "ssh"
        user    = "ec2-user"
        timeout = "30s"
        private_key = "${file("jenkins_aws.pem")}"
    }
}

# 
# setup static IP
#

resource "aws_eip" "jenkins_eip" {
    instance        = "${aws_instance.jenkins.id}"

    provisioner "local-exec" {
        command    = "echo ${self.public_ip} > public_ip.txt"
        on_failure = "continue"
    }
}

# vim:ts=4:sw=4:sts=4:expandtab:syntax=conf
