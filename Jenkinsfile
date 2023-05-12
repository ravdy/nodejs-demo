pipeline {
    agent any
    stages { 
        
        stage('SCM Checkout') {
            steps{
            git 'https://github.com/Kchaubey/nodejs-demo.git'
            }
        }

        stage('Build docker image') {
            steps {  
                sh 'docker build -t my_docker_image .'
            }
        }
        stage('Run docker container') {
            steps{
                sh 'docker run -it --privileged --name my_container my_docker_image'
            }
       }
   }
}

