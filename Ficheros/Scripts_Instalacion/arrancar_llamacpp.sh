#!/bin/bash
# arrancar_llamacpp.sh - versión 4 (06/11/26)
# Uso: ./arrancar_llamacpp.sh <id_modelo> 

# Variables
LLAMA_BIN="/usr/local/bin/llama-server"     # ejecutable instalado desde código fuente
LOG="/root/defensa-Fernandez_Espinosa_Adrian/Ficheros/Otros/llamacpp.log"

HOST="127.0.0.1"
PUERTO="8080"
MODELO_GGUF_1="/root/modelos/Qwen3.5-0.8B-Q8_0.gguf"
MODELO_GGUF_2="/root/modelos/Llama-3.2-1B-Instruct-Q4_0.gguf"

# Selección del modelo
if [ "$#" -eq 0 ] || [ "$1" = "1" ]; then
    MODELO="$MODELO_GGUF_1"
elif [ "$#" -eq 1 ] && [ "$1" = "2" ]; then
    MODELO="$MODELO_GGUF_2"
else
    echo "Uso: ./arrancar_llamacpp.sh <id_modelo>"
    echo "1: $MODELO_GGUF_1 (predeterminado)"
    echo "2: $MODELO_GGUF_2"
fi

# Arranque
if [ -n "$MODELO" ]; then
    if [ -x "$LLAMA_BIN" ]; then
	if [ -f "$MODELO" ]; then
	    touch "$LOG"
	
	    if ps -ax | grep -v grep | grep -q "$LLAMA_BIN"; then      # -v: excluye el proceso grep
		echo "Llama.cpp ya está en ejecución"              # -q: no muestra lineas de ps
	    else
		"$LLAMA_BIN" -m "$MODELO" --reasoning off --host "$HOST" --port "$PUERTO" > "$LOG" 2>&1 &
		echo "Servidor llama.cpp iniciado. Registro: $LOG"
	    fi
	    tail -f "$LOG"
	else
	    echo "No existe el modelo: $MODELO"
	fi
    else
	echo "No existe el ejecutable: $LLAMA_BIN (revisar permisos de ejecución)"
    fi
fi
