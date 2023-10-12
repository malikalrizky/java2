def DOCKER_IMAGE = "malikalrk/java"
def DOCKER_TAG = "latest"
def CLUSTER = "minikube"
pipeline {
    agent any

    stages {

        stage('Docker Login') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh """
                        docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
                        """
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                sh """
                docker build --cache-from ${DOCKER_IMAGE}:${DOCKER_TAG} -t ${DOCKER_IMAGE}:${DOCKER_TAG} .
                """
              }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                sh """
                docker push ${DOCKER_IMAGE}:${DOCKER_TAG}
                """
              }
            }
        }

        stage('kubeconfig') {
            steps {
                script {
                sh """
                kubectl config use-context ${CLUSTER}
                """
              }
            }
        }

        stage('Deploy') {
            steps {
                script {
                sh """
                kubectl apply -f manifest/deployment.yaml --context ${CLUSTER}
                """
              }
            }
        }
    }
}
