# self-hosted-runner
Repositorio para probar repositorios alojados fuera del entorno de GitHub (docker, linux server, cloud).

## Descripción
Este repositorio contiene ejemplos y configuraciones para ejecutar pruebas automatizadas utilizando Cypress en diferentes entornos autoalojados.

## Comandos para ejecutar grupos de pruebas con diferentes criterios

```bash
# Ejecuta todas las pruebas en el grupo 1
npx cypress run --spec "cypress/e2e/grupo1/*.cy.js"
```

```bash
# Ejecuta todas las pruebas que contienen 'aliasing' en su nombre
npx cypress run --spec "cypress/e2e/**/*aliasing*.cy.js"
```

```bash
# Ejecuta pruebas específicas en los grupos 1 y 2
npx cypress run --spec "cypress\e2e\grupo1\cypress_api.cy.js,cypress\e2e\grupo2\cypress_api.cy.js"
```

```bash
# Ejecuta las pruebas en el grupo 1 y genera un reporte con cypress-mochawesome-reporter
npx cypress run --spec "cypress/e2e/grupo1/*.cy.js" --reporter cypress-mochawesome-reporter

# Combina los reportes generados en un solo archivo JSON
npx mochawesome-merge cypress\reports\html\.jsons\*.json > cypress\reports\combined.json

# Genera un reporte HTML combinado a partir del archivo JSON combinado
npx mochawesome-report-generator cypress\reports\combined.json -o cypress\reports\ -f ReportCombined.html
```

## Pasos previos para ejecutar pruebas en paralelo

1. Asegúrate de tener las dependencias instaladas:
    ```bash
    npm install
    ```

2. Verifica que el script `cy:parallel` esté correctamente configurado en `package.json`:
    ```json
    "scripts": {
      "cy:run": "cypress run",
      "cy:parallel": "cypress-parallel -s 'npm run cy:run' -t 3 -d 'cypress/e2e/grupo1/*'"
    }
    ```

3. Ejecuta el comando para correr las pruebas en paralelo:
    ```bash
    npx cypress-parallel -s cy:run -t 6 -d .\cypress\e2e\grupo1
    ```