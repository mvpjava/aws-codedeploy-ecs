#!/bin/sh

echo "$0: Creating all stacks ..."
./create-ecs-cluster-stack.sh ecs-cluster

# Check if the last command was successful
if [ $? -ne 0 ]; then
  echo "Previous command failed, exiting $0"
  exit 1
fi

./create-ecs-task-stack.sh ecs-task

if [ $? -ne 0 ]; then
  echo "Previous command failed, exiting $0"
  exit 1
fi

./create-ecs-service-stack.sh ecs-service

if [ $? -ne 0 ]; then
  echo "Previous command failed, exiting $0"
  exit 1
fi

echo "$0 Complete."
