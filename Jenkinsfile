pipeline {
    agent any
    environment {
    DOCKERHUB_CREDENTIALS = credentials('docker')
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
        
        stage('Deploy to k8s') {
            steps{
                script{
                    withKubeConfig([credentialsId: 'k8s', serverUrl: 'https://9E2401C37C33CF9F28122CA7D450AA0B.yl4.us-west-2.eks.amazonaws.com']) {
                    sh ('kubectl apply -f  deploymentservice.yaml')  
                }
            }
        }
    }
}
}
