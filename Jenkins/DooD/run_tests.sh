#!/bin/bash

# Verificar si la variable de entorno folder_name está definida
if [ -z "$folder_name" ]; then
  echo "Error: La variable de entorno 'folder_name' no está definida."
  exit 1
fi

# Ejecutar Cypress con la variable de entorno
npx cypress run --spec "cypress/e2e/$folder_name/*.cy.js" --reporter cypress-mochawesome-reporter --env TOKEN=RANDOM_TOKEN