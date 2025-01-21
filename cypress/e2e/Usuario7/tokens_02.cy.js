
context('Actions', () => {  
    it('Usa el token de la variable de ambiente', () => {
        cy.log('PRUEBA DE TOKEN')
        cy.log('Token: ', Cypress.env('TOKEN'))
        console.log('Token: ', Cypress.env('TOKEN'))
    })

    it('Usa el token para generar un artefacto', () => {
        const token = Cypress.env('TOKEN');
        const filePath = 'reports/Usuario7_prueba2.txt';
        cy.task('writeFile', { filePath, content: token });
    });
})




