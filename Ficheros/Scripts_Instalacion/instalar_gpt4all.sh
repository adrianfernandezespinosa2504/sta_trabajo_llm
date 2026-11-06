#!/bin/bash
# instalar_gpt4all.sh - versión 2 (06/11/26) - EN CONSTRUCCIÓN
# Instalación de GPT4All mediante su instalador binario

# Variables
INSTALADOR="/root/gpt4all-installer-linux.run"    # instalador oficial
GPT4ALL_DIR_INST="/opt/gpt4all"
GPT4ALL_BIN="$GPT4ALL_DIR_INST/bin/chat"               # ejecutable de GPT4All

# Instalación
if [ -x "$INSTALADOR" ]; then                     # si existe el fichero instalador con permisos
    if [ ! -x "$GPT4ALL_BIN" ]; then              # si la aplicacion no está instalada todavía
	# - aceptamos licencias durante instalacion
	# - aceptamos mensajes que solicite el instalador
	# - confirmamos ejecución de la operacion
        "$INSTALADOR" --root "$GPT4ALL_DIR_INST" --accept-licenses --accept-messages --confirm-command install gpt4all

	# Comprobamos instalacion correcta
	if [ $? -eq 0 ] && [ -x "$GPT4ALL_BIN" ]; then then
            echo "GPT4All instalado correctamente"
        else
            echo "Error durante la instalación de GPT4All"
        fi
	
    else
        echo "GPT4All ya está instalado"
    fi
else
    echo "No existe el instalador: $INSTALADOR (revisar permisos de ejecución)"
fi
