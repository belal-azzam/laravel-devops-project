pipeline {
  environment {
    registry = "belalazzam/laravel-devops"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/belal-azzam/laravel-devops-project'
      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Image Validation') {
      steps{
        sh 'docker run -it belalazzam/laravel-devops' + ":$BUILD_NUMBER" + ' find . -type f -not -path "./vendor/*" -name "*.php" -exec php -l {} \\; |grep -v "No syntax errors detected"'
      }
    }
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
  }
}