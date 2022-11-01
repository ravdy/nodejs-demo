podTemplate(yaml: '''
    apiVersion: v1
    kind: Pod
    spec:
      containers:
      - name: nodejs
        image: thetips4you/nodeapp:latest
        command:
        - sleep
        args:
        - 999999
      - name: kubectl
        image: bitnami/kubectl
        command:
        - sleep
        args:
        - 9999999
      - name: kaniko
        image: gcr.io/kaniko-project/executor:debug
        command:
        - sleep
        args:
        - 9999999
        volumeMounts:
        - name: kaniko-secret
          mountPath: /kaniko/.docker
      restartPolicy: Never
      volumes:
      - name: kaniko-secret
        secret:
            secretName: dockercred
            items:
            - key: .dockerconfigjson
              path: config.json
''') {
  node(POD_LABEL) {
    stage('Get a nodejs project') {
      git url: 'https://github.com/PottaAkhil/nodejs-demo.git', branch: 'master'
      container('nodejs') {
        stage('Build a nodejs project') {
          sh '''
            echo pwd
          '''
        }
      }
    }

    stage('Build nodejs Image') {
      container('kaniko') {
        stage('Build a Go project') {
          sh '''
            /kaniko/executor --context `pwd` --destination success0510/hello-kaniko:1.1      
          '''
        }
      }
    }
     environment {
        registry = "public.ecr.aws/x2e7b0r9/nodeapplication"
    }
     stage('Pushing to ECR') {
     steps{  
         script {
                sh 'aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/x2e7b0r9'
                sh 'docker push public.ecr.aws/x2e7b0r9/nodeapplication:latest'
         }
        }
      }
    stage('Deploy to k8s') {
      container('kubectl') {
        stage('Deploy to K8s') {
          sh '''
            echo pwd && \
            kubectl apply -f  deploymentservice.yaml 
          '''  
      }
    }
  }
}
}
