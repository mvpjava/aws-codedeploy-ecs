#!/bin/sh -ex

clear

# If a version parameter is provided, use it; otherwise, read it from the file
if [ -n "$1" ]; then
    VERSION="$1"
else
    VERSION=1.0
fi

HTML_FILE="index.html"
ECR_URI="403177882230.dkr.ecr.eu-west-2.amazonaws.com/my-nginx:$VERSION"

# Update the version in index.html
sed -i "s/Version: [0-9.]\+/Version: $VERSION/" "$HTML_FILE"

# Build and run the Docker container with the specified version tag
docker build -t "my-nginx:$VERSION" .

#Tag it for ECR registry which has already been set up
docker tag "my-nginx:$VERSION" $ECR_URI

# Push the tagged image to ECR
./push-to-ecr.sh $ECR_URI

#Listing all docker images with name my-nginx in it
docker images | grep my-nginx

# Clean up any containers left around from previous runs since container name is hardcoded
# This is just from local testing used for demo purposes
docker container rm -f my-nginx-container 2>/dev/null

docker run -it --rm -d -p 8081:80 --name "my-nginx-container" "my-nginx:$VERSION"

# Output the version being used
echo "Built and ran Docker image with version: $VERSION"
exit 0
