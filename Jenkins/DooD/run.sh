# Este script configura y ejecuta un contenedor Docker para Jenkins en un entorno Docker-outside-of-Docker (DooD).

# Crea un volumen Docker llamado 'jenkins-dood' para persistir los datos de Jenkins.
docker volume create jenkins-dood

# Crea una red Docker llamada 'jenkins' para permitir la comunicación entre contenedores.
docker network create jenkins

# Construye una imagen Docker llamada 'dood-jenkins-img' usando el Dockerfile especificado (Dockerfile_jenkins).
docker build -t dood-jenkins-img -f Dockerfile_jenkins ./

# Ejecuta un contenedor Docker con la imagen 'dood-jenkins-img' con las siguientes configuraciones:
# --name: Asigna el nombre 'dood-jenkins-cont' al contenedor.
# --restart unless-stopped: Configura el contenedor para reiniciarse a menos que se detenga explícitamente.
# --detach: Ejecuta el contenedor en segundo plano.
# --network: Conecta el contenedor a la red 'jenkins'.
# -p 8080:8080: Mapea el puerto 8080 del host al puerto 8080 del contenedor (interfaz web de Jenkins).
# -p 50000:50000: Mapea el puerto 50000 del host al puerto 50000 del contenedor (conexiones de agentes Jenkins).
# --env JAVA_OPTS="-Djava.awt.headless=true": Establece la variable de entorno JAVA_OPTS para Jenkins.
# -v jenkins-dood:/var/jenkins_home: Monta el volumen 'jenkins-dood' en el directorio /var/jenkins_home del contenedor.
# -v /var/run/docker.sock:/var/run/docker.sock: Monta el socket Docker del host en el contenedor para permitir la ejecución de comandos Docker dentro del contenedor.
docker run \
  --name dood-jenkins-cont \
  --restart unless-stopped \
  --detach \
  --network jenkins \
  -p 8080:8080 \
  -p 50000:50000 \
  --env JAVA_OPTS="-Djava.awt.headless=true" \
  -v jenkins-dood:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  dood-jenkins-img


  
# docker build -t jenkins-plus-cypress .
# docker run -d -p 8080:8080 -p 50000:50000 --name cypress-jenkins-cont --mount source=cypress_jenkins_data,target=/var/jenkins_home jenkins-plus-cypress