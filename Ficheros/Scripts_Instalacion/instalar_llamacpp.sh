#!/bin/bash
# instalar_llamacpp.sh - versión 5 (01/11/26) - EN CONSTRUCCIÓN

# Variables
LLAMA_DIR_COMP="/root/llama.cpp"               # código fuente y compilación
COMMIT="5de733437"                             # versión compilada y probada

# Dependencias (paquetes)
dnf install -y git cmake gcc-c++ ninja-build   # instalación de dependencias desde paquetes

# Descarga del código fuente
if [ ! -d "$LLAMA_DIR_COMP" ]; then
    git clone https://github.com/ggml-org/llama.cpp "$LLAMA_DIR_COMP"
fi
cd "$LLAMA_DIR_COMP"
git checkout "$COMMIT"

# Compilación
cmake -B build
cmake --build build -j2                        # cambiar según los procesadores de los ltXX

# Instalación en /usr/local
cmake --install build                          # instalación desde codigo fuente

# Que el sistema encuentre las librerías de /usr/local/lib64
echo /usr/local/lib64 > /etc/ld.so.conf.d/llama.conf
ldconfig
