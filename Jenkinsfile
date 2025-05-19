pipeline {
    agent any

    environment {
         // Define environment variables
         DOCKER_HUB_REPO = 'danielaflalo/jenkins'  // Based on your log, this is the repo you're using
         APP_NAME = 'DanielJenkins'
         NAMESPACE = 'default'
     }
    
    stages {
        stage('Stage 1') {
            steps {
                echo 'Hello world!' 
            }
        }
        stage('Stage 2') {
          steps {
            echo 'Stage 2!'
            }
        }
    }
}
