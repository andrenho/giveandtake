#!/bin/sh

./destroy_jenkins.sh $1 $2 -auto-approve
./create_jenkins.sh $1 $2 -auto-approve
