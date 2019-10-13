#!/bin/bash

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

for tag in $(docker images michaukrieg/amazonlinux-occt-cgal-node --format "{{.Tag}}");
do
    docker push "michaukrieg/amazonlinux-occt-cgal-node:${tag}"
done