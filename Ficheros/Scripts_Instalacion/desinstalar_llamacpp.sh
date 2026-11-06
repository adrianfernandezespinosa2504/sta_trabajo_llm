#!/bin/bash
# desinstalar_llamacpp.sh - versión 1 (01/11/26)
# Deshace lo que hace instalar_llamacpp.sh (no borra el código fuente)

# Variables
MANIFEST="/root/llama.cpp/build/install_manifest.txt"   # lista de ficheros instalados

# Desinstalación
if [ -f "$MANIFEST" ]; then
    # Borrar los ficheros que copió cmake --install
    while read -r fichero; do               # guarda en 'fichero' la ruta que se quiere borrar
        rm -f "$fichero"
    done < "$MANIFEST"

    # Borrar las carpetas de CMake que hayan quedado vacías
    rmdir /usr/local/lib64/cmake/llama
    rmdir /usr/local/lib64/cmake/ggml

    # Deshacer el cambio de la lista de librerías del sistema
    # (añadido para que llama-server encuentre sus librerías en /usr/local/lib64)
    rm -f /etc/ld.so.conf.d/llama.conf
    ldconfig
else
    echo "No existe $MANIFEST: no se puede desinstalar"
fi
