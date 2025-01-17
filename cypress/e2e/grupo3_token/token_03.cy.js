process.env.TOKEN

context('Actions', () => {  
    it('Usa el token de la variable de ambiente', () => {
        // https://on.cypress.io/type
        cy.log('PRUEBA DE TOKEN')
        cy.log('Token: ', Cypress.env('TOKEN'))
        console.log('Token: ', Cypress.env('TOKEN'))
    })
})