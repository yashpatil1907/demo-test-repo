pipeline {

    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Test') {
            steps {
                sh 'npm test'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t my-node-app .'
            }
        }

    }

}

post {
    success {
        emailext(
            to: "patilyash1907@gmail.com",
            subject: "Build Success",
            body: "Build completed successfully."
        )
    }
    failure {
        emailext(
            to: "patilyash1907@gmail.com",
            subject: "Build Failed",
            body: "Build failed. Please check Jenkins."
        )
    }
}