#!/bin/sh

# Check if the required number of parameters is provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <Stack Name>"
  exit 1
fi

STACK_NAME=$1

echo "Creating Stack"

aws cloudformation create-stack \
  --stack-name $STACK_NAME  \
  --template-body file://ecs-create-fargate-cluster-cloudformation.json \
  --parameters \
    ParameterKey=ECSClusterName,ParameterValue="my-ecs-cluster" \
    ParameterKey=LatestECSOptimizedAMI,ParameterValue="/aws/service/ecs/optimized-ami/amazon-linux-2/kernel-5.10/recommended/image_id" \
    ParameterKey=SecurityGroupIds,ParameterValue="sg-8f01a4e9" \
    ParameterKey=SubnetIds,ParameterValue="'subnet-fd3e94b1,subnet-121d7a68,subnet-8c7229e5'" \
    ParameterKey=VpcId,ParameterValue="vpc-2f287947"
	
# Check if the last command was successful
if [ $? -ne 0 ]; then
  echo "Previous command failed, exiting $0"
  exit 1
fi

echo "Waiting for Stack to be complete ..."

aws cloudformation wait stack-create-complete \
	    --stack-name $STACK_NAME

echo "Complete."
