#!/bin/sh

echo "$0 started"

ECR_URI="403177882230.dkr.ecr.eu-west-2.amazonaws.com/my-nginx"
TASK_REVISION_FILE="./task-new-rev-def-template.json"

if [ "$#" -ne 1 ]; then
  # Get latest image:tag built as default when not specified
  ECR_URI=$(docker images $ECR_URI --format "{{.Repository}}:{{.Tag}}" | head -n 1)
  echo "fully qualified Image name not specified. Defaulting to $LATEST_IMAGE_TAG"
else
  ECR_URI=$1
fi

echo "Updating $TASK_REVISION_FILE with  container image: $ECR_URI"

sed -i "s|\"image\": \".*\"|\"image\": \"$ECR_URI\"|" "$TASK_REVISION_FILE"

echo "Dumping $TASK_REVISION_FILE"
cat $TASK_REVISION_FILE

# Register the new task definition (now has updated image with new software version #)
aws ecs register-task-definition --cli-input-json file://$TASK_REVISION_FILE --output json 

echo "$0 complete."
