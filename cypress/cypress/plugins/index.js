const fs = require('fs');
const path = require('path');

module.exports = (on, config) => {
    on('task', {
        writeFile({ filePath, content }) {
            fs.writeFileSync(filePath, content, 'utf8');
            return null; // Cypress requiere que las tareas devuelvan un valor o `null`
        },
    });
};