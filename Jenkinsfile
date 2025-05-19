pipeline {
  agent {
    kubernetes {
      label 'docker-agent'
      defaultContainer 'docker-cli'
      yaml """
apiVersion: v1
kind: Pod
spec:
  volumes:
    - name: dind-storage
      emptyDir: {}
    - name: docker-sock
      emptyDir: {}

  containers:
    - name: dind
      image: docker:24.0-dind
      securityContext:
        privileged: true
      env:
        # מבטל TLS כדי שה־socket יוּצָא ללא סיסמה
        - name: DOCKER_TLS_CERTDIR
          value: ""
      volumeMounts:
        - name: dind-storage
          mountPath: /var/lib/docker
        - name: docker-sock
          mountPath: /var/run/docker.sock

    - name: docker-cli
      image: docker:24.0-cli
      command:
        - cat
      tty: true
      volumeMounts:
        - name: docker-sock
          mountPath: /var/run/docker.sock
"""
    }
  }

  environment {
    DOCKERHUB_CREDENTIALS = credentials('Dockerhub')
    DOCKER_HUB_REPO      = 'danielaflalo/flask'
    DOCKER_HUB_TAG       = 'latest'
  }

  stages {
    stage('Build') {
      steps {
        sh "docker build -t ${DOCKER_HUB_REPO}:${DOCKER_HUB_TAG} ."
      }
    }
    stage('Push') {
      steps {
        sh """
          echo ${DOCKERHUB_CREDENTIALS_PSW} \
          | docker login -u ${DOCKERHUB_CREDENTIALS_USR} --password-stdin
        """
        sh "docker push ${DOCKER_HUB_REPO}:${DOCKER_HUB_TAG}"
      }
    }
  }
}
