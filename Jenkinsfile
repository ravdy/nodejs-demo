pipeline {
    agent any 
    environment {
    DOCKERHUB_CREDENTIALS = credentials('kandula-dockerhub')
    BRANCH = "${env.GIT_BRANCH}"
    TAG = "${env.BRANCH}.${env.${env.BUILD_NUMBER}".drop(15)
    DEV_TAG = "${env.BRANCH}.${env.BUILD_NUMBER}".drop(7)
    MASTER_TAG = "${env.BRANCH}.${env.BUILD_NUMBER}".drop(7)
    VERSION = "${env.TAG}
    }
    
    stages { 
        stage('SCM Checkout') {
            steps{
            git 'https://github.com/kandula1578/nodejs.git'
            }
        }
        
    stage("list environment variables") {
        steps {
            sh "printenv | sort"
            echo "${DEV_TAG}.latest"
            script{
                if (BRANCH.contains ('origin/master')) {
                    echo 'branch is develop'
                    $VERSION = "${env.DEV_TAG}.latest"]
                    echo "${env.VERSION}"
                }
                if (BRANCH.contains ('origin/develop')) {
                    echo 'branch is develop'
                    $VERSION = "${env.DEV_TAG}.latest"]
                    echo "${env.VERSION}"
                }
            }
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
