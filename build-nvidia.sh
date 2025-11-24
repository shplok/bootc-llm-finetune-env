#!/bin/bash
set -e

cd shared
podman build -t localhost/bootc-llm-base:latest -f Containerfile.base .
cd ../nvidia
podman build -t localhost/bootc-llm-nvidia:latest -f Containerfile .
cd ..