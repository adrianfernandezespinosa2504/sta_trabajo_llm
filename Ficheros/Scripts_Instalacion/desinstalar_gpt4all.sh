#!/bin/bash
# desinstalar_gpt4all.sh - versión 2 (14/11/26)
# Desinstalación de GPT4All instalado desde código fuente

# Variables
GPT4ALL_DIR="/root/gpt4all"
GPT4ALL_BIN="$GPT4ALL_DIR/build/bin/chat"

# Desinstalación
if [ -d "$GPT4ALL_DIR/.git" ]; then
    if [ -x "$GPT4ALL_BIN" ]; then

        # Comprobación de que GPT4All no está en ejecución
        if ps -ax | grep -v grep | grep -q "$GPT4ALL_BIN"; then
            echo "Cierra GPT4All antes de desinstalarlo"
        else

            # Eliminación del repositorio y los ficheros compilados
            if rm -rf "$GPT4ALL_DIR"; then
                echo "GPT4All desinstalado correctamente"
            else
                echo "Error durante la desinstalación de GPT4All"
            fi
        fi
    else
        echo "No se encuentra el ejecutable de GPT4All"
    fi
else
    echo "No existe un repositorio válido de GPT4All"
fi

