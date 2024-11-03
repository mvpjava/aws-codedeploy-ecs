#!/bin/sh

echo "$0 started"

TASK_DEFN_NAME=my-nginx-task

TASK_ARN=`aws ecs describe-task-definition \
    --task-definition $TASK_DEFN_NAME \
    --query 'taskDefinition.taskDefinitionArn' \
    --output text`

echo "TASK Definition ARN: $TASK_ARN"

aws ecs describe-task-definition \
    --task-definition $TASK_DEFN_NAME \
    --query 'taskDefinition.containerDefinitions[].name' \
    --output text

aws ecs describe-task-definition \
    --task-definition $TASK_DEFN_NAME \
    --query 'taskDefinition.containerDefinitions[].portMappings[].containerPort' \
    --output text

echo "$0 complete."
