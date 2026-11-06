#!/bin/bash
# arrancar_gpt4all.sh - versión 2 (06/11/26) 
# Arranque de GPT4All y su servidor API local (puerto 4891)

# Variables
GPT4ALL_BIN="/opt/gpt4all/bin/chat"                                       # ejecutable de GPT4All
LOG="/root/defensa-Fernandez_Espinosa_Adrian/Ficheros/Otros/gpt4all.log"  # registro de arranque

# Arranque
if [ -x "$GPT4ALL_BIN" ]; then                                 # existe el ejecutable y con permisos
    touch "$LOG"
    
    if ps -ax | grep -v grep | grep -q "$GPT4ALL_BIN"; then    # -v: excluye el proceso grep
            echo "GPT4All ya está en ejecución"                # -q: no muestra lineas de ps
    else
        "$GPT4ALL_BIN" > "$LOG" 2>&1 &                         # guardamos salida estandar y errores en $LOG
        echo "Servidor GPT4All iniciado. Registro: $LOG"
    fi
    tail -f "$LOG"
else
    echo "No existe el ejecutable: $GPT4ALL_BIN (revisar permisos de ejecución)"
fi
