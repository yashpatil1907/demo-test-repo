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
                dir('TF-file') {
                    withAWS(credentials: 'aws-creds', region: 'us-east-1') {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir('TF-file') {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('TF-file') {
                    withAWS(credentials: 'aws-creds', region: 'us-east-1') {
                        sh 'terraform plan -out=tfplan'
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: 'Approve Terraform Apply?'
                dir('TF-file') {
                    withAWS(credentials: 'aws-creds', region: 'us-east-1') {
                        sh 'terraform apply -auto-approve tfplan'
                    }
                }
            }
        }
    }

    post {
        success {
            emailext(
                subject: "SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: "Build completed successfully.\n\nJob: ${env.JOB_NAME}\nBuild: ${env.BUILD_NUMBER}",
                to: "patilyash1907@gmail.com"
            )
        }

        failure {
            emailext(
                subject: "FAILED: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: "Build failed.\n\nPlease check Jenkins console output.",
                to: "patilyash1907@gmail.com"
            )
        }
    }
}