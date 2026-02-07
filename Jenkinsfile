pipeline {
    agent any

    environment {
        IMAGE_NAME = "gouthamkumarsai/auro-travelguide"
        IMAGE_TAG  = "${BUILD_NUMBER}"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/goutham1646/Auro-TravelGuide.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                  docker build -t $IMAGE_NAME:$IMAGE_TAG .
                  docker tag $IMAGE_NAME:$IMAGE_TAG $IMAGE_NAME:latest
                '''
            }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: '90b9e751-84c5-46ce-8de8-900f9348a74f',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PAT'
                )]) {
                    sh 'docker login -u $DOCKER_USER -p $DOCKER_PAT'
                }
            }
        }

        stage('Push Image') {
            steps {
                sh '''
                  docker push $IMAGE_NAME:$IMAGE_TAG
                  docker push $IMAGE_NAME:latest
                '''
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl set image deployment/auro-travelguide web=$IMAGE_NAME:$IMAGE_TAG'
            }
        }
    }
}

