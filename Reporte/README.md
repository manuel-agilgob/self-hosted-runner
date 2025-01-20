
## Generar Reportes

Sigue los siguientes pasos para generar los reportes:

1. Eliminar reportes anteriores:
    ```sh
    rm -r reports
    ```

2. Ejecutar todos los tests:
    ```sh
    npx cypress run --spec .\cypress\e2e\grupo1\actions.cy.js,.\cypress\e2e\grupo1\aliasing.cy.js
    ```

3. Fusionar los reportes:
    ```sh

    # Para entornos sin problemas con la codificacion
    npx mochawesome-merge reports/.jsons/*.json > reports/merged-report.json

    # Para entornos con generacion de archivos diferentes a UTF-8
    npx mochawesome-merge reports/.jsons/*.json | node -e "const fs = require('fs'); let data = ''; process.stdin.on('data', chunk => data += chunk); process.stdin.on('end', () => fs.writeFileSync('reports/merged-report.json', data, 'utf8'));"

    ```

4. Generar el reporte HTML:
    ```sh
    npx marge reports/merged-report.json -reportFilename Reporte.html -reportDir reports --inline true
    ```

5. Eliminar reportes json:
    ```sh
    rm -r reports/.json
    ```



Notas : 
    - Requiere instalar HTML Publisher plugin
    - Requiere node plugin configurado como ejecutor con nombre 'node23'
    