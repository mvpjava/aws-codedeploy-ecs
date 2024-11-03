#!/bin/sh

echo "Start $0 to remove all my-nginx images"


# lists the IDs of all stopped or running containers with "my-nginx" in their name
# xargs -r docker rm removes each of those containers
docker ps -a -q --filter "name=my-nginx" | xargs -r docker rm -f

# docker images -q --filter=reference='*my-nginx*': Lists the image IDs of all images that contain "my-nginx" in their name or tag.
# xargs -r docker rmi: Passes the list of image IDs to docker rmi for deletion, skipping if there are no matching images (-r flag with xargs).
docker images -q --filter=reference='*my-nginx*' | xargs -r docker rmi -f

echo "$0 Complete"
