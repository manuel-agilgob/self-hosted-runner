FROM jenkins/jenkins:lts
USER root

# Actualiza los paquetes e instala las dependencias para ejecutar las pruebas
# en Cypress (el resto se instala como plugins en Jenkins)
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
    nano \
    curl \
    && curl -fsSL https://deb.nodesource.com/setup_20.x |  bash - \
    && apt-get install -y nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Desactivar CSP en Jenkins creando un script Groovy para configurarlo
RUN mkdir -p /usr/share/jenkins/ref/init.groovy.d \
    && echo 'System.setProperty("hudson.model.DirectoryBrowserSupport.CSP", "");' > /usr/share/jenkins/ref/init.groovy.d/disable-csp.groovy
LABEL description="Jenkins con dependencias para ejecutar pruebas en Cypress, mostrar reportes de pruebas y desactivar CSP"
USER jenkins




# docker build -t jenkins-plus-cypress .
# docker run -d -p 8080:8080 -p 50000:50000 --name cypress-jenkins-cont --mount source=cypress_jenkins_data,target=/var/jenkins_home jenkins-plus-cypress