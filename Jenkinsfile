pipeline {
    environment {
        DOCKERHUB_CREDENTIALS = credentials('DockerCredentialId')
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
                sh 'docker build -t jenkins3108:latest .'  // Ajout du tag latest ici
            }
        }
        stage('Tag and push your image') {
            steps {
                bat 'docker images'  // Débogage: liste toutes les images disponibles
                bat 'docker tag jenkins3108:latest channoufi/projectjenkins:latest'
                bat "docker login -u ${DOCKERHUB_CREDENTIALS_USR} -p ${DOCKERHUB_CREDENTIALS_PSW}"
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
                     // Remove the existing container if it exists
                    bat 'docker ps -a -q --filter name=jen_container | findstr . && docker rm -f jen_container || echo "No existing container to remove"'
                    // Run the new container
                    bat 'docker run -d --name jen_container -p 8089:80 jenkins3108:latest'
                }
            }
        }
    }
}
