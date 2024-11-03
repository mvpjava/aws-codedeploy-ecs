#!/bin/sh

echo "$0 started"

APPSPEC_FILE="./appspec.json"
TASK_DEFN_NAME=my-nginx-task

if [ "$#" -ne 1 ]; then
  echo "task definition name not specified, using default value of 'my-nginx-task'"
else
  TASK_DEFN_NAME=$1
fi

TASK_ARN=`aws ecs describe-task-definition \
    --task-definition $TASK_DEFN_NAME \
    --query 'taskDefinition.taskDefinitionArn' \
    --output text`

echo "Updating $APPSPEC_FILE with TaskDefinition: $TASK_ARN"

sed -i "s|\"TaskDefinition\": \"arn:.*\"|\"TaskDefinition\": \"$TASK_ARN\"|" "$APPSPEC_FILE"


CONTAINER_NAME=`aws ecs describe-task-definition \
    --task-definition $TASK_DEFN_NAME \
    --query 'taskDefinition.containerDefinitions[].name' \
    --output text`

echo "Updating $APPSPEC_FILE with ContainerName: $CONTAINER_NAME"

sed -i "s|\"ContainerName\": .*\"|\"ContainerName\": \"$CONTAINER_NAME\"|" "$APPSPEC_FILE"


CONTAINER_PORT=`aws ecs describe-task-definition \
    --task-definition $TASK_DEFN_NAME \
    --query 'taskDefinition.containerDefinitions[].portMappings[].containerPort' \
    --output text`

echo "Updating $APPSPEC_FILE with ContainerPort: $CONTAINER_PORT"

sed -i "s|\"ContainerPort\": .*\"|\"ContainerPort\": \"$CONTAINER_PORT\"|" "$APPSPEC_FILE"

echo "Dumping $APPSPEC_FILE"
cat $APPSPEC_FILE

echo "$0 complete."
