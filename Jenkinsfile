pipeline {
    environment {
        //DOCKERHUB_CREDENTIALS = credentials('DockerCredentialId')
        DOCKERHUB_CREDENTIALS_ID = 'DockerCredentialId'

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
                withCredentials([usernamePassword(credentialsId: DOCKERHUB_CREDENTIALS_ID, passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
                        bat 'docker tag jenkins3108 channoufi/projectjenkins:latest'
                        bat "echo %DOCKERHUB_PASSWORD% | docker login -u %DOCKERHUB_USERNAME% --password-stdin"
                        bat 'docker push channoufi/projectjenkins:latest'
                    }
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
