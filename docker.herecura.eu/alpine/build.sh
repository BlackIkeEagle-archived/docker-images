#!/bin/bash

docker build -f Dockerfile-stable -t docker.herecura.eu/alpine:stable .
docker build -f Dockerfile-edge -t docker.herecura.eu/alpine:edge .
