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
                    sh 'terraform plan -out tfplan -no-color'
                }
            }
        }
        stage("Get Approval") {
            steps {
                input "Please Approve the Terraform Plan"
            }
        }
        stage('TF Apply Backend') {
            steps {
                dir ('backend'){
                    sh 'terraform apply -auto-approval'
                }
            }
        }
    }
}