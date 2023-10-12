def DOCKER_IMAGE = "java"
def DOCKER_TAG = "latest"
def CLUSTER = "k3d-mycluster"
def KUBE_CONFIG = "/home/malik/.kube/config"
pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                sh """
                docker build --cache-from ${DOCKER_IMAGE}:${DOCKER_TAG} -t ${DOCKER_IMAGE}:${DOCKER_TAG} .
                """
              }
            }
        }

        // stage('Push Docker Image') {
        //     steps {
        //         script {
        //         sh """
        //         docker push ${DOCKER_IMAGE}:${DOCKER_TAG}
        //         """
        //       }
        //     }
        // }

        stage('kubeconfig') {
            steps {
                script {
                sh """
                kubectl config use-context ${CLUSTER} --kubeconfig=${KUBE_CONFIG}
                """
              }
            }
        }

        stage('Deploy') {
            steps {
                script {
                sh """
                kubectl apply -f manifest/deployment.yaml --context --kubeconfig=${CLUSTER} ${KUBE_CONFIG}
                """
              }
            }
        }
    }
}
