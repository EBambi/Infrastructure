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
        stage('Init/Plan Backend') {
            steps {
                cleanWs()
                dir ('backend'){
                    sh 'terraform init'
                    sh 'terraform plan -out tfplan -no-color'
                }
            }
        }
        stage("Get Approval Backend ") {
            steps {
                input "Please Approve the Terraform Plan"
            }
        }
        stage('Apply Backend') {
            steps {
                dir ('backend'){
                    sh 'terraform apply -auto-approve'
                }
            }
        }
        stage('Init/Plan Jenkins-Infra') {
            steps {
                dir ('Jenkins-Infra'){
                    sh 'terraform init'
                    sh 'terraform plan -out tfplan -no-color'
                }
            }
        }
        stage("Get Approval Jenkins-Infra ") {
            steps {
                input "Please Approve the Terraform Plan"
            }
        }
        stage('Apply Jenkins-Infra') {
            steps {
                dir ('Jenkins-Infra'){
                    sh 'terraform apply -auto-approve'
                }
            }
        }
        stage('Init/Plan App-Infra') {
            steps {
                dir ('App-Infra'){
                    sh 'terraform init'
                    sh 'terraform plan -out tfplan -no-color'
                }
            }
        }
        stage("Get Approval App-Infra ") {
            steps {
                input "Please Approve the Terraform Plan"
            }
        }
        stage('Apply App-Infra') {
            steps {
                dir ('App-Infra'){
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
}