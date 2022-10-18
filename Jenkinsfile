pipeline {
    agent { labe1 "docker-node" }
    environment {
    DOCKERHUB_CREDENTIALS = credentials('docker-hub-login')
    }
    stages { 
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
post {
        always {
            sh 'docker logout'
        }
    }
}
