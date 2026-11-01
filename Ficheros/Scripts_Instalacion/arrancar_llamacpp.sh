#!/bin/bash
# arrancar_llamacpp.sh - versión 3 (01/11/26)
# Uso: ./arrancar_llamacpp.sh [ruta_del_modelo.gguf]   (sin argumento, usa el modelo 1)

LLAMA_BIN="/usr/local/bin/llama-server"     # ejecutable instalado desde código fuente
HOST="127.0.0.1"
PUERTO="8080"
MODELO_GGUF_1="/root/modelos/Qwen3.5-0.8B-Q8_0.gguf"
MODELO_GGUF_2="/root/modelos/Llama-3.2-1B-Instruct-Q4_0.gguf"

MODELO="${1:-$MODELO_GGUF_1}"

if [ -f "$MODELO" ]; then
    "$LLAMA_BIN" -m "$MODELO" --reasoning off --host "$HOST" --port "$PUERTO"
else
    echo "No existe el modelo: $MODELO"
fi
