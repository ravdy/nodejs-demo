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
            /kaniko/executor --context `pwd` --destination public.ecr.aws/x2e7b0r9/nodeapplication/hello-kaniko:1.1      
          '''
        }
      }
    }
    stage('deploy') {
      steps {
        script {
          docker.withRegistry(
            'https://<957288871734>.dkr.ecr.<us-east-1>.amazonaws.com',
            'ecr.<us-east-1>:<ccc00f54-cbca-4299-a54c-729a142faab2>'){
            def myImage = docker.Build( '<nodeapplication>')
            myImage.push('<latest>')
            }  
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
