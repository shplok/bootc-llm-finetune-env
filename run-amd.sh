#!/bin/bash
set -e

podman run --rm -it \
  --device /dev/kfd \
  --device /dev/dri \
  --security-opt=label=disable \
  localhost/bootc-llm-amd:latest