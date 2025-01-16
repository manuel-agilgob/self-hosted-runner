# Establecer una imagen en particular como base para la imagen que se está creando
FROM jenkins/jenkins:lts

# Cambia al usuario root para instalar dependencias
USER root

# Actualiza los paquetes e instala las dependencias para ejecutar las pruebas
# en cypress (el resto se instala como plugins en Jenkins)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgtk2.0-0 \
    libgtk-3-0 \
    libgbm-dev \
    libnotify-dev \
    libnss3 \
    libxss1 \
    libasound2 \
    libxtst6 \
    xauth \
    xvfb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Retorna al usuario Jenkins
USER jenkins
