pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }        
    
    stages {
        stage('Terraform Init') {
            steps {
                echo 'Bismillah terraform init start ho raha hai'
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                echo 'Bismillah Terraform Plan start ho raha hai'
                sh 'terraform plan'
            }
        }

            stage('Terraform Apply') {
                steps {
                    echo 'Alhamdulillah deploying infrastructure to aws'
                    sh 'terraform apply -auto-approve'
                }
            }
    }
}                            
