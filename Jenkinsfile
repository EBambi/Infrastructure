pipeline {
    agent {label 'agent-one'}
    stages{
        stage('Checkout') {
            steps {
                sshagent(credentials: ['Infrastructure-Credentials']) {
                    git url: 'https://github.com/EBambi/Infrastructure.git', branch: 'main', credentialsId: 'Infrastructure-Credentials'
                } 
            }
        }
        stage('Terraform init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
    }
}