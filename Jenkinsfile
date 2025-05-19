pipeline {
  agent any

  environment {
    DOCKERHUB_CREDENTIALS = credentials('Docker')
    DOCKER_HUB_REPO = 'danielaflalo/flask'  // Based on your log, this is the repo you're using
    DOCKER_HUB_TAG = latest
    APP_NAME = 'DanielJenkins'
    NAMESPACE = 'default'
  }
  stages {
    stage('Build') {
      steps {
        sh 'docker build -t $DOCKER_HUB_REPO:$DOCKER_HUB_TAG .'
      }
    }
    stage('Login') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }
    stage('Push') {
      steps {
        sh 'docker push $DOCKER_HUB_REPO:$DOCKER_HUB_TAG'
      }
    }
  }
  post {
    always {
      sh 'docker logout'
    }
  }
}
