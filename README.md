# self-hosted-runner
Repositorio para probar repositorios alojados fuera del entorno de GitHub (docker, linux server, cloud).

## Descripción
Este repositorio contiene ejemplos y configuraciones para ejecutar pruebas automatizadas utilizando Cypress en diferentes entornos autoalojados.

## Comandos para ejecutar grupos de pruebas con diferentes criterios

```bash
npx cypress run --spec "cypress/e2e/grupo1/*.cy.js"
```

```bash
npx cypress run --spec "cypress/e2e/**/*aliasing*.cy.js"
```

```bash
npx cypress run --spec "cypress\e2e\grupo1\cypress_api.cy.js,cypress\e2e\grupo2\cypress_api.cy.js"
```




```bash
npx cypress run --spec "cypress/e2e/grupo1/*.cy.js" --reporter cypress-mochawesome-reporter
npx mochawesome-merge cypress\reports\html\.jsons\*.json > cypress\reports\combined.json
// Cambiar el charset ???
npx mochawesome-report-generator cypress\reports\combined.json -o cypress\reports\ -f ReportCombined.html

```