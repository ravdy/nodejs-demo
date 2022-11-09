podTemplate(yaml: '''
    apiVersion: v1
    kind: Pod
    spec:
      containers:
      - name: nodejs
        image: node:6-alpine
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
      git url: 'https://github.com/PottaAkhil/nodejs-OBT.git', branch: 'master'    
      container('nodejs') {
        stage('Build a nodejs project') {
          sh '''
            echo pwd
          '''
        }
      }
    }
    stage('SonarQube analysis') {
    def scannerHome = tool 'sonarqube';
    withSonarQubeEnv('sonarqube') {
      sh "${scannerHome}/bin/sonar-scanner \
      -D sonar.login=admin \
      -D sonar.password=admin \
      -D sonar.projectKey= nodejs \
      -D sonar.exclusions=vendor/**,resources/**,**/*.js \
      -D sonar.host.url=http://54.169.237.40:9000/"
    }
  }

    stage('Build nodejs Image') {
      container('kaniko') {
        stage('Build a Go project') {
          sh '''
            /kaniko/executor --context `pwd` --destination 957288871734.dkr.ecr.ap-southeast-1.amazonaws.com/images:$BUILD_NUMBER && \
             /kaniko/executor --context `pwd` --destination 957288871734.dkr.ecr.ap-southeast-1.amazonaws.com/images:latest
          '''
        }
      }
    }
    
  
}
}
