import argparse
import yaml
from transformers import AutoModelForCausalLM, AutoTokenizer, Trainer, TrainingArguments

parser = argparse.ArgumentParser()
parser.add_argument("--config", required=True, help="Path to YAML config file")
args = parser.parse_args()

# Load config from YAML
with open(args.config, 'r') as f:
    config = yaml.safe_load(f)

print(f"Loaded config from: {args.config}")
print(f"Model: {config['model']['name']}")
print(f"Dataset: {config['dataset']['name']}")
print(f"Training epochs: {config['training']['num_epochs']}")

print("placeholder - config loaded successfully")