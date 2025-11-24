#!/bin/bash
set -e

podman run --rm -it \
  --device /dev/nvidia0 \
  --device /dev/nvidiactl \
  --device /dev/nvidia-uvm \
  --device /dev/nvidia-modeset \
  -v /usr/lib/x86_64-linux-gnu/nvidia:/usr/lib/x86_64-linux-gnu/nvidia:ro \
  -v /usr/lib/x86_64-linux-gnu/libcuda.so.1:/usr/lib64/libcuda.so.1:ro \
  -v /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.1:/usr/lib64/libnvidia-ml.so.1:ro \
  localhost/bootc-llm-nvidia:latest