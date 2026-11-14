#!/bin/bash
# arrancar_gpt4all.sh - versión 4 (06/11/26) 
# Arranque de GPT4All compilado desde código fuente y su servidor API

# Variables
GPT4ALL_BIN="/root/gpt4all/build/bin/chat"
DIR_LOG="/var/log/sta_trabajo"
LOG="$DIR_LOG/gpt4all.log"

# Arranque
if [ -x "$GPT4ALL_BIN" ]; then
    if mkdir -p "$DIR_LOG" && touch "$LOG"; then

        if ps -ax | grep -v grep | grep -q "$GPT4ALL_BIN"; then
            echo "GPT4All ya está en ejecución"
        else
            "$GPT4ALL_BIN" > "$LOG" 2>&1 &
            echo "Servidor GPT4All iniciado. Registro: $LOG"
        fi
	
    else
        echo "Error al preparar el directorio de registros"
    fi
else
    echo "No existe el ejecutable: $GPT4ALL_BIN (revisar compilación y permisos)"
fi
