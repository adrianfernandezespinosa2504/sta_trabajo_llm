#!/bin/bash
# configurar_gpt4all.sh - version 1 (14/11/26)
# Configuración del servidor HTTP de GPT4All

# Variables
CONFIG_FILE="/root/.config/nomic.ai/GPT4All.ini"
MODEL_DIR="/root/defensa-Fernandez_Espinosa_Adrian/Modelos"

# Comprobación de directorios y ficheros
if [ -d "$MODEL_DIR" ]; then
    if [ -f "$CONFIG_FILE" ]; then

        # Eliminación de las opciones anteriores
        if sed -i '/^serverChat=/d; /^networkPort=/d; /^modelPath=/d' "$CONFIG_FILE"; then

            # Inserción de las opciones en General
            if sed -i "/^\[General\]/a serverChat=true\nnetworkPort=4891\nmodelPath=$MODEL_DIR/" "$CONFIG_FILE"; then
                echo "Configuración de GPT4All realizada correctamente"
            else
                echo "Error al configurar GPT4All"
            fi
        else
            echo "Error al modificar el fichero de configuración"
        fi
    else
        echo "Error: no existe el fichero GPT4All.ini"
    fi
else
    echo "Error: no existe el directorio de modelos"
fi
