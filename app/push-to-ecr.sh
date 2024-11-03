#!/bin/sh -x

clear

echo "Starting $0 to push image to ECR registry"

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <Image name with tagged version. Example:  403177882230.dkr.ecr.eu-west-2.amazonaws.com/my-nginx:1.0>"
  exit 1
fi

# Retrieve an authentication token and authenticate your Docker client to your registry. Use the AWS CLI:
aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin 403177882230.dkr.ecr.eu-west-2.amazonaws.com

docker push $1

echo "$0 Complete."
