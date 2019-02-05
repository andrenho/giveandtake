#!/bin/sh

# see https://read.acloud.guru/deploy-a-jenkins-cluster-on-aws-35dcf66a1eca

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 ACCESS_KEY SECRET_KEY"
    exit 1
fi

#
# generate keys
#

if [ ! -f "jenkins_aws.pem" ]; then
    pushd .
    cd ~/.ssh
    yes y | ssh-keygen -t rsa -b 2048 -v -f jenkins_aws -P ""
    popd
    cat ~/.ssh/jenkins_aws.pub > jenkins_aws.pub
    cat ~/.ssh/jenkins_aws     > jenkins_aws.pem
    chmod 400 jenkins_aws.pem
fi

#
# execute terraform
#

terraform init
terraform apply -var "access_key=$1" -var "secret_key=$2"

echo
echo "Connect to ssh with: ssh -i jenkins_aws.pem ec2-user@`cat public_ip.txt`"
echo "Jenkins available at http://`cat public_ip.txt`:8080"

# vim:ts=4:sw=4:sts=4:expandtab
