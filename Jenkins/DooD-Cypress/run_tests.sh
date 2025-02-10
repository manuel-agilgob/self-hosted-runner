#!/bin/bash


ENV_VARS=("FUNCIONARIO" "CIUDADANO" "TRAMITE" "TEST_DATA")


# Verificar si la variable de entorno folder_name está definida
if [ -z "$SPEC" ]; then
  echo "Error: La variable de entorno 'folder_name' no está definida."
  exit 1
fi


CYPRESS_ARGS=""
for VAR in "${ENV_VARS[@]}"; do
  VALUE="${!VAR}"  # Obtener el valor de la variable
  if [ -n "$VALUE" ]; then  # Verificar que no esté vacío
    CYPRESS_ARGS+=" --env $VAR=$VALUE"
  fi
done




# Ejecutar Cypress con la variable de entorno
npx cypress run --spec "$SPEC" --reporter cypress-mochawesome-reporter $CYPRESS_ARGS
