#!/bin/bash
# arrancar_gpt4all.sh - versión 1 (05/11/26)
# Uso: ./arrancar_gpt4all.sh 

GPT4ALL_BIN="/opt/gpt4all/bin/chat"     # ejecutable instalado mediante instalador oficial (fichero binario) 

#HOST="127.0.0.1"
#PUERTO="8080"
#MODELO_GGUF_1="/root/modelos/Qwen3.5-0.8B-Q8_0.gguf"
#MODELO_GGUF_2="/root/modelos/Llama-3.2-1B-Instruct-Q4_0.gguf"

#MODELO="${1:-$MODELO_GGUF_1}"

#if [ -f "$MODELO" ]; then
    "$GPT4ALL_BIN" & #-m "$MODELO" --reasoning off --host "$HOST" --port "$PUERTO"
#else
#   echo "No existe el modelo: $MODELO"
#fi
