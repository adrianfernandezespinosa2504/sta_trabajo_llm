#!/bin/bash
# instalar_llamacpp.sh - version 0 (31/10/26)
set -e                                      #si un comando falla, se para el script

# Variables
LLAMA_DIR_COMP="/root/llama.cpp"             # directorio de codigo fuente y compilacion
# LLAMA_DIR_SERV="/usr/local/bin"           # directorio del ejecutable (arranque de servidor)
COMMIT="5de733437"                          # versión compilada y probada
HOST="127.0.0.1"                            # direccion IP del servidor 
PUERTO="8080"                               # puerto de escucha del servidor

MODELO_GGUF_1="/root/modelos/Qwen3.5-0.8B-Q8_0.gguf"           #nombre modelo LLM 1
MODELO_GGUF_2="/root/modelos/Llama-3.2-1B-Instruct-Q4_0.gguf"  # nombre modelo LLM 2


# Dependencias
dnf install -y git cmake gcc-c++ ninja-build


# Descarga del repo y compilación
[ -d "$LLAMA_DIR_COMP" ] || git clone https://github.com/ggml-org/llama.cpp "$LLAMA_DIR_COMP"
  cd "$LLAMA_DIR_COMP"
  git checkout "$COMMIT"
  cmake -B build
  cmake --build build -j2      # cambiar en funcion de los procesadores de los ltXX

  
# Arranque
"$LLAMA_DIR_COMP/build/bin/llama-server" -hf "$MODELO_HF_1" --host "$HOST" --port "$PUERTO"                  # -hf para descargar en el servidor
"$LLAMA_DIR_COMP/build/bin/llama-server" -m "$MODELO_GGUF" --reasoning off --host "$HOST" --port "$PUERTO"   # -m para descargar del local
