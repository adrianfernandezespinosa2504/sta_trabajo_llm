# 🎓🖥️ Despliegue y evaluación de servidores LLM en Linux
### Servicios Telemáticos Avanzados

![Linux](https://img.shields.io/badge/Linux-AlmaLinux-1793D1?logo=linux&logoColor=white)
![C++](https://img.shields.io/badge/C++-17-00599C?logo=cplusplus&logoColor=white)
![CMake](https://img.shields.io/badge/CMake-Build_System-064F8C?logo=cmake&logoColor=white)
![GPT4All](https://img.shields.io/badge/GPT4All-LLM-00A98F)
![llama.cpp](https://img.shields.io/badge/llama.cpp-LLM-8A2BE2)

## 1. Descripción del proyecto

Este proyecto tiene como objetivo estudiar la viabilidad del despliegue y utilización de servidores de modelos de lenguaje de gran tamaño (*Large Language Models*, LLM) en un entorno Linux, evaluando distintas alternativas de software y su comportamiento en un entorno con recursos hardware limitados.

Para ello, se estudian e implementan dos soluciones:

- **GPT4All:** plataforma que permite ejecutar modelos de lenguaje de forma local y proporciona una API HTTP para interactuar con ellos.
- **llama.cpp:** implementación en C/C++ orientada a la inferencia eficiente de modelos de lenguaje, que incorpora `llama-server` para ofrecer acceso a los modelos mediante una API HTTP compatible con OpenAI.

El trabajo contempla la instalación, configuración y puesta en funcionamiento de ambos servidores, así como la evaluación de su rendimiento utilizando diferentes modelos GGUF.

Se presta especial atención a la posibilidad de ejecutar los servicios sin conexión a Internet, de manera que los modelos puedan utilizarse íntegramente en el local.

## 2. Objetivos

Los principales objetivos del proyecto son:

- Analizar las características y requisitos de GPT4All y llama.cpp.
- Instalar y configurar ambas soluciones en un entorno Linux.
- Analizar el uso de GPU.
- Desplegar modelos de lenguaje en formato GGUF.
- Habilitar el acceso a los servidores mediante sus respectivas API HTTP.
- Comprobar el funcionamiento de los servicios desde otros usuarios y equipos de la red.
- Verificar la ejecución de los modelos sin conexión a Internet.
- Evaluar el rendimiento de los modelos mediante pruebas de inferencia.
- Comparar las alternativas estudiadas en términos de facilidad de instalación, configuración, consumo de recursos y velocidad de generación.

## 3. Entorno de pruebas

El entorno utilizado para el desarrollo y las pruebas es una máquina virtual con las siguientes características:

| Característica         | Configuración |
| ---------------------- | ------------- |
| Sistema operativo      | AlmaLinux     |
| Memoria RAM            | 8 GB          |
| Procesadores asignados | 2             |
| Arquitectura           | x86_64        |
| Compatibilidad CPU     | AVX2          |
| Entorno gráfico        | GNOME         |

La máquina virtual reproduce la configuración de los equipos del laboratorio en los que se realizará la demostración.

### Software empleado

- Git: control de versiones.
- CMake: configuración y compilación.
- Compilador C/C++.
- Ninja: herramienta de construcción.
- Qt 6: dependencias de compilación de GPT4All.
- curl: realización de peticiones HTTP y descarga de ficheros.
- llama.cpp: ejecución e inferencia de modelos.
- GPT4All: ejecución e inferencia de modelos.

## 4. Modelos utilizados

Se han seleccionado dos modelos de pequeño tamaño para facilitar su ejecución en un entorno con recursos limitados:

| Modelo                | Repositorio                          | Cuantización |
| --------------------- | ------------------------------------ | ------------ |
| Qwen 3.5 0.8B         | ggml-org/Qwen3.5-0.8B-GGUF           | Q8_0         |
| Llama 3.2 1B Instruct | bartowski/Llama-3.2-1B-Instruct-GGUF | Q4_0         |

Ambos modelos se distribuyen en formato GGUF y se almacenan localmente para permitir su utilización sin conexión a Internet.

## 5. Organización del repositorio

La estructura del proyecto se organiza de la siguiente manera:

```text id="z9k4lm"
defensa-Fernandez_Espinosa_Adrian/
│
├── README.md
│
└── Ficheros/
    │
    ├── Scripts_Instalacion/
    │   ├── instalar_llamacpp.sh
    │   ├── arrancar_llamacpp.sh
    │   └── desinstalar_llamacpp.sh
    │
    ├── Ficheros_Configuracion/
    │
    ├── Otros/
    │
    ├── minutas.txt
    └── README.txt
```

## 6. Instalación y configuración

### 6.1. llama.cpp

Se ha instalado llama.cpp a partir de su código fuente, utilizando CMake para generar los binarios y compilar el proyecto.

La instalación se realiza en `/usr/local`, situando los ejecutables en `/usr/local/bin` y las bibliotecas compartidas en `/usr/local/lib64`.

Para que el sistema pueda localizar las bibliotecas durante la ejecución, se configura el cargador dinámico de Linux:

```bash
echo /usr/local/lib64 > /etc/ld.so.conf.d/llama.conf
ldconfig
```

El repositorio incluye scripts para automatizar las operaciones de instalación, arranque y desinstalación.

### 6.2. GPT4All

GPT4All se instala mediante su instalador oficial para Linux, utilizando el modo de instalación por línea de comandos.

La instalación se realiza en `/opt/gpt4all`.

La API HTTP del servidor debe estar habilitada para permitir la interacción con los modelos mediante peticiones REST.

La configuración se almacena en:

```text
~/.config/nomic.ai/GPT4All.ini
```

Los modelos GGUF se almacenan en el directorio de datos de GPT4All:

```text
~/.local/share/nomic.ai/GPT4All/
```

## 7. Ejecución de los servidores

### 7.1. llama.cpp

El servidor `llama-server` permite cargar un modelo local y ofrecer acceso mediante una API HTTP.

Ejemplo de ejecución:

```bash
llama-server \
    -m /root/modelos/modelo.gguf \
    --host 127.0.0.1 \
    --port 8080 \
    --reasoning off
```

Se utiliza el puerto 8080 para las pruebas.

### 7.2. GPT4All

Una vez instalada la aplicación y habilitada la API del servidor, GPT4All proporciona un servicio HTTP en el puerto 4891.

La disponibilidad del servicio y los modelos cargados pueden consultarse mediante:

```bash
curl http://localhost:4891/v1/models
```

## 8. Pruebas realizadas

Las pruebas contempladas en el proyecto incluyen:

- **Disponibilidad del servicio:** comprobación de que los servidores permanecen a la escucha en los puertos configurados.
- **Acceso a la API:** realización de peticiones HTTP para consultar los modelos disponibles y solicitar inferencias.
- **Acceso desde otros usuarios:** comprobación de que las API pueden utilizarse desde cuentas distintas a la que ejecuta los servicios.
- **Funcionamiento sin Internet:** ejecución de los modelos con la interfaz de red deshabilitada.
- **Rendimiento:** medición de la velocidad de generación de texto, expresada en tokens por segundo.
- **Uso de recursos:** análisis del aprovechamiento de CPU y GPU durante la inferencia.

## 9. Documentación adicional

El fichero `Ficheros/minutas.txt` recoge el seguimiento cronológico del trabajo, incluyendo las decisiones tomadas, incidencias encontradas, pruebas realizadas y tareas pendientes.

Los scripts de instalación, arranque y desinstalación de llama.cpp se encuentran en `Ficheros/Scripts_Instalacion/`.
