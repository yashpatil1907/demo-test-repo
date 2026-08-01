node {

    try {

        stage('Checkout') {
            checkout scm
        }

        stage('Test') {
            sh 'npm test'
        }

        stage('Build Docker Image') {
            sh 'docker build -t my-node-app .'
        }


        emailext(
            to: 'patilyash1907@gmail.com',
            subject: "SUCCESS: ${env.JOB_NAME}",
            body: "Build completed successfully"
        )


    }
    catch(error) {

        emailext(
            to: 'patilyash1907@gmail.com',
            subject: "FAILED: ${env.JOB_NAME}",
            body: "Build failed. Check Jenkins logs."
        )

        throw error
    }

}