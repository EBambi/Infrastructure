pipeline {
    agent any
    stages{
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: '304b4bfc-095e-4c95-8366-c096c22cb0bb', url: 'https://github.com/EBambi/Infrastructure.git'
            }
        }
        stage('Terraform init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform apply') {
            steps {
                sh 'terraform apply --auto-approve'
            }
        }
    }
}