#!/bin/sh

echo "$0 started"

TASK_REVISION_FILE="./task-new-rev-def-template.json"

LATEST_IMAGE_TAG=$(docker images 403177882230.dkr.ecr.eu-west-2.amazonaws.com/my-nginx --format "{{.Repository}}:{{.Tag}}" | head -n 1)

echo "Latest Image Tag: $LATEST_IMAGE_TAG"

echo "Updating $TASK_REVISION_FILE with  container image: $LATEST_IMAGE_TAG"

sed -i "s|\"image\": \".*\"|\"image\": \"$LATEST_IMAGE_TAG\"|" "$TASK_REVISION_FILE"

echo "Dumping $TASK_REVISION_FILE"
cat $TASK_REVISION_FILE

# Register the new task definition (now has updated image with new software version #)
aws ecs register-task-definition --cli-input-json file://$TASK_REVISION_FILE --output table

echo "$0 complete."
