def DOCKER_IMAGE = "malikalrk/java"
def DOCKER_TAG = "latest"
def CLUSTER = "k3d-mycluster"
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
                docker build --cache-from $DOCKER_IMAGE:$BUILD_NUMBER -t ${DOCKER_IMAGE}:$BUILD_NUMBER .
                """
              }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                sh """
                docker push $DOCKER_IMAGE:$BUILD_NUMBER
                """
              }
            }
        }

        stage('kubeconfig') {
            steps {
                script {
                sh """
                kubectl config use-context $CLUSTER
                """
              }
            }
        }

        stage('Substitute Environment Variables') {
            steps {
                script {
                    sh '''
                        sed -i "s/\\\$DOCKER_IMAGE/${DOCKER_IMAGE}/g" manifest/deployment.yaml
                        sed -e "s/\$BUILD_NUMBER/${BUILD_NUMBER}/g" manifest/deployment.yaml
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                sh """
                kubectl apply -f manifest/deployment.yaml --context $CLUSTER
                """
              }
            }
        }
    }
}
