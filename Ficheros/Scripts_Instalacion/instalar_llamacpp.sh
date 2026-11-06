#!/bin/bash
# instalar_llamacpp.sh - versión 6 (06/11/26)
# Instalación de llama.cpp mediante codigo fuente
# Instalación de dependencias mediante paquetes

# Variables
LLAMA_DIR_COMP="/root/llama.cpp"               # código fuente y compilación
LLAMA_BIN="/usr/local/bin/llama-server"
COMMIT="5de733437"                             # versión compilada y probada

# Instalación
# Dependencias (paquetes)

if dnf install -y git cmake gcc-c++ ninja-build; then       # instalación de dependencias desde paquetes

    # Descarga del código fuente
    if [ ! -d "$LLAMA_DIR_COMP" ]; then
        git clone https://github.com/ggml-org/llama.cpp "$LLAMA_DIR_COMP"
    fi

    if [ -d "$LLAMA_DIR_COMP/.git" ]; then
        cd "$LLAMA_DIR_COMP"

        # Selección de la versión
        if git fetch origin && git checkout "$COMMIT"; then

            # Compilación
            if cmake -B build -G Ninja &&
               cmake --build build -j2 &&                  # cambiar según los procesadores de los ltXX
               cmake --install build; then                 # instalación desde codigo fuente

		# Configuración de las librerías (para que el sistema encuentre las librerías de /usr/local/lib64)
		echo /usr/local/lib64 > /etc/ld.so.conf.d/llama.conf

		if ldconfig; then
		    
                    # Comprobamos la instalación
                    if [ -x "$LLAMA_BIN" ]; then
                        echo "llama.cpp instalado correctamente"
                    else
                        echo "Error: no se encuentra el ejecutable llama-server (comprobar permisos de ejecución)"
                    fi
                else
                    echo "Error al configurar las librerías"
                fi
            else
                echo "Error durante la compilación o instalación de llama.cpp"
            fi
        else
            echo "Error al seleccionar la versión de llama.cpp"
        fi
    else
        echo "Error: no existe un repositorio válido de llama.cpp"
    fi
else
    echo "Error al instalar las dependencias"
fi

