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
  --template-body file://ecs-task-definition-my-nginx.json
	
# Check if the last command was successful
if [ $? -ne 0 ]; then
  echo "Previous command failed, exiting $0"
  exit 1
fi

echo "Waiting for Stack to be complete ..."

aws cloudformation wait stack-create-complete \
	    --stack-name $STACK_NAME

echo "Complete."
