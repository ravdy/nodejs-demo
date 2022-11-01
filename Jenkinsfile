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
        - 99d
      - name: kubectl
        image:kubernetes/pause:latest
        command:
        - sleep
        args:
        - 99d  
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
      git url: 'https://github.com/PottaAkhil/nodejs-demo.git', branch: 'main'
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
            /kaniko/executor --context `pwd` --destination bibinwilson/hello-kaniko:1.0
    stage('Deploy to k8s') {
            steps{
                script{
                    withKubeConfig([credentialsId: 'k8s', serverUrl: 'https://525069FDBB7B3C7A8D6D4162E0F9585C.yl4.ap-southeast-1.eks.amazonaws.com']) {
                    sh ('kubectl apply -f  deploymentservice.yaml')        
          '''
        }
      }
    }
   }
  }
