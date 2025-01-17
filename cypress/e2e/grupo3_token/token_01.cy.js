const fs = require('fs');
const path = require('path');

process.env.TOKEN

context('Actions', () => {  
    it('Usa el token de la variable de ambiente', () => {
        cy.log('PRUEBA DE TOKEN')
        cy.log('Token: ', Cypress.env('TOKEN'))
        console.log('Token: ', Cypress.env('TOKEN'))
    })

    it('Usa el token para generar un artefacto', () => {
        const token = Cypress.env('TOKEN');
        const filePath = path.join(__dirname, '..', '..', 'token.txt');
        cy.task('writeFile', { filePath, content: token });
    });
})




