import argparse
from transformers import AutoModelForCausalLM, AutoTokenizer, Trainer, TrainingArguments

parser = argparse.ArgumentParser()
parser.add_argument("--model")
parser.add_argument("--dataset")
parser.add_argument("--lr", type=float, default=2e-5)
parser.add_argument("--epochs", type=int, default=3)
args = parser.parse_args()

print("placeholder")
