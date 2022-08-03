pipeline {
    agent any 
    environment {
    DOCKERHUB_CREDENTIALS = credentials('kandula-dockerhub')
    BRANCH = "${env.GIT_BRANCH}"
    TAG = "${env.BRANCH}.${env.COMMIT_HASH}.${env.BUILD_NUMBER}".drop(15)
    DEV_TAG = "${env.BRANCH}.${env.COMMIT_HASH}.${env.BUILD_NUMBER}".drop(7)
    MASTER_TAG = "${env.BRANCH}.${env.COMMIT_HASH}.${env.BUILD_NUMBER}".drop(7)    
    }
    stages { 
        stage('SCM Checkout') {
            steps{
            git 'https://github.com/kandula1578/nodejs.git'
            }
        }
        
        stage("checkout") {
            when {
                    branch "origin/dev"
                    branch "origin/master"
                }
            steps {
                sh "printenv | sort"
                echo "Dev Tag is -- ${env.DEV_TAG}"
                echo "Master Tag is --${env.MASTER_TAG}"
                echo "Version is -- ${env.$VERSION}"
            }
        }
        
        stage('Build docker image') {
            steps {  
                sh 'docker build -t kandula17/nodeapp:$BRANCH .'
            }
        }
        stage('login to dockerhub') {
            steps{
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }
        stage('push image') {
            steps{
                sh 'docker push kandula17/nodeapp:$BRANCH'
            }
        }
}
post {
        always {
            sh 'docker logout'
        }
    }
}
