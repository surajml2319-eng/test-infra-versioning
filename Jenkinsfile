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
            mail (
                subject: "SUCCESS: Infrastructure Build #${BUILD_NUMBER} - test-infra-versioning",
                body: "Hi,\n\nYour infrastructure pipeline (Terraform) was executed SUCCESSFULLY!\nThe EC2 instance and Elastic IP have been successfully provisioned/updated.\n\nBuild URL: ${BUILD_URL}",
                to: 'mlsuraj23@gmail.com'
            )
        }
        failure {
            mail (
                subject: "FAILED: Infrastructure Build #${BUILD_NUMBER} - test-infra-versioning",
                body: "Hi,\n\nYour infrastructure pipeline (Terraform) has FAILED.\nPlease check the Jenkins logs for configuration or deployment errors.\n\nBuild URL: ${BUILD_URL}",
                to: 'mlsuraj23@gmail.com'
            )
        }
        always {
            archiveArtifacts artifacts: '**/*.tf', allowEmptyArchive: true
        }
    }
