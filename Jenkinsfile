pipeline {
    agent any 
    environment {
    DOCKERHUB_CREDENTIALS = credentials('kandula-dockerhub')
    BRANCH = "${env.GIT_BRANCH}"
    TAG = BRANCH.substring(0,4)
    }
    
    stages { 
        stage('SCM Checkout') {
            steps{
            git 'https://github.com/kandula1578/nodejs.git'
            }
        }     
        
        stage('Build docker image') {
            steps { 
//                 script {
//                     def BRANCH = sh(returnStdout: true, script: 'git rev-parse --abbrev-ref HEAD').trim()
//                     echo ${BRANCH}
//                 }
                    sh 'docker build -t kandula17/nodeapp:$TAG .'                
            }
        }
        stage('login to dockerhub') {
            steps{
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }
        stage('push image') {
            steps{
//                 script {
//                     def BRANCH = sh(returnStdout: true, script: 'git rev-parse --abbrev-ref HEAD').trim()
//                     echo ${BRANCH}
//                 }
                    sh 'docker push -t kandula17/nodeapp:$TAG'                
            }
        }
}
post {
        always {
            sh 'docker logout'
        }
    }
}
