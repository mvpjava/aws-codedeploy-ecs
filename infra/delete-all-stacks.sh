#!/bin/sh

ECS_SERVICE_STACK_NAME=ecs-service

aws cloudformation delete-stack --stack-name $ECS_SERVICE_STACK_NAME

echo "Waiting for stack $ECS_SERVICE_STACK_NAME to be deleted ..."

aws cloudformation wait stack-delete-complete --stack-name $ECS_SERVICE_STACK_NAME

# Check if the last command was successful
if [ $? -ne 0 ]; then
  echo "Previous command failed, exiting $0"
  exit 1
fi

echo "stack $ECS_SERVICE_STACK_NAME deleted"

#######################################################################
ECS_TASK_STACK_NAME=ecs-task

aws cloudformation delete-stack --stack-name $ECS_TASK_STACK_NAME

echo "Waiting for stack $ECS_TASK_STACK_NAME to be deleted ..."

aws cloudformation wait stack-delete-complete --stack-name $ECS_TASK_STACK_NAME

# Check if the last command was successful
if [ $? -ne 0 ]; then
  echo "Previous command failed, exiting $0"
  exit 1
fi

echo "stack $ECS_TASK_STACK_NAME deleted"

###################################################################

ECS_CLUSTER_STACK_NAME=ecs-cluster

aws cloudformation delete-stack --stack-name $ECS_CLUSTER_STACK_NAME

echo "Waiting for stack $ECS_CLUSTER_STACK_NAME to be deleted ..."

aws cloudformation wait stack-delete-complete --stack-name $ECS_CLUSTER_STACK_NAME

# Check if the last command was successful
if [ $? -ne 0 ]; then
  echo "Previous command failed, exiting $0"
  exit 1
fi

echo "stack $ECS_CLUSTER_STACK_NAME deleted"

echo "script complete"
