pipeline {
    agent any

    environment {
        AWS_REGION = "us-east-1"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/surajml2319-eng/test-infra-versioning.git'
            }
        }

        stage('Terraform Init') {
            steps {
                withAWS(credentials: 'aws-creds', region: "${AWS_REGION}") {
                    sh 'terraform init -input=false'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                withAWS(credentials: 'aws-creds', region: "${AWS_REGION}") {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withAWS(credentials: 'aws-creds', region: "${AWS_REGION}") {
                    sh 'terraform plan -input=false -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withAWS(credentials: 'aws-creds', region: "${AWS_REGION}") {
                    sh 'terraform apply -input=false -auto-approve tfplan'
                }
            }
        }
    }

    post {
        success {
            emailext (
                subject: "SUCCESS: Infrastructure Build #${BUILD_NUMBER} - test-infra-versioning",
                body: "<p>Hi,</p><p>Your infrastructure pipeline (Terraform) was executed <b>SUCCESSFULLY</b>!</p><p>The EC2 instance and Elastic IP have been successfully provisioned/updated.</p><p>Build URL: <a href='${BUILD_URL}'>${BUILD_URL}</a></p>",
                to: 'mlsuraj23@gmail.com',
                mimeType: 'text/html'
            )
        }
        failure {
            emailext (
                subject: "FAILED: Infrastructure Build #${BUILD_NUMBER} - test-infra-versioning",
                body: "<p>Hi,</p><p>Your infrastructure pipeline (Terraform) has <b style='color:red;'>FAILED</b>.</p><p>Please check the Jenkins logs for configuration or deployment errors.</p><p>Build URL: <a href='${BUILD_URL}'>${BUILD_URL}</a></p>",
                to: 'mlsuraj23@gmail.com',
                mimeType: 'text/html'
            )
        }
        always {
            archiveArtifacts artifacts: '**/*.tf', allowEmptyArchive: true
        }
    }
