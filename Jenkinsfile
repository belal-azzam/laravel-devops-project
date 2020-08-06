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
    stage('Linting PHP') {
      steps{
        sh 'docker run --rm belalazzam/laravel-devops' + ":$BUILD_NUMBER" + ' /scripts/lintphp.sh /var/www/html/app'
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