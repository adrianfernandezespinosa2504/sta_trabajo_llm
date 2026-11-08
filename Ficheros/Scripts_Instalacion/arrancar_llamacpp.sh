#!/bin/bash
# arrancar_llamacpp.sh - versión 7 (08/11/26)
# Uso: ./arrancar_llamacpp.sh <id_modelo> 

# Variables
LLAMA_BIN="/usr/local/bin/llama-server"     # ejecutable instalado desde código fuente
DIR_MODELOS="/root/defensa-Fernandez_Espinosa_Adrian/Modelos"
DIR_LOG="/var/log/sta_trabajo"
LOG="$DIR_LOG/llamacpp.log"

HOST="127.0.0.1"
PUERTO="8080"

#MODELO_GGUF_1="$DIR_MODELOS/Qwen3.5-0.8B-Q8_0.gguf" modelo no soportado por GPT4All
MODELO_GGUF_1="$DIR_MODELOS/Llama-3.2-1B-Instruct-Q4_0.gguf" 
MODELO_GGUF_2="$DIR_MODELOS/Phi-3-mini-4k-instruct.Q4_0.gguf"
MODELO_GGUF_3="$DIR_MODELOS/mistral-7b-instruct-v0.1.Q4_0.gguf"

# Selección del modelo
if [[ "$#" -eq 0 || ( "$#" -eq 1 && "$1" = "1" ) ]]; then
    MODELO="$MODELO_GGUF_1"
elif [[ "$#" -eq 1 && "$1" = "2" ]]; then
    MODELO="$MODELO_GGUF_2"
elif [[ "$#" -eq 1 && "$1" = "3" ]]; then
    MODELO="$MODELO_GGUF_3"
else
    echo "Uso: ./arrancar_llamacpp.sh <id_modelo>"
    echo "1: $MODELO_GGUF_1 (predeterminado)"
    echo "2: $MODELO_GGUF_2"
    echo "3: $MODELO_GGUF_3"
fi

# Arranque
if [ -n "$MODELO" ]; then
    if [ -x "$LLAMA_BIN" ]; then
	if [ -f "$MODELO" ]; then
	    mkdir -p "$DIR_LOG"
	    touch "$LOG"
	
	    if ps -ax | grep -v grep | grep -q "$LLAMA_BIN"; then      # -v: excluye el proceso grep
		echo "Llama.cpp ya está en ejecución"              # -q: no muestra lineas de ps
	    else
		"$LLAMA_BIN" -m "$MODELO" --reasoning off --host "$HOST" --port "$PUERTO" > "$LOG" 2>&1 &
		echo "Servidor llama.cpp iniciado. Registro: $LOG"
	    fi
	    # tail -f "$LOG"
	else
	    echo "No existe el modelo: $MODELO"
	fi
    else
	echo "No existe el ejecutable: $LLAMA_BIN (revisar permisos de ejecución)"
    fi
fi
