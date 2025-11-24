#!/bin/bash
set -e

CONFIG=$1

if [ -z "$CONFIG" ]; then
    echo "Usage: finetune.sh <config.yaml>"
    exit 1
fi

accelerate launch \
    /opt/llm-setup/train.py \
    --config $CONFIG