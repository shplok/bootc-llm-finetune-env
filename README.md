# bootc-llm-finetune-env

A containerized environment for fine-tuning large language models with GPU support (NVIDIA/AMD).

## Features

- Containerized with bootc for reproducible environments
- GPU-accelerated training (NVIDIA CUDA / AMD ROCm)
- YAML-based configuration (no code changes needed)
- Pre-configured with PyTorch, Transformers, and ML tools
- Ready-to-use training scripts

## Prerequisites

- Podman installed
- NVIDIA or AMD GPU with drivers installed
- Basic familiarity with YAML

## Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/shplok/bootc-llm-finetune-env
cd bootc-llm-finetune-env
```

### 2. Build the Container

**For NVIDIA GPUs:**
```bash
./build-nvidia.sh
```

**For AMD GPUs:**
```bash
./build-amd.sh
```

This will take several minutes as it downloads and installs CUDA/ROCm toolkits.

### 3. Configure Training

Edit `shared/scripts/config.yaml` to customize your fine-tuning:

```yaml
model:
  name: gpt2  # Change to your model (e.g., meta-llama/Llama-2-7b-hf)

dataset:
  name: wikitext  # Change to your dataset
  subset: wikitext-2-raw-v1

training:
  num_epochs: 3
  learning_rate: 2e-5
  batch_size: 4
  # ... more settings
```

### 4. Run Training

**For NVIDIA:**
```bash
./run-nvidia.sh
```

**For AMD:**
```bash
./run-amd.sh
```

Inside the container:
```bash
/opt/llm-setup/finetune.sh /opt/llm-setup/config.yaml
```

## Configuration Options

### Model Settings
- `model.name`: HuggingFace model ID or local path
- `model.device_map`: Device mapping strategy (usually "auto")

### Dataset Settings
- `dataset.name`: HuggingFace dataset name
- `dataset.subset`: Dataset subset/configuration
- `dataset.split`: Which split to use (train/validation/test)
- `dataset.text_column`: Column containing text data
- `dataset.max_length`: Maximum sequence length for tokenization

### Training Settings
- `training.num_epochs`: Number of training epochs
- `training.learning_rate`: Learning rate
- `training.batch_size`: Batch size per device
- `training.warmup_steps`: Number of warmup steps
- `training.output_dir`: Where to save the fine-tuned model
- `training.fp16`: Enable mixed precision training (recommended)

## Project Structure

```
bootc-llm-finetune-env/
├── shared/
│   ├── Containerfile.base       # Base image with dependencies
│   └── scripts/
│       ├── finetune.sh          # Training launcher
│       ├── train.py             # Training script
│       └── config.yaml          # Configuration file
├── nvidia/
│   └── Containerfile            # NVIDIA GPU-specific setup
├── amdgpu/
│   └── Containerfile            # AMD GPU-specific setup
├── build-nvidia.sh              # Build script for NVIDIA
├── build-amd.sh                 # Build script for AMD
├── run-nvidia.sh                # Run script for NVIDIA
└── README.md
```

## Mounted Volumes

When running the container, you can mount additional directories:

```bash
podman run --rm -it \
  <gpu-flags> \
  -v $(pwd)/data:/data:ro \
  -v $(pwd)/outputs:/outputs \
  localhost/bootc-llm-nvidia:latest
```

Then update your config to use these paths:
```yaml
dataset:
  name: /data/my-dataset

training:
  output_dir: /outputs
```

## Troubleshooting

### GPU Not Detected

Check if PyTorch sees your GPU:
```bash
python -c "import torch; print(f'CUDA available: {torch.cuda.is_available()}')"
```

If False, verify:
- GPU drivers are installed on host
- Correct device flags in run script
- NVIDIA libraries are properly mounted (for NVIDIA)

### Out of Memory

Reduce in your config:
- `training.batch_size`
- `dataset.max_length`
- Consider enabling gradient accumulation

### Model Not Found

Ensure:
- Model name is correct (check HuggingFace)
- You have internet access (or model is downloaded locally)
- HuggingFace token is set if using gated models

## Advanced Usage

### Using Custom Datasets

Mount your local dataset:
```bash
-v $(pwd)/my-data:/custom-data:ro
```

Update config:
```yaml
dataset:
  name: /custom-data
```

### Using LoRA/PEFT

Enable in config:
```yaml
lora:
  enabled: true
  r: 8
  lora_alpha: 16
  target_modules:
    - q_proj
    - v_proj
```

### Multiple Configs

Create different configs for different experiments:
```bash
cp shared/scripts/config.yaml shared/scripts/config-llama.yaml
# Edit config-llama.yaml
/opt/llm-setup/finetune.sh /opt/llm-setup/config-llama.yaml
```

## Contributing

Contributions welcome! Please open an issue or pull request.

## License

[Add your license here]