#!/bin/sh

# see https://read.acloud.guru/deploy-a-jenkins-cluster-on-aws-35dcf66a1eca

#docker run -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 ACCESS_KEY SECRET_KEY"
    exit 1
fi

terraform init
terraform apply -var "access_key=$1" -var "secret_key=$1"

# vim:ts=4:sw=4:sts=4:expandtab
