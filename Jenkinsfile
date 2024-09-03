pipeline {
    environment {
        DOCKERHUB_CREDENTIALS = credentials('DockerCredentialId')
        //DOCKERHUB_CREDENTIALS_ID = 'DockerCredentialId'

    }
    agent any
    stages {
        stage('Recuperation code depuis github') {
            steps {
                echo 'Code pulled successfully'
            }
        }
        stage('Docker Build') {
            steps {
                echo 'Building Docker image...'
                bat 'docker build -t jenkins3108 .'
            }
        }
        stage('Tag and push your image') {
            steps {
                        bat 'docker tag jenkins3108 channoufi/projectjenkins:latest'
                        bat "echo ${DOCKERHUB_CREDENTIALS_PSW} | docker login -u ${DOCKERHUB_CREDENTIALS_USR} --password-stdin"
                        bat 'docker push channoufi/projectjenkins:latest'
                    
            }
            post {
                always {
                    bat 'docker logout'
                }
            }
        }
        stage('Run docker container') {
            steps {
                script {
                    bat 'docker run -d --name jen_container -p 8089:80 jenkins3108'
                }
            }
        }
    }
}
