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

  containers:
    - name: dind
      image: docker:24.0-dind
      securityContext:
        privileged: true
      env:
        # disable TLS so dockerd will listen on plain TCP + socket
        - name: DOCKER_TLS_CERTDIR
          value: ""
      args:
        # have the daemon listen on 0.0.0.0:2375
        - --host=tcp://0.0.0.0:2375
      volumeMounts:
        - name: dind-storage
          mountPath: /var/lib/docker

    - name: docker-cli
      image: docker:24.0-cli
      command:
        - cat
      tty: true
      env:
        # point the CLI at our DinD side-car
        - name: DOCKER_HOST
          value: tcp://localhost:2375
      volumeMounts:
        - name: dind-storage
          mountPath: /var/lib/docker
"""
    }
  }

  environment {
    DOCKERHUB_CREDENTIALS = credentials('Dockerhub')
    DOCKER_HUB_REPO      = 'danielaflalo/flask'
    DOCKER_HUB_TAG       = 'latest'
  }

  stages {
    stage('Wait for Docker') {
      steps {
        // wait until the DinD daemon is up and answering
        sh '''
          until docker version &> /dev/null; do
            echo "Waiting for Docker daemon…"
            sleep 1
          done
        '''
      }
    }
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
