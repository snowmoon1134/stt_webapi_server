from transformers import AutoModelForSpeechSeq2Seq, AutoProcessor
import torch
import numpy as np
import librosa
import io


device = "cuda:0" if torch.cuda.is_available() else "cpu"
torch_dtype = torch.float16 if torch.cuda.is_available() else torch.float32

# TODO: Modelを動的に選択し、reloadするように修正
model_id = "openai/whisper-large-v3-turbo"
# model_id = "openai/whisper-tiny"

model = AutoModelForSpeechSeq2Seq.from_pretrained(
    model_id, torch_dtype=torch_dtype, low_cpu_mem_usage=True, use_safetensors=True
).to(device)
processor = AutoProcessor.from_pretrained(model_id)
