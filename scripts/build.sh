#!/bin/bash

BUILD_TAG="michaukrieg/amazonlinux-occt-cgal-node:${AMAZONLINUX_VERSION}-occt-${OCCT_VERSION}-cgal-${CGAL_VERSION}-node-${NODE_VERSION}"
BUILD_TAG_NODE="michaukrieg/amazonlinux-occt-cgal-node:node-${NODE_VERSION}"

set -x
docker build . \
    --no-cache \
    -t "$BUILD_TAG" \
    -t "$BUILD_TAG_NODE"
    --build-arg amazonlinux_version=$AMAZONLINUX_VERSION \
    --build-arg occt_version=$OCCT_VERSION \
    --build-arg cgal_version=$CGAL_VERSION \
    --build-arg node_version=$NODE_VERSION \

docker run --rm --entrypoint echo "$BUILD_TAG" "Hello world!"