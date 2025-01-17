const { defineConfig } = require('cypress');
const fs = require('fs');


//Simula la obtención de un token de autenticación
token = Math.random().toString(30).substring(2, 20).toUpperCase();

module.exports = defineConfig({
  reporter: 'cypress-mochawesome-reporter',
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
