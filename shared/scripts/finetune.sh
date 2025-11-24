#!/bin/bash
set -e

MODEL=$1
DATASET=$2

accelerate launch \
    /opt/llm-setup/train.py \
    --model $MODEL \
    --dataset $DATASET \
    --lr 2e-5 \
    --batch_size 4 \
    --epochs 3
