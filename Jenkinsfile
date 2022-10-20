pipeline {
    agent {label 'docker-node'}
    environment {
    DOCKERHUB_CREDENTIALS = credentials('docker-hub')
    }
    stages { 
        stage('SCM Checkout') {
            steps{
            git 'https://github.com/PottaAkhil/nodejs-demo.git'
            }
        }

        stage('Build docker image') {
            steps {  
                sh 'docker build -t success0510/nodeapp:$BUILD_NUMBER .'
            }
        }
        stage('login to dockerhub') {
            steps{
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }
        stage('push image') {
            steps{
                sh 'docker push success0510/nodeapp:$BUILD_NUMBER'
            }
        }
}
stage('Deploy to k8s'){
            steps{
                script{
                    kubernetesDeploy (configs: 'deploymentservice.yaml',kubeconfigId: 'k8s')
                }
            }
        }
    }

