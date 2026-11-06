#!/bin/bash
# instalar_gpt4all.sh - versión 1 (05/11/26) - EN CONSTRUCCIÓN
# Instalación de GPT4All mediante su instalador binario

# Variables
INSTALADOR="/root/gpt4all-installer-linux.run"    # instalador oficial
GPT4ALL_BIN="/opt/gpt4all/bin/chat"               # ejecutable de GPT4All

# Instalación
if [ -f "$INSTALADOR" ]; then                     # si existe el fichero instalador 
    if [ ! -f "$GPT4ALL_BIN" ]; then              # si la aplicacion no está nstalada todavía
	# - aceptamos licencias durante instalacion
	# - aceptamos mensajes que solicite el instalador
	# - confirmamos ejecución de la operacion
        "$INSTALADOR" --accept-licenses --accept-messages --confirm-command install gpt4all
    else
        echo "GPT4All ya está instalado"
    fi
else
    echo "No existe el instalador: $INSTALADOR"
fi
