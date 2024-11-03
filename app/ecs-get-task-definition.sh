#!/bin/sh -ex

clear

TASK_DEFN_NAME="my-nginx-task"

if [ "$#" -ne 1 ]; then
  echo "task definition name not specified, using default value of 'my-nginx-task'"
else
  TASK_DEFN_NAME=$1
fi

echo "Getting task definition and saving to file $TASK_DEFN_NAME-definition.json"

aws ecs describe-task-definition --task-definition $TASK_DEFN_NAME --query "taskDefinition" --output json > "$TASK_DEFN_NAME-definition.json"

echo "$0 Complete"
