node {

    try {

        stage('Checkout') {
            checkout scm
        }

        stage('Show Changed Files') {
            sh '''
                echo "=============================="
                echo "Changed Files:"
                git diff --name-only HEAD~1 HEAD || true
                echo "=============================="
            '''
        }

        stage('Test') {
            sh 'npm test'
        }

        stage('Build Docker Image') {
            sh 'docker build -t my-node-app .'
        }

        stage('Push Docker Image to ECR') {

            withAWS(credentials: 'aws-creds', region: 'us-east-1') {

                sh '''
                aws ecr get-login-password --region us-east-1 | \
                docker login --username AWS \
                --password-stdin 876225478418.dkr.ecr.us-east-1.amazonaws.com

                docker tag my-node-app:latest \
                876225478418.dkr.ecr.us-east-1.amazonaws.com/demo-app:latest

                docker push \
                876225478418.dkr.ecr.us-east-1.amazonaws.com/demo-app:latest
                '''
            }
        }

        emailext(
            to: 'patilyash1907@gmail.com',
            subject: "SUCCESS: ${env.JOB_NAME}",
            body: "Build and ECR Push completed successfully"
        )

    } catch(error) {

        emailext(
            to: 'patilyash1907@gmail.com',
            subject: "FAILED: ${env.JOB_NAME}",
            body: "Build or ECR Push failed. Check Jenkins logs."
        )

        throw error
    }
}