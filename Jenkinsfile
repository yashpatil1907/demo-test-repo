pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Show Changed Files') {
            steps {
                sh '''
                    echo "Changed Files:"
                    git diff --name-only HEAD~1 HEAD || true
                '''
            }
        }

        stage('Terraform Init') {
            steps {
                withAWS(credentials: 'aws-creds', region: 'us-east-1') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                withAWS(credentials: 'aws-creds', region: 'us-east-1') {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: 'Apply Terraform Changes?'
                withAWS(credentials: 'aws-creds', region: 'us-east-1') {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }

    post {
        success {
            emailext(
                to: 'patilyash1907@gmail.com',
                subject: "SUCCESS: ${env.JOB_NAME}",
                body: "Terraform Apply completed successfully."
            )
        }

        failure {
            emailext(
                to: 'patilyash1907@gmail.com',
                subject: "FAILED: ${env.JOB_NAME}",
                body: "Terraform pipeline failed. Check Jenkins logs."
            )
        }
    }
}