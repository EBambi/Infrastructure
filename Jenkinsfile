pipeline {
    agent any
    stages{
        stage('Checkout') {
            steps {
                sshagent(credentials: ['Infrastructure-Credentials']) {
                    git url: 'https://github.com/EBambi/Infrastructure.git', branch: 'main', credentialsId: 'Infrastructure-Credentials'
                } 
            }
        }
        stage('Init Backend') {
            steps {
                sh 'cd backend/ && terraform init'
            }
        }
        stage('TF Plan Backend') {
            steps {
                sh (
                    sh 'cd backend/',
                    label: 'Terraform Plan',
                    script: "terraform plan -out tfplan"
                )
            }
        }
        stage('TF Apply Backend') {
            steps {
                input(message: 'Click "proceed" to approve the above Terraform Plan')
                sh (
                    'cd backend/',
                    label: 'Terraform Apply',
                    script: 'terraform apply --auto-approve'
                )
            }
        }
    }
}