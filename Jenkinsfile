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
                dir ('backend'){
                    sh 'terraform init'
                }
            }
        }
        stage('TF Plan Backend') {
            steps {
                sh 'cd backend/ && terraform plan -out tfplan'
            }
        }
        stage("Get Approval") {
            steps {
                input "Please Approve the Terraform Plan"
            }
        }
        stage('TF Apply Backend') {
            steps {
                sh 'cd backend/'(
                    label: 'Terraform Apply',
                    script: 'terraform apply --auto-approve'
                )
            }
        }
    }
}