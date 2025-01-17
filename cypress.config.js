const { defineConfig } = require('cypress');
const fs = require('fs');
const { report } = require('process');


//Simula la obtención de un token de autenticación
token = Math.random().toString(30).substring(2, 20).toUpperCase();

module.exports = defineConfig({
  reporter: 'cypress-mochawesome-reporter',
  reporterOptions: {
    reportDir: 'reports',
    reportFilename: `[status]-${new Date().toLocaleString('default', { month: 'short' })}${new Date().getDate()}-${new Date().getHours()}${new Date().getMinutes()}`,
    html: false,
    json: true,
    quiet: true,
  },

  env: {
    TOKEN: token,
  },
  
  e2e: {
    setupNodeEvents(on, config) {
      on('task', {
        writeFile({ filePath, content }) {
          fs.writeFileSync(filePath, content, 'utf8');
          return null; // Cypress requiere que las tareas devuelvan un valor o `null`
        },
      });
      return config;
    },
  },
});


//rm -r reports

// Ejecutar todos los tests
// npx cypress run --spec .\cypress\e2e\grupo1\actions.cy.js,.\cypress\e2e\grupo1\aliasing.cy.js  

// Fusionar los reportes
  // npx mochawesome-merge reports/.jsons/*.json > reports/merged-report.json

  // Windows PowerShell (Evita UTF-16 Little Endian BOM) 
  // npx mochawesome-merge reports/.jsons/*.json | node -e "const fs = require('fs'); let data = ''; process.stdin.on('data', chunk => data += chunk); process.stdin.on('end', () => fs.writeFileSync('reports/merged-report.json', data, 'utf8'));"

// Generar el reporte HTML
// npx marge reports/merged-report.json -reportFilename Reporte.html -reportDir reports --inline true 

// Eliminar reportes json
// rm -r reports/.json