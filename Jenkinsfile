pipeline {
  agent any

  environment {
    DOCKERHUB_CREDENTIALS = credentials('Docker')
    DOCKER_HUB_REPO        = 'danielaflalo/flask'   // your DockerHub repo
    DOCKER_HUB_TAG         = 'latest'
    APP_NAME               = 'DanielJenkins'
    NAMESPACE              = 'default'
  }
  
  stages {
    stage('Build') {
      steps {
        // build the image
        sh 'docker build -t danielaflalo/flask:latest .'
      }
    }
    
    stage('Login') {
      steps {
        // login using the credentials binding
        sh """
          echo ${DOCKERHUB_CREDENTIALS_PSW} \
          | docker login -u ${DOCKERHUB_CREDENTIALS_USR} --password-stdin
        """
      }
    }
    
    stage('Push') {
      steps {
        // push the image
        sh "docker push ${DOCKER_HUB_REPO}:${DOCKER_HUB_TAG}"
      }
    }
  }
}
