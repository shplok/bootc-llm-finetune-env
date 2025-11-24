#!/bin/bash
set -e

cd shared
podman build -t localhost/bootc-llm-base:latest -f Containerfile.base .
cd ../amdgpu
podman build -t localhost/bootc-llm-amd:latest -f Containerfile .
cd ..