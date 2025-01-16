pipeline {
    agent any

    tools {nodejs "node23"}

    stages {
        stage('Install Dependencies') {
            steps {
                script {
                    if (fileExists('package.json')) {
                        sh 'npm install'
                    } else {
                        error 'package.json not found'
                    }
                }
            }
        }

        stage('Run Cypress Tests') {
            steps {
                script {
                    sh 'npx cypress run --heaadless'
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'cypress/screenshots/**/*, cypress/videos/**/*', allowEmptyArchive: true
            junit 'cypress/results/*.xml'
        }
    }
}