#!/usr/bin/env bash

docker volume create jenkins-dood
docker network create jenkins
docker build -t dood-jenkins-img -f Dockerfile_jenkins ./

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