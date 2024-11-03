#!/bin/sh

docker build -t my-nginx:latest .
docker run -it --rm -d -p 8081:80 --name my-nginx-container my-nginx:latest
