#!/bin/bash
# desinstalar_gpt4all.sh - versión 1 (06/11/26) - EN CONSTRUCCIÓN
# Desinstalación de GPT4All mediante su herramienta de mantenimiento

# Variables
GPT4ALL_BIN="/opt/gpt4all/bin/chat"
MANT_TOOL="/opt/gpt4all/maintenancetool"

# Desinstalación
if [ -x "$MANT_TOOL" ]; then
    if  ps -ax | grep -v grep | grep -q "$GPT4ALL_BIN"; then
        echo "Cierra GPT4All antes de desinstalarlo"
    else
        "$MANT_TOOL" --accept-licenses --accept-messages --confirm-command purge
    fi
else
    echo "No existe la herramienta de mantenimiento: $MANT_TOOL"
fi
