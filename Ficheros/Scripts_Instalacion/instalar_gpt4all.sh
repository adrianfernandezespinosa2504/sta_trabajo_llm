#!/bin/bash
# instalar_gpt4all.sh - versión 5 (14/11/26) 
# Instalación de GPT4All mediante código fuente

# Variables
GPT4ALL_DIR="/root/gpt4all"
QT_PRIVATE="/tmp/qt-private.cmake"
COMMIT="b666d16"

# Activación del compilador
if source /opt/rh/gcc-toolset-15/enable; then

    # Obtención del código fuente
    if [ ! -d "$GPT4ALL_DIR/.git" ]; then
        if git clone --recurse-submodules https://github.com/nomic-ai/gpt4all.git "$GPT4ALL_DIR"; then
            echo "Repositorio de GPT4All descargado correctamente"
        else
            echo "Error al descargar el repositorio de GPT4All"
        fi
    fi

    # Acceso al repositorio
    if [ -d "$GPT4ALL_DIR/.git" ]; then
        if cd "$GPT4ALL_DIR"; then

            # Selección de la versión utilizada
            if git checkout "$COMMIT" && git submodule update --init --recursive; then

                # Configuración de la dependencia Qt6::GuiPrivate
                if echo 'find_package(Qt6GuiPrivate CONFIG REQUIRED)' > "$QT_PRIVATE"; then

                    # Configuración del proyecto
                    if cmake -S gpt4all-chat -B build \
                        -DCMAKE_BUILD_TYPE=Release \
                        -DLLMODEL_CUDA=OFF \
                        -DLLMODEL_KOMPUTE=OFF \
                        -DCMAKE_PROJECT_QXlsx_INCLUDE="$QT_PRIVATE"; then

                        # Compilación
                        if cmake --build build --parallel 2; then

                            # Comprobación de la instalación
                            if [ -x "$GPT4ALL_DIR/build/bin/chat" ]; then
                                echo "GPT4All instalado correctamente"
                            else
                                echo "Error: no se encuentra el ejecutable chat"
                            fi
                        else
                            echo "Error durante la compilación de GPT4All"
                        fi
                    else
                        echo "Error durante la configuración de GPT4All"
                    fi
                else
                    echo "Error al crear el fichero auxiliar de CMake"
                fi
            else
                echo "Error al seleccionar la versión de GPT4All"
            fi
        else
            echo "Error al acceder al repositorio de GPT4All"
        fi
    else
        echo "No existe un repositorio válido de GPT4All"
    fi
else
    echo "Error al activar GCC Toolset 15"
fi
