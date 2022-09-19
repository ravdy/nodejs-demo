pipeline {
    agent any {label "docker-build-node" }
    environment {
    DOCKERHUB_CREDENTIALS = credentials('jothimanikandanraja-dockerhub')
    }
    stages { 
        stage('SCM Checkout') {
            steps{
            git 'https://github.com/jothishiva123/Test1.git'
            }
        }

        stage('Build docker image') {
            steps {  
                sh 'docker build -t jothimanikandanraja/mynewapp:$BUILD_NUMBER .'
            }
        }
        stage('login to dockerhub') {
            steps{
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }
        stage('push image') {
            steps{
                sh 'docker push jothimanikandanraja/mynewapp:$BUILD_NUMBER'
            }
        }
}
post {
        always {
            sh 'docker logout'
        }
    }
}

